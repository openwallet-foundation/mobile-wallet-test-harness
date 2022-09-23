#!/bin/bash
#
# This is a rather minimal example Argbash potential
# Example taken from http://argbash.readthedocs.io/en/stable/example.html
#
# ARG_POSITIONAL_SINGLE([results_location],[location of the generated allure results],[])
# ARG_POSITIONAL_SINGLE([allure_server],[URL of the Allure Server],[])
# ARG_OPTIONAL_SINGLE([test_project],[p],[Name of the project in the Allure Service to send results to])
# ARG_POSITIONAL_SINGLE([admin_user],[Username of the Allure Administrator],[])
# ARG_POSITIONAL_SINGLE([admin_pw],[Password of the Allure Administrator],[])
# ARG_HELP([This script is used to send Allure generated test results up to the AATH Allure Server for formal reporting])
# ARGBASH_GO()
# needed because of Argbash --> m4_ignore([
### START OF CODE GENERATED BY Argbash v2.9.0 one line above ###
# Argbash is a bash code generator used to get arguments parsing right.
# Argbash is FREE SOFTWARE, see https://argbash.io for more info
# Generated online by https://argbash.io/generate


# # When called, the process ends.
# Args:
# 	$1: The exit message (print to stderr)
# 	$2: The exit code (default is 1)
# if env var _PRINT_HELP is set to 'yes', the usage is print to stderr (prior to $1)
# Example:
# 	test -f "$_arg_infile" || _PRINT_HELP=yes die "Can't continue, have to supply file as an argument, got '$_arg_infile'" 4
die()
{
	local _ret="${2:-1}"
	test "${_PRINT_HELP:-no}" = yes && print_help >&2
	echo "$1" >&2
	exit "${_ret}"
}


# Function that evaluates whether a value passed to it begins by a character
# that is a short option of an argument the script knows about.
# This is required in order to support getopts-like short options grouping.
begins_with_short_option()
{
	local first_option all_short_options='ph'
	first_option="${1:0:1}"
	test "$all_short_options" = "${all_short_options/$first_option/}" && return 1 || return 0
}

# THE DEFAULTS INITIALIZATION - POSITIONALS
# The positional args array has to be reset before the parsing, because it may already be defined
# - for example if this script is sourced by an argbash-powered script.
_positionals=()
# THE DEFAULTS INITIALIZATION - OPTIONALS
_arg_test_project=


# Function that prints general usage of the script.
# This is useful if users asks for it, or if there is an argument parsing error (unexpected / spurious arguments)
# and it makes sense to remind the user how the script is supposed to be called.
print_help()
{
	printf '%s\n' "This script is used to send Allure generated test results up to the AATH Allure Server for formal reporting"
	printf 'Usage: %s [-p|--test_project <arg>] [-h|--help] <results_location> <allure_server>\n' "$0"
	printf '\t%s\n' "<results_location>: location of the generated allure results"
	printf '\t%s\n' "<allure_server>: URL of the Allure Server"
	printf '\t%s\n' "<admin_user>: Username of the Allure Administrator"
	printf '\t%s\n' "<admin_pw>: Password of the Allure Administrator"
	printf '\t%s\n' "-p, --test_project: Name of the project in the Allure Service to send results to (no default)"
	printf '\t%s\n' "-h, --help: Prints help"
}


# The parsing of the command-line
parse_commandline()
{
	_positionals_count=0
	while test $# -gt 0
	do
		_key="$1"
		case "$_key" in
			# We support whitespace as a delimiter between option argument and its value.
			# Therefore, we expect the --test_project or -p value.
			# so we watch for --test_project and -p.
			# Since we know that we got the long or short option,
			# we just reach out for the next argument to get the value.
			-p|--test_project)
				test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
				_arg_test_project="$2"
				shift
				;;
			# We support the = as a delimiter between option argument and its value.
			# Therefore, we expect --test_project=value, so we watch for --test_project=*
			# For whatever we get, we strip '--test_project=' using the ${var##--test_project=} notation
			# to get the argument value
			--test_project=*)
				_arg_test_project="${_key##--test_project=}"
				;;
			# We support getopts-style short arguments grouping,
			# so as -p accepts value, we allow it to be appended to it, so we watch for -p*
			# and we strip the leading -p from the argument string using the ${var##-p} notation.
			-p*)
				_arg_test_project="${_key##-p}"
				;;
			# The help argurment doesn't accept a value,
			# we expect the --help or -h, so we watch for them.
			-h|--help)
				print_help
				exit 0
				;;
			# We support getopts-style short arguments clustering,
			# so as -h doesn't accept value, other short options may be appended to it, so we watch for -h*.
			# After stripping the leading -h from the argument, we have to make sure
			# that the first character that follows coresponds to a short option.
			-h*)
				print_help
				exit 0
				;;
			*)
				_last_positional="$1"
				_positionals+=("$_last_positional")
				_positionals_count=$((_positionals_count + 1))
				;;
		esac
		shift
	done
}


