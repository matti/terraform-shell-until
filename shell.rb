require 'json'

class String
  def any?
    !self.empty?
  end
end

params = JSON.parse(STDIN.read)

desired_exit_status = params["exit_status_must_equal"].to_i unless params["exit_status_must_equal"].to_s == ""

tries = 0
loop do
  tries = tries + 1
  stdout = `#{params["command"]}`
  exit_status = $?.exitstatus

  exit_status_satisfied = if desired_exit_status
    exit_status == desired_exit_status
  end

  stdout_satisfied = if params["stdout_must_include"].any?
    stdout.include?(params["stdout_must_include"])
  elsif params["stdout_must_not_include"].any?
    !stdout.include?(params["stdout_must_not_include"])
  end

  satisfied = if desired_exit_status && (params["stdout_must_include"].any? || params["stdout_must_not_include"].any?)
    true if exit_status_satisfied && stdout_satisfied
  elsif desired_exit_status
    true if exit_status_satisfied
  elsif (params["stdout_must_include"].any? || params["stdout_must_not_include"].any?)
    true if stdout_satisfied
  else
    STDERR.puts "No exit condition specified, would run forever."
    exit 1
  end

  if satisfied
    result = {
      stdout: stdout,
      exit_status: exit_status.to_s,
      tries: tries.to_s,
      exit_status_satisfied: exit_status_satisfied.to_s,
      stdout_satisfied: stdout_satisfied.to_s
    }

    puts result.to_json
    break
  end

  if params["max_tries"].any? && params["max_tries"].to_i == tries
    STDERR.puts "max_tries (#{params["max_tries"]}) reached"
    exit 1
  end

  if params["interval"].any?
    sleep params["interval"].to_i
  else
    sleep 1
  end
end
