# virtual environment section
venv_section() {
	
	VENV_SYMBOL_COLOR=114
	VENV_SECTION_END_SYMBOL="弄"

	VENV_BACKGROUND_COLOR=235

	if [[ $CONDA_DEFAULT_ENV ]]; then
		VENV_SYMBOL=""
		PROMPT_ENV="%K{$VENV_BACKGROUND_COLOR} %F{$VENV_SYMBOL_COLOR}$VENV_SYMBOL $CONDA_PROMPT_MODIFIER%f%k%F{$VENV_SYMBOL_COLOR}${VENV_SECTION_END_SYMBOL}%f"
	elif [[ $VIRTUAL_ENV ]]; then
		VENV_SYMBOL=""
		PIPENV_NAME=$(basename $VIRTUAL_ENV)
		PROMPT_ENV="%K{$VENV_BACKGROUND_COLOR} %F{$VENV_SYMBOL_COLOR}$VENV_SYMBOL $PIPENV_NAME%f%k %F{$VENV_SYMBOL_COLOR}${VENV_SECTION_END_SYMBOL}%f"
	else
		PROMPT_ENV=""
	fi

}

# user section
user_section() {
	USER_SYMBOL=""
	USER_SYMBOL_COLOR=81

	USER_NAME=""
	USER_NAME_COLOR=81

	PROMPT_USER="%K{235} %F{$USER_SYMBOL_COLOR}$USER_SYMBOL%F{$USER_NAME_COLOR}$USER_NAME%f %k"
}


# dir section
dir_section() {
	DIR_SYMBOL=""
	DIR_SYMBOL_COLOR=220

	DIR_NAME="%1~"
	DIR_NAME_COLOR=256

	PROMPT_DIR="%K{$PROMPT_SECTION_BGCOLOR} %F{$DIR_SYMBOL_COLOR}$DIR_SYMBOL%f  %F{$DIR_NAME_COLOR}$DIR_NAME%f %k"
}


git_section() {
	GIT_BRANCH=$(git symbolic-ref --short HEAD 2> /dev/null)
	if [[ ! $GIT_BRANCH ]]; then
		PROMPT_GIT=""
	else
		GIT_BRANCH_COLOR=256

		if [[ $(git status -s | sed q) ]] {
			GIT_BRANCH_COLOR=220
		}

		PROMPT_GIT="%K{$PROMPT_SECTION_BGCOLOR} %F{202}%f %F{$GIT_BRANCH_COLOR}$GIT_BRANCH%f %k"
	fi
}


# command section
command_section() {
	COMMAND_SYMBOL=""
	COMMAND_SYMBOL_COLOR=256

	PROMPT_COMMAND="%F{$COMMAND_SYMBOL_COLOR}$COMMAND_SYMBOL%f "
}


generate_prompt() {
	PROMPT_SECTION_BGCOLOR=237

	venv_section
	user_section
	dir_section
	git_section

	command_section

	PROMPT="$PROMPT_ENV$PROMPT_USER $PROMPT_DIR $PROMPT_GIT
$PROMPT_COMMAND"
}

generate_right_prompt() {
	if [[ $last_status -eq 0 ]]
	then
		STATUS_SYMBOL=""
		STATUS_COLOR=40
	else
		STATUS_SYMBOL=""
		STATUS_COLOR=196
	fi

	RPROMPT="%F{$STATUS_COLOR}$STATUS_SYMBOL %f %F{250}%w %*%f"
}

prompt() {
	last_status=$?
	generate_prompt
	generate_right_prompt
}