# Check that we receive expected amount positional arguments.
# Return 0 if everything is OK, 1 if we have too little arguments
# and 2 if we have too much arguments
handle_passed_args_count()
{
	local _required_args_string="'results_location', 'allure_server', 'admin_user' and 'admin_pw'"
	test "${_positionals_count}" -ge 4 || _PRINT_HELP=yes die "FATAL ERROR: Not enough positional arguments - we require exactly 4 (namely: $_required_args_string), but got only ${_positionals_count}." 1
	test "${_positionals_count}" -le 4 || _PRINT_HELP=yes die "FATAL ERROR: There were spurious positional arguments --- we expect exactly 4 (namely: $_required_args_string), but got ${_positionals_count} (the last one was: '${_last_positional}')." 1
}


# Take arguments that we have received, and save them in variables of given names.
# The 'eval' command is needed as the name of target variable is saved into another variable.
assign_positional_args()
{
	local _positional_name _shift_for=$1
	_positional_names="_arg_results_location _arg_allure_server _arg_admin_user _arg_admin_pw "

	shift "$_shift_for"
	for _positional_name in ${_positional_names}
	do
		test $# -gt 0 || break
		eval "$_positional_name=\${1}" || die "Error during argument parsing, possibly an Argbash bug." 1
		shift
	done
}

# Now call all the functions defined above that are needed to get the job done
parse_commandline "$@"
handle_passed_args_count
assign_positional_args 1 "${_positionals[@]}"

# This directory is where you have all your results locally, generally named as `allure-results`
#ALLURE_RESULTS_DIRECTORY='../results'
ALLURE_RESULTS_DIRECTORY=$_arg_results_location
# This url is where the Allure container is deployed. We are using localhost as example
#ALLURE_SERVER='http://localhost:5050'
ALLURE_SERVER=$_arg_allure_server
# Project ID according to existent projects in your Allure container - Check endpoint for project creation >> `[POST]/projects`
#PROJECT_ID='acapy'
PROJECT_ID=$_arg_test_project
#PROJECT_ID='my-project-id'
# Set SECURITY_USER & SECURITY_PASS according to Allure container configuration
SECURITY_USER=$_arg_admin_user
SECURITY_PASS=$_arg_admin_pw

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
FILES_TO_SEND=$(ls -dp $DIR/$ALLURE_RESULTS_DIRECTORY/* | grep -v /$)
if [ -z "$FILES_TO_SEND" ]; then
  exit 1
fi

FILES=''
for FILE in $FILES_TO_SEND; do
  FILES+="-F files[]=@$FILE "
done

set -o xtrace

echo "------------------LOGGING-INTO-ALLURE-SERVICE------------------"
curl -X POST "$ALLURE_SERVER/allure-docker-service/login" \
  -H 'Content-Type: application/json' \
  -d "{
    "\""username"\"": "\""$SECURITY_USER"\"",
    "\""password"\"": "\""$SECURITY_PASS"\""
}" -c cookiesFile -ik

echo "------------------EXTRACTING-CSRF-ACCESS-TOKEN------------------"
CRSF_ACCESS_TOKEN_VALUE=$(cat cookiesFile | grep -o 'csrf_access_token.*' | cut -f2)
echo "csrf_access_token value: $CRSF_ACCESS_TOKEN_VALUE"


echo "------------------CLEANING-RESULTS------------------"
curl -X GET "$ALLURE_SERVER/allure-docker-service/clean-results?project_id=$PROJECT_ID" -H  "accept: */*" -b cookiesFile -ik

echo "------------------SEND-RESULTS------------------"
curl -X POST "$ALLURE_SERVER/allure-docker-service/send-results?project_id=$PROJECT_ID" \
  -H 'Content-Type: multipart/form-data' \
  -H "X-CSRF-TOKEN: $CRSF_ACCESS_TOKEN_VALUE" \
  -b cookiesFile $FILES -ik


# If you want to generate reports on demand use the endpoint `GET /generate-report` and disable the Automatic Execution >> `CHECK_RESULTS_EVERY_SECONDS: NONE`
echo "------------------GENERATE-REPORT------------------"
#RESPONSE=$(curl -X GET "$ALLURE_SERVER/allure-docker-service/generate-report?project_id=$PROJECT_ID&execution_name=$EXECUTION_NAME&execution_from=$EXECUTION_FROM&execution_type=$EXECUTION_TYPE" $FILES)
#RESPONSE=$(curl -X GET "$ALLURE_SERVER/allure-docker-service/generate-report?project_id=$PROJECT_ID" $FILES)
curl --silent --output /dev/null -X GET "$ALLURE_SERVER/allure-docker-service/generate-report?project_id=$PROJECT_ID" -H "X-CSRF-TOKEN: $CRSF_ACCESS_TOKEN_VALUE" -b cookiesFile $FILES
# ALLURE_REPORT=$(grep -o '"report_url":"[^"]*' <<< "$RESPONSE" | grep -o '[^"]*$')

#OR You can use JQ to extract json values -> https://stedolan.github.io/jq/download/
#ALLURE_REPORT=$(echo $RESPONSE | jq '.data.report_url')