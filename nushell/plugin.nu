register $home/.cargo/bin/nu_plugin_clipboard  {
  "sig": {
    "name": "clipboard copy",
    "usage": "copy the input into the clipboard",
    "extra_usage": "",
    "search_terms": [],
    "required_positional": [],
    "optional_positional": [],
    "rest_positional": null,
    "named": [
      {
        "long": "help",
        "short": "h",
        "arg": null,
        "required": false,
        "desc": "Display the help message for this command",
        "var_id": null,
        "default_value": null
      },
      {
        "long": "enable-daemon",
        "short": "d",
        "arg": null,
        "required": false,
        "desc": "cause copy action to enable the daemon feature (open a process in background), this fixes some errors in some Desktop environments if you are OK without it don't use it",
        "var_id": null,
        "default_value": null
      }
    ],
    "input_output_types": [
      [
        "String",
        "String"
      ]
    ],
    "allow_variants_without_examples": false,
    "is_filter": false,
    "creates_scope": false,
    "allows_unknown_args": false,
    "category": "Experimental"
  },
  "examples": []
}

register /home/robert/.cargo/bin/nu_plugin_clipboard  {
  "sig": {
    "name": "clipboard paste",
    "usage": "outputs the current value in clipboard",
    "extra_usage": "",
    "search_terms": [],
    "required_positional": [],
    "optional_positional": [],
    "rest_positional": null,
    "named": [
      {
        "long": "help",
        "short": "h",
        "arg": null,
        "required": false,
        "desc": "Display the help message for this command",
        "var_id": null,
        "default_value": null
      }
    ],
    "input_output_types": [
      [
        "Nothing",
        "String"
      ]
    ],
    "allow_variants_without_examples": false,
    "is_filter": false,
    "creates_scope": false,
    "allows_unknown_args": false,
    "category": "Experimental"
  },
  "examples": []
}

register /home/robert/.cargo/bin/nu_plugin_gstat  {
  "sig": {
    "name": "gstat",
    "usage": "Get the git status of a repo",
    "extra_usage": "",
    "search_terms": [],
    "required_positional": [],
    "optional_positional": [
      {
        "name": "path",
        "desc": "path to repo",
        "shape": "Filepath",
        "var_id": null,
        "default_value": null
      }
    ],
    "rest_positional": null,
    "named": [
      {
        "long": "help",
        "short": "h",
        "arg": null,
        "required": false,
        "desc": "Display the help message for this command",
        "var_id": null,
        "default_value": null
      }
    ],
    "input_output_types": [],
    "allow_variants_without_examples": false,
    "is_filter": false,
    "creates_scope": false,
    "allows_unknown_args": false,
    "category": {
      "Custom": "prompt"
    }
  },
  "examples": []
}

