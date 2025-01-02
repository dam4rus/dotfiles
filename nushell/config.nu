
$env.config.show_banner = false
$env.config.edit_mode = "vi" # emacs, vi
$env.config.cursor_shape.vi_insert = "block" # block, underscore, line, blink_block, blink_underscore, blink_line, inherit to skip setting cursor shape (block is the default)
$env.config.cursor_shape.vi_normal = "underscore" # block, underscore, line, blink_block, blink_underscore, blink_line, inherit to skip setting cursor shape (underscore is the default)

use themes/nu-themes/catppuccin-mocha.nu
$env.config.color_config = catppuccin-mocha # if you want a more interesting theme, you can replace the empty record with `$dark_theme`, `$light_theme` or another custom record

$env.config.hooks.pre_prompt ++= [{ ||
  if (which direnv | is-empty) {
    return
	}

	direnv export json | from json | default {} | load-env
}]
$env.config.keybindings ++= [{
	name: change_dir_with_fzf
	modifier: CONTROL
	keycode: char_t
	mode: emacs
	event: {
		send: executehostcommand,
		cmd: "z (ls ** | where type == dir | each { |it| $it.name} | str join (char nl) | fzf | decode utf-8 | str trim)"
	}
},
{
    name: fuzzy_history
        modifier: control
        keycode: char_r
        mode: [emacs vi_insert, vi_normal]
        event: {
        send: executehostcommand
    		cmd: "commandline edit -r (history | reverse | each { |it| $it.command } | uniq | str join (char nl) | fzf --layout=reverse --height=40% -q (commandline) | decode utf-8 | str trim)"
	}
},
{
	name: git_switch
	modifier: control
	keycode: char_b
	mode: [emacs, vi_insert, vi_normal]
	event: [
		{ edit: InsertString value: "git switch " }
		{ send: menu name: completion_menu }
	]
}]

let carapace_completer = {|spans|
    match $spans.0 {
        "hc-tm" => ((^hc-tm _carapace nushell ...$spans e> /dev/null) | from json)
        "hc-ttm" => ((^hc-ttm _carapace nushell ...$spans e> /dev/null) | from json)
        "hc-lm" => ((^hc-lm _carapace nushell ...$spans e> /dev/null) | from json)
        _ => (carapace $spans.0 nushell ...$spans | from json)
    }
}
$env.config.completions.external.completer = $carapace_completer

$env.COLORTERM = "truecolor"

source ~/.zoxide.nu
use ~/.cache/starship/init.nu
source ~/.cache/carapace/init.nu
use go.nu *
use gitv2 *
use kubernetes
use custom-completions/zellij/zellij-completions.nu *
use custom-completions/pytest/pytest-completions.nu *
use custom-completions/poetry/poetry-completions.nu *
# use custom-completions/go/go.nu *

alias cat = bat --plain
alias .j = just --justfile ~/.user.justfile --working-directory .
export def glo [] {
	gl | select sha refs message 
}
use ~/.local.nu *

$env.ASDF_DIR = (brew --prefix asdf | str trim | into string | path join 'libexec')
source /opt/homebrew/opt/asdf/libexec/asdf.nu
