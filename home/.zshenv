export EDITOR=vim
export SHELL=zsh

# Settings for less: quit if only 1 screen of text, output color control
# characters in raw format and do not clear screen when starting/quitting less
export LESS='--no-init --quit-if-one-screen --raw-control-chars'

# Colors for ls (in case ~/bin/LS_COLORS is missing or dircolors isn't installed)
export LSCOLORS=ExGxcxdxCxegedabagacad

# FZF
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export FZF_COMPLETION_TRIGGER='~~'

# ripgrep
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc

# Homebrew
export HOMEBREW_NO_EMOJI=1
export HOMEBREW_NO_ANALYTICS=1 # https://docs.brew.sh/Analytics

# Disable metrics and advertising of various programs
# (but honestly, these things should be opt-in)
## Initiative for a standard to stop tracking, not really adopted yet
## More info: https://consoledonottrack.com/
export DO_NOT_TRACK=1
## For Chronograf, and possibly others because of the generic name
export REPORTING_DISABLED=1
## For npm but unsure if this still does anything
export ADBLOCK=true
## Also for npm packages. Different packages check for different variables
## More info: https://gist.github.com/ugultopu/24b681d2c9a2475b649398d8fb790ca1
export OPENCOLLECTIVE_HIDE=true
export DISABLE_OPENCOLLECTIVE=true
## /
export NEXT_TELEMETRY_DISABLED=1          # https://nextjs.org/telemetry
export AZURE_CORE_COLLECT_TELEMETRY=false # https://docs.microsoft.com/en-us/cli/azure/azure-cli-configuration#cli-configuration-values-and-environment-variables
export DOTNET_CLI_TELEMETRY_OPTOUT=1      # https://docs.microsoft.com/en-us/dotnet/core/tools/telemetry#how-to-opt-out
export GATSBY_TELEMETRY_DISABLED=1        # https://www.gatsbyjs.com/docs/telemetry/
export SAM_CLI_TELEMETRY=0                # https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-telemetry.html
export VCPKG_DISABLE_METRICS=1            # https://github.com/microsoft/vcpkg/blob/master/docs/about/privacy.md
export NPM_CONFIG_FUND=false              # https://github.com/npm/cli/issues/595#issuecomment-565929067
export INFLUXDB_REPORTING_DISABLED=1      # https://docs.influxdata.com/influxdb/v1.8/administration/config/#reporting-disabled--false
export export SEMGREP_SEND_METRICS=off    # https://github.com/returntocorp/semgrep/pull/3874

# Apply local environments, such as custom PATHs. This file is not stored in the dotfiles repository.
if [[ -e $HOME/.zshenv.local ]]; then
	source $HOME/.zshenv.local
fi
