using build
class Build : build::BuildPod
{
  new make()
  {
    podName = "FizzBuzz"
    summary = ""
    srcDirs = [`test/`, `fan/`]
    depends = ["sys 1.0"]
  }
}
