part of build_tools.build_utils;

var _stdin = stdin.asBroadcastStream();

Future<int> exec(String executable, List<String> arguments, {String
    workingDirectory, Map<String, String> environment, bool
    includeParentEnvironment: true, bool runInShell: false}) {
  return new Future<int>(() {
    print("$executable ${arguments.join(" ")}");
    return Process.start(executable, arguments, workingDirectory:
        workingDirectory, environment: environment, includeParentEnvironment:
        includeParentEnvironment, runInShell: runInShell).then((process) {
      process.stderr.listen(stderr.add);
      process.stdout.listen(stdout.add);
      _stdin.listen(process.stdin.add);
      return process.exitCode;
    });
  });
}
