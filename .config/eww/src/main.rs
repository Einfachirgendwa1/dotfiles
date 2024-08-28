use std::{
    env,
    error::Error as StdError,
    fmt::Display,
    io::{BufRead, BufReader},
    os::unix::net::UnixStream,
    process::Command,
};

#[cold]
fn cold() {}

#[derive(Debug)]
struct Error(String);

impl Display for Error {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(f, "{}", self.0)
    }
}

impl<A: StdError> From<A> for Error {
    fn from(value: A) -> Self {
        Self(value.to_string())
    }
}

trait ToMyError {
    fn to_my_error(self) -> Error;
}

impl ToMyError for &str {
    fn to_my_error(self) -> Error {
        Error(self.to_string())
    }
}

fn main() {
    for line in BufReader::new(
        UnixStream::connect(&format!(
            "{}/hypr/{}/.socket2.sock",
            env::var("XDG_RUNTIME_DIR").unwrap(),
            env::var("HYPRLAND_INSTANCE_SIGNATURE").unwrap(),
        ))
        .unwrap(),
    )
    .lines()
    {
        match hyprland_clients() {
            Ok(val) => println!("(box :height 50 :spacing 5 :halign \"center\" {val})"),
            Err(err) => eprintln!("{err}"),
        }
    }
}

fn hyprland_clients() -> Result<String, Error> {
    let out = run("hyprctl -j clients")?;
    let out = jq_rs::run(".[].pid", &out)?;
    let mut ret = String::new();
    for client in out.split('\n') {
        if !client.is_empty() {
            let client = match get_name(client) {
                Ok(val) => val,
                Err(err) => {
                    eprintln!("{err}");
                    continue;
                }
            }
            .trim()
            .to_string();

            let val = match generate_app(&client, 40) {
                Ok(val) => val,
                Err(err) => {
                    eprintln!("{err}");
                    continue;
                }
            };
            ret.push_str(&val)
        }
    }
    Ok(ret)
}

#[inline]
fn get_name(pid: &str) -> Result<String, Error> {
    run(&format!("ps -p {pid} -o comm="))
}

#[inline]
fn generate_app(cmd: &str, size: u32) -> Result<String, Error> {
    let cmd = cmd.trim().to_lowercase();
    Ok(format!(
        "(app :imagepath \"{}\" :size {size} :cmd \"{cmd}\")",
        get_icon(&cmd)?,
    ))
}

#[inline]
fn get_icon(cmd: &str) -> Result<String, Error> {
    run(&format!("bash get_process_icon.sh {cmd}"))
}

fn run(cmd: &str) -> Result<String, Error> {
    let mut cmd_iter = cmd.split_whitespace();
    let out = Command::new(cmd_iter.next().unwrap())
        .args(cmd_iter)
        .output()?;

    if !out.status.success() {
        cold();
        Err("Non-zero exit.".to_my_error())
    } else {
        Ok(String::from_utf8(out.stdout)?)
    }
}
