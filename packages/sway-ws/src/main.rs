use std::env;
use swayipc::{Connection, Fallible};

fn get_focused_output(conn: &mut Connection) -> Fallible<String> {
    let outputs = conn.get_outputs()?;
    Ok(outputs.into_iter()
        .find(|o| o.focused)
        .map(|o| o.name)
        .unwrap_or_default())
}

fn get_focused_workspace(conn: &mut Connection) -> Fallible<i32> {
    let workspaces = conn.get_workspaces()?;
    Ok(workspaces.into_iter()
        .find(|w| w.focused)
        .map(|w| w.num)
        .unwrap_or(1))
}

fn main() -> Fallible<()> {
    let args: Vec<String> = env::args().collect();
    if args.len() < 2 {
        eprintln!("Usage: sway-ws <switch|move|mirror> [num]");
        std::process::exit(1);
    }

    let mut conn = Connection::new()?;
    let cmd = &args[1];

    match cmd.as_str() {
        "switch" => {
            let num: i32 = args.get(2).and_then(|s| s.parse().ok()).unwrap_or(1);
            let output = get_focused_output(&mut conn)?;
            let ws = if output == "HDMI-A-2" { num + 10 } else { num };
            conn.run_command(format!("workspace number {}", ws))?;
        }
        "move" => {
            let num: i32 = args.get(2).and_then(|s| s.parse().ok()).unwrap_or(1);
            let output = get_focused_output(&mut conn)?;
            let ws = if output == "HDMI-A-2" { num + 10 } else { num };
            conn.run_command(format!("move container to workspace number {}", ws))?;
        }
        "mirror" => {
            let current = get_focused_workspace(&mut conn)?;
            let target = if current <= 10 { current + 10 } else { current - 10 };
            conn.run_command(format!("move container to workspace {}", target))?;
            conn.run_command(format!("workspace {}", target))?;
        }
        _ => {
            eprintln!("Unknown command: {}", cmd);
            std::process::exit(1);
        }
    }

    Ok(())
}
