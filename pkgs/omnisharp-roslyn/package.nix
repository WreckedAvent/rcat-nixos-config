{
  lib,
  dotnetCorePackages,
  buildDotnetModule,
  fetchFromGitHub,
  runCommand,
  expect,
}:

let
  inherit (dotnetCorePackages) sdk_11_0 sdk_10_0 runtime_8_0;
in
let
  finalPackage = buildDotnetModule rec {
    pname = "omnisharp-roslyn";
    version = "2.0.1-beta.22";
    safe-version = "2.0.1";

    src = fetchFromGitHub {
      owner = "OmniSharp";
      repo = "omnisharp-roslyn";
      tag = "v${version}";
      hash = "sha256-9HHz27WgJrv6iODvXCMSJ4uYBegV1lYQh4voBWy03tQ=";
    };

    projectFile = "src/OmniSharp.Stdio.Driver/OmniSharp.Stdio.Driver.csproj";
    nugetDeps = ./deps.json;

    dotnet-sdk = sdk_11_0;
    dotnet-runtime = sdk_11_0;

    dotnetInstallFlags = [ "--framework net11.0" ];
    dotnetBuildFlags = [
      "--framework net11.0"
      "--no-self-contained"
    ];
    dotnetFlags = [
      # These flags are set by the cake build.
      "-property:PackageVersion=${safe-version}"
      "-property:AssemblyVersion=${safe-version}.0"
      "-property:FileVersion=${safe-version}.0"
      "-property:InformationalVersion=${safe-version}"
      "-property:RuntimeFrameworkVersion=${runtime_8_0.version}"
      "-property:RollForward=LatestMajor"
      "-feature:FileBasedProgram"
    ];

    postPatch = ''
      # Relax the version requirement
      rm global.json

      # Patch the project files so we can compile them properly
      for project in src/OmniSharp.Http.Driver/OmniSharp.Http.Driver.csproj src/OmniSharp.LanguageServerProtocol/OmniSharp.LanguageServerProtocol.csproj src/OmniSharp.Stdio.Driver/OmniSharp.Stdio.Driver.csproj; do
        substituteInPlace $project \
          --replace-fail '<RuntimeIdentifiers>win-x64;win-x86;win-arm64</RuntimeIdentifiers>' '<RuntimeIdentifiers>linux-x64;linux-arm64;osx-x64;osx-arm64</RuntimeIdentifiers>'
      done
    '';

    useDotnetFromEnv = true;
    executables = [ "OmniSharp" ];

    passthru = {
      tests =
        let
          with-sdk =
            sdk:
            runCommand "with-${if sdk ? version then sdk.version else "no"}-sdk"
              {
                nativeBuildInputs = [
                  finalPackage
                  sdk
                  expect
                ];
                meta.timeout = 60;
              }
              ''
                HOME=$TMPDIR
                expect <<"EOF"
                  spawn OmniSharp
                  expect_before timeout {
                    send_error "timeout!\n"
                    exit 1
                  }
                  expect ".NET Core SDK ${if sdk ? version then sdk.version else sdk_11_0.version}"
                  expect "{\"Event\":\"started\","
                  send \x03
                  expect eof
                  catch wait result
                  exit [lindex $result 3]
                EOF
                touch $out
              '';
        in
        {
          # Make sure we can run OmniSharp with any supported SDK version, as well as without
          with-net10-sdk = with-sdk sdk_10_0;
          with-net11-sdk = with-sdk sdk_11_0;
          no-sdk = with-sdk null;
        };

      updateScript = ./update.sh;
    };

    meta = {
      description = "OmniSharp based on roslyn workspaces";
      homepage = "https://github.com/OmniSharp/omnisharp-roslyn";
      changelog = "https://github.com/OmniSharp/omnisharp-roslyn/blob/v${version}/CHANGELOG.md";
      sourceProvenance = with lib.sourceTypes; [
        fromSource
        binaryNativeCode # dependencies
      ];
      license = lib.licenses.mit;
      maintainers = with lib.maintainers; [
        corngood
        ericdallo
        gepbird
        mdarocha
        tesq0
      ];
      mainProgram = "OmniSharp";
    };
  };
in
finalPackage
