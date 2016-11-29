#!/bin/bash

check_cheating()
{
	clang -Wextra -Wall -Werror ${PATH_LIBFT}/$1 ${PATH_TEST}/main_check_cheating.c ${PATH_LIBFT}/libft.a
	CHEAT_VAR=$(nm ${PATH_TEST}/a.out | grep U | tr -d ' ' | grep -v main | grep -v dyld | grep -v chk | grep -v FRAME | grep -v abort | grep -v raise)
	printf "\033[${CHEAT_COL}G"
	param2=$2
	while [ $param2 -gt 0 ]
	do
		if [ $param2 -ge ${num_sys_func[2]} ]
		then
			CHEAT_VAR=$(echo "${CHEAT_VAR}" | grep -v ${system_func[4]})
			param2=$(($param2 - ${num_sys_func[2]}))
		elif [ $param2 -ge ${num_sys_func[1]} ]
		then
			CHEAT_VAR=$(echo "${CHEAT_VAR}" | grep -v ${system_func[2]})
			param2=$(($param2 - ${num_sys_func[1]}))
		elif [ $param2 -ge ${num_sys_func[0]} ]
		then
			CHEAT_VAR=$(echo "${CHEAT_VAR}" | grep -v ${system_func[1]})
			param2=$(($param2 - ${num_sys_func[0]}))
		fi
	done
	if [ "${CHEAT_VAR}" != "" ]
	then
		printf "${COLOR_FAIL}not clean${DEFAULT}"
		printf "Forbidden function call in '$1':\n" >> ${PATH_DEEPTHOUGHT}/deepthought
		printf "${CHEAT_VAR}\n\n" >> ${PATH_DEEPTHOUGHT}/deepthought
		retvalue=1
	else
		printf "${COLOR_OK}clean${DEFAULT}"
		retvalue=0
	fi
	return "$retvalue"
}
