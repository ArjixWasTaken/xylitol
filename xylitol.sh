#!/usr/bin/env bash
# Written in [Amber](https://amber-lang.com/)
# version: 0.4.0-alpha
# date: 2025-11-28 10:26:52
replace__0_v0() {
    local source=$1
    local search=$2
    local replace=$3
    __AF_replace0_v0="${source//${search}/${replace}}";
    return 0
}
split__3_v0() {
    local text=$1
    local delimiter=$2
    __AMBER_ARRAY_0=();
    local result=("${__AMBER_ARRAY_0[@]}")
     IFS="${delimiter}" read -rd '' -a result < <(printf %s "$text") ;
    __AS=$?
    __AF_split3_v0=("${result[@]}");
    return 0
}
join__6_v0() {
    local list=("${!1}")
    local delimiter=$2
    __AMBER_VAL_1=$( IFS="${delimiter}" ; echo "${list[*]}" );
    __AS=$?;
    __AF_join6_v0="${__AMBER_VAL_1}";
    return 0
}
parse_number__12_v0() {
    local text=$1
     [ -n "${text}" ] && [ "${text}" -eq "${text}" ] 2>/dev/null ;
    __AS=$?;
if [ $__AS != 0 ]; then
__AF_parse_number12_v0=''
return $__AS
fi
    __AF_parse_number12_v0="${text}";
    return 0
}
match_regex__17_v0() {
    local source=$1
    local search=$2
    local extended=$3
            replace__0_v0 "${search}" "/" "\/";
        __AF_replace0_v0__130_18="${__AF_replace0_v0}";
        search="${__AF_replace0_v0__130_18}"
        local output=""
        if [ ${extended} != 0 ]; then
            # GNU sed versions 4.0 through 4.2 support extended regex syntax,
            # but only via the "-r" option; use that if the version information
            # contains "GNU sed".
             re='\bCopyright\b.+\bFree Software Foundation\b'; [[ $(sed --version 2>/dev/null) =~ $re ]] ;
            __AS=$?
            local flag=$(if [ $(echo $__AS '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then echo "-r"; else echo "-E"; fi)
            __AMBER_VAL_2=$( echo "${source}" | sed "${flag}" -ne "/${search}/p" );
            __AS=$?;
            output="${__AMBER_VAL_2}"
else
            __AMBER_VAL_3=$( echo "${source}" | sed -ne "/${search}/p" );
            __AS=$?;
            output="${__AMBER_VAL_3}"
fi
        if [ $([ "_${output}" == "_" ]; echo $?) != 0 ]; then
            __AF_match_regex17_v0=1;
            return 0
fi
    __AF_match_regex17_v0=0;
    return 0
}
starts_with__20_v0() {
    local text=$1
    local prefix=$2
    __AMBER_VAL_4=$( if [[ "${text}" == "${prefix}"* ]]; then
    echo 1
  fi );
    __AS=$?;
    local result="${__AMBER_VAL_4}"
    __AF_starts_with20_v0=$([ "_${result}" != "_1" ]; echo $?);
    return 0
}

env_const_get__89_v0() {
    local name=$1
    __AMBER_VAL_5=$( echo ${!name} );
    __AS=$?;
if [ $__AS != 0 ]; then
__AF_env_const_get89_v0=''
return $__AS
fi;
    __AF_env_const_get89_v0="${__AMBER_VAL_5}";
    return 0
}
printf__99_v0() {
    local format=$1
    local args=("${!2}")
     args=("${format}" "${args[@]}") ;
    __AS=$?
     printf "${args[@]}" ;
    __AS=$?
}
echo_colored__105_v0() {
    local message=$1
    local color=$2
    __AMBER_ARRAY_6=("${message}");
    printf__99_v0 "\x1b[${color}m%s\x1b[0m
" __AMBER_ARRAY_6[@];
    __AF_printf99_v0__142_5="$__AF_printf99_v0";
    echo "$__AF_printf99_v0__142_5" > /dev/null 2>&1
}

# Perl Extensions Utilities
__AMBER_VAL_7=$( echo "$XYLITOL_USE_PERL" );
__AS=$?;
__0__perl_disabled=$([ "_${__AMBER_VAL_7}" != "_No" ]; echo $?)
__AMBER_VAL_8=$( command -v perl > /dev/null && echo 0 || echo 1 );
__AS=$?;
__1__perl_available=$(echo $(echo  '!' ${__0__perl_disabled} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '&&' $([ "_${__AMBER_VAL_8}" != "_0" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
# global variables to store terminal size
# (prevent multiple queries in one session)
__2__got_term_size=0
__AMBER_ARRAY_9=(80 24);
__3__term_size=("${__AMBER_ARRAY_9[@]}")
# stty lock/unlock using environment variable for cross-module state
 export XYLITOL_RUNTIME_STTY_COUNT=0 ;
__AS=$?
# A global variable indicating if the terminal supports truecolor.
# "None" or "Yes" or "No"
# 
# This value is only updated by the `get_supports_truecolor` function
# executed by `colored_rgb` on its first call.
__4__supports_truecolor="None"
# A global variable indicating if the Xylitol colors have been loaded from environment variables.
__5__got_xylitol_colors=0
__AMBER_ARRAY_10=(3 207 159 92);
__6__primary_color=("${__AMBER_ARRAY_10[@]}")
__AMBER_ARRAY_11=(3 118 206 94);
__7__secondary_color=("${__AMBER_ARRAY_11[@]}")
__AMBER_ARRAY_12=(234 72 121 95);
__8__accent_color=("${__AMBER_ARRAY_12[@]}")
get_supports_truecolor__180_v0() {
    env_const_get__89_v0 "XYLITOL_TRUECOLOR";
    __AS=$?;
if [ $__AS != 0 ]; then
        echo "" > /dev/null 2>&1
fi;
    __AF_env_const_get89_v0__20_18="${__AF_env_const_get89_v0}";
    local config="${__AF_env_const_get89_v0__20_18}"
    if [ $([ "_${config}" != "_No" ]; echo $?) != 0 ]; then
        __4__supports_truecolor="No"
        __AF_get_supports_truecolor180_v0=0;
        return 0
fi
    env_const_get__89_v0 "COLORTERM";
    __AS=$?;
if [ $__AS != 0 ]; then
        __4__supports_truecolor="No"
        __AF_get_supports_truecolor180_v0=0;
        return 0
fi;
    __AF_env_const_get89_v0__25_21="${__AF_env_const_get89_v0}";
    local colorterm="${__AF_env_const_get89_v0__25_21}"
    __4__supports_truecolor=$(if [ $(echo $([ "_${colorterm}" != "_truecolor" ]; echo $?) '||' $([ "_${colorterm}" != "_24bit" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then echo "Yes"; else echo "No"; fi)
    __AF_get_supports_truecolor180_v0=$([ "_${__4__supports_truecolor}" != "_Yes" ]; echo $?);
    return 0
}
colored_rgb__181_v0() {
    local message=$1
    local r=$2
    local g=$3
    local b=$4
    local fallback=$5
    if [ $([ "_${__4__supports_truecolor}" != "_Yes" ]; echo $?) != 0 ]; then
                    __AF_colored_rgb181_v0="\x1b[38;2;${r};${g};${b}m""${message}""\x1b[0m";
            return 0
elif [ $([ "_${__4__supports_truecolor}" != "_None" ]; echo $?) != 0 ]; then
                    get_supports_truecolor__180_v0 ;
            __AF_get_supports_truecolor180_v0__50_17="$__AF_get_supports_truecolor180_v0";
            if [ "$__AF_get_supports_truecolor180_v0__50_17" != 0 ]; then
                                    __AF_colored_rgb181_v0="\x1b[38;2;${r};${g};${b}m""${message}""\x1b[0m";
                    return 0
elif [ $(echo ${fallback} '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                __AF_colored_rgb181_v0="${message}";
                return 0
else
                __AF_colored_rgb181_v0="\x1b[${fallback}m""${message}""\x1b[0m";
                return 0
fi
else
        if [ $(echo ${fallback} '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            __AF_colored_rgb181_v0="${message}";
            return 0
fi
        __AF_colored_rgb181_v0="\x1b[${fallback}m""${message}""\x1b[0m";
        return 0
fi
}
inner_get_xylitol_colors__183_v0() {
    if [ $(echo  '!' ${__5__got_xylitol_colors} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        env_const_get__89_v0 "XYLITOL_PRIMARY_COLOR";
        __AS=$?;
if [ $__AS != 0 ]; then
            echo "" > /dev/null 2>&1
fi;
        __AF_env_const_get89_v0__110_27="${__AF_env_const_get89_v0}";
        local primary_env="${__AF_env_const_get89_v0__110_27}"
        if [ $([ "_${primary_env}" == "_" ]; echo $?) != 0 ]; then
            split__3_v0 "${primary_env}" ";";
            __AF_split3_v0__112_25=("${__AF_split3_v0[@]}");
            local parts=("${__AF_split3_v0__112_25[@]}")
            if [ $(echo "${#parts[@]}" '==' 4 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                parse_number__12_v0 "${parts[0]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors183_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__115_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[1]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors183_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__116_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[2]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors183_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__117_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[3]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors183_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__118_21="$__AF_parse_number12_v0";
                __AMBER_ARRAY_13=("$__AF_parse_number12_v0__115_21" "$__AF_parse_number12_v0__116_21" "$__AF_parse_number12_v0__117_21" "$__AF_parse_number12_v0__118_21");
                __6__primary_color=("${__AMBER_ARRAY_13[@]}")
fi
fi
        env_const_get__89_v0 "XYLITOL_SECONDARY_COLOR";
        __AS=$?;
if [ $__AS != 0 ]; then
            echo "" > /dev/null 2>&1
fi;
        __AF_env_const_get89_v0__123_29="${__AF_env_const_get89_v0}";
        local secondary_env="${__AF_env_const_get89_v0__123_29}"
        if [ $([ "_${secondary_env}" == "_" ]; echo $?) != 0 ]; then
            split__3_v0 "${secondary_env}" ";";
            __AF_split3_v0__125_25=("${__AF_split3_v0[@]}");
            local parts=("${__AF_split3_v0__125_25[@]}")
            if [ $(echo "${#parts[@]}" '==' 4 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                parse_number__12_v0 "${parts[0]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors183_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__128_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[1]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors183_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__129_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[2]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors183_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__130_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[3]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors183_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__131_21="$__AF_parse_number12_v0";
                __AMBER_ARRAY_14=("$__AF_parse_number12_v0__128_21" "$__AF_parse_number12_v0__129_21" "$__AF_parse_number12_v0__130_21" "$__AF_parse_number12_v0__131_21");
                __7__secondary_color=("${__AMBER_ARRAY_14[@]}")
fi
fi
        env_const_get__89_v0 "XYLITOL_ACCENT_COLOR";
        __AS=$?;
if [ $__AS != 0 ]; then
            echo "" > /dev/null 2>&1
fi;
        __AF_env_const_get89_v0__136_26="${__AF_env_const_get89_v0}";
        local accent_env="${__AF_env_const_get89_v0__136_26}"
        if [ $([ "_${accent_env}" == "_" ]; echo $?) != 0 ]; then
            split__3_v0 "${accent_env}" ";";
            __AF_split3_v0__138_25=("${__AF_split3_v0[@]}");
            local parts=("${__AF_split3_v0__138_25[@]}")
            if [ $(echo "${#parts[@]}" '==' 4 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                parse_number__12_v0 "${parts[0]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors183_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__141_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[1]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors183_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__142_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[2]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors183_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__143_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[3]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors183_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__144_21="$__AF_parse_number12_v0";
                __AMBER_ARRAY_15=("$__AF_parse_number12_v0__141_21" "$__AF_parse_number12_v0__142_21" "$__AF_parse_number12_v0__143_21" "$__AF_parse_number12_v0__144_21");
                __8__accent_color=("${__AMBER_ARRAY_15[@]}")
fi
fi
        __5__got_xylitol_colors=1
fi
}
get_xylitol_colors__184_v0() {
    inner_get_xylitol_colors__183_v0 ;
    __AS=$?;
if [ $__AS != 0 ]; then
        echo_colored__105_v0 "WARN: Failed to parse Xylitol colors from envs." 33;
        __AF_echo_colored105_v0__155_9="$__AF_echo_colored105_v0";
        echo "$__AF_echo_colored105_v0__155_9" > /dev/null 2>&1
fi;
    __AF_inner_get_xylitol_colors183_v0__154_5="$__AF_inner_get_xylitol_colors183_v0";
    echo "$__AF_inner_get_xylitol_colors183_v0__154_5" > /dev/null 2>&1
    __5__got_xylitol_colors=1
}
colored_primary__185_v0() {
    local message=$1
    if [ $(echo  '!' ${__5__got_xylitol_colors} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        get_xylitol_colors__184_v0 ;
        __AF_get_xylitol_colors184_v0__162_9="$__AF_get_xylitol_colors184_v0";
        echo "$__AF_get_xylitol_colors184_v0__162_9" > /dev/null 2>&1
fi
    colored_rgb__181_v0 "${message}" "${__6__primary_color[0]}" "${__6__primary_color[1]}" "${__6__primary_color[2]}" "${__6__primary_color[3]}";
    __AF_colored_rgb181_v0__164_12="${__AF_colored_rgb181_v0}";
    __AF_colored_primary185_v0="${__AF_colored_rgb181_v0__164_12}";
    return 0
}
colored_secondary__186_v0() {
    local message=$1
    if [ $(echo  '!' ${__5__got_xylitol_colors} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        get_xylitol_colors__184_v0 ;
        __AF_get_xylitol_colors184_v0__169_9="$__AF_get_xylitol_colors184_v0";
        echo "$__AF_get_xylitol_colors184_v0__169_9" > /dev/null 2>&1
fi
    colored_rgb__181_v0 "${message}" "${__7__secondary_color[0]}" "${__7__secondary_color[1]}" "${__7__secondary_color[2]}" "${__7__secondary_color[3]}";
    __AF_colored_rgb181_v0__171_12="${__AF_colored_rgb181_v0}";
    __AF_colored_secondary186_v0="${__AF_colored_rgb181_v0__171_12}";
    return 0
}
colored_accent__187_v0() {
    local message=$1
    if [ $(echo  '!' ${__5__got_xylitol_colors} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        get_xylitol_colors__184_v0 ;
        __AF_get_xylitol_colors184_v0__176_9="$__AF_get_xylitol_colors184_v0";
        echo "$__AF_get_xylitol_colors184_v0__176_9" > /dev/null 2>&1
fi
    colored_rgb__181_v0 "${message}" "${__8__accent_color[0]}" "${__8__accent_color[1]}" "${__8__accent_color[2]}" "${__8__accent_color[3]}";
    __AF_colored_rgb181_v0__178_12="${__AF_colored_rgb181_v0}";
    __AF_colored_accent187_v0="${__AF_colored_rgb181_v0__178_12}";
    return 0
}
# // IO Functions /////
printf_colored__202_v0() {
    local message=$1
    local color=$2
    # Prints a text with a specified color.
    __AMBER_ARRAY_16=("${message}");
    printf__99_v0 "\x1b[${color}m%s\x1b[0m" __AMBER_ARRAY_16[@];
    __AF_printf99_v0__32_5="$__AF_printf99_v0";
    echo "$__AF_printf99_v0__32_5" > /dev/null 2>&1
}
eprintf__203_v0() {
    local format=$1
    local args=("${!2}")
     args=("${format}" "${args[@]}") ;
    __AS=$?
     printf "${args[@]}" >&2 ;
    __AS=$?
}
eprintf_colored__204_v0() {
    local message=$1
    local color=$2
    # Prints an error message with a specified color.
    __AMBER_ARRAY_17=("${message}");
    eprintf__203_v0 "\x1b[${color}m%s\x1b[0m" __AMBER_ARRAY_17[@];
    __AF_eprintf203_v0__42_5="$__AF_eprintf203_v0";
    echo "$__AF_eprintf203_v0__42_5" > /dev/null 2>&1
}
colored__205_v0() {
    local message=$1
    local color=$2
    # Returns a text wrapped in color codes.
    __AF_colored205_v0="\x1b[${color}m""${message}""\x1b[0m";
    return 0
}
# move the cursor up or down `cnt` lines.
# / Text Utilities /////
# // Application Utilities /////
print_help__349_v0() {
    echo "Usage: ./xylitol.sh <command> [flags]"
    echo ""
    colored_primary__185_v0 "Xylitol";
    __AF_colored_primary185_v0__7_24="${__AF_colored_primary185_v0}";
    __AMBER_ARRAY_18=("");
    printf__99_v0 "\x1b[1m""${__AF_colored_primary185_v0__7_24}" __AMBER_ARRAY_18[@];
    __AF_printf99_v0__7_5="$__AF_printf99_v0";
    echo "$__AF_printf99_v0__7_5" > /dev/null 2>&1
    __AMBER_ARRAY_19=("");
    printf__99_v0 " - A tool for " __AMBER_ARRAY_19[@];
    __AF_printf99_v0__8_5="$__AF_printf99_v0";
    echo "$__AF_printf99_v0__8_5" > /dev/null 2>&1
    colored_primary__185_v0 "fresh";
    __AF_colored_primary185_v0__9_12="${__AF_colored_primary185_v0}";
    __AMBER_ARRAY_20=("");
    printf__99_v0 "${__AF_colored_primary185_v0__9_12}" __AMBER_ARRAY_20[@];
    __AF_printf99_v0__9_5="$__AF_printf99_v0";
    echo "$__AF_printf99_v0__9_5" > /dev/null 2>&1
    __AMBER_ARRAY_21=("");
    printf__99_v0 " shell scripts." __AMBER_ARRAY_21[@];
    __AF_printf99_v0__10_5="$__AF_printf99_v0";
    echo "$__AF_printf99_v0__10_5" > /dev/null 2>&1
    echo ""
    echo ""
    colored_secondary__186_v0 "Flags: ";
    __AF_colored_secondary186_v0__13_12="${__AF_colored_secondary186_v0}";
    __AMBER_ARRAY_22=("");
    printf__99_v0 "${__AF_colored_secondary186_v0__13_12}""
" __AMBER_ARRAY_22[@];
    __AF_printf99_v0__13_5="$__AF_printf99_v0";
    echo "$__AF_printf99_v0__13_5" > /dev/null 2>&1
    echo "  -h, --help        Show this help message"
    echo "  -v, --version     Show version information"
    echo ""
    colored_secondary__186_v0 "Commands: ";
    __AF_colored_secondary186_v0__17_12="${__AF_colored_secondary186_v0}";
    __AMBER_ARRAY_23=("");
    printf__99_v0 "${__AF_colored_secondary186_v0__17_12}""
" __AMBER_ARRAY_23[@];
    __AF_printf99_v0__17_5="$__AF_printf99_v0";
    echo "$__AF_printf99_v0__17_5" > /dev/null 2>&1
    echo "  input             Prompt for some input"
    echo "  choose            Choose from a list of options"
    echo "  confirm           Prompt for a yes/no confirmation"
    echo "  file              Browse filesystem and select a file"
    echo ""
    colored_secondary__186_v0 "Envs: ";
    __AF_colored_secondary186_v0__23_12="${__AF_colored_secondary186_v0}";
    __AMBER_ARRAY_24=("");
    printf__99_v0 "${__AF_colored_secondary186_v0__23_12}""
" __AMBER_ARRAY_24[@];
    __AF_printf99_v0__23_5="$__AF_printf99_v0";
    echo "$__AF_printf99_v0__23_5" > /dev/null 2>&1
    colored__205_v0 "(\"Yes\" or \"No\", default: Yes)" 90;
    __AF_colored205_v0__24_78="${__AF_colored205_v0}";
    __AMBER_ARRAY_25=("");
    printf__99_v0 "  \$XYLITOL_USE_PERL          Use Perl for CJK / Optimization ""${__AF_colored205_v0__24_78}""
" __AMBER_ARRAY_25[@];
    __AF_printf99_v0__24_5="$__AF_printf99_v0";
    echo "$__AF_printf99_v0__24_5" > /dev/null 2>&1
    colored__205_v0 "(\"Yes\" or \"No\", default: Yes)" 90;
    __AF_colored205_v0__25_78="${__AF_colored205_v0}";
    __AMBER_ARRAY_26=("");
    printf__99_v0 "  \$XYLITOL_TRUECOLOR         Enable 24-bit truecolor support ""${__AF_colored205_v0__25_78}""
" __AMBER_ARRAY_26[@];
    __AF_printf99_v0__25_5="$__AF_printf99_v0";
    echo "$__AF_printf99_v0__25_5" > /dev/null 2>&1
    colored__205_v0 "(default: 3;207;159;92)" 90;
    __AF_colored205_v0__26_68="${__AF_colored205_v0}";
    __AMBER_ARRAY_27=("");
    printf__99_v0 "  \$XYLITOL_PRIMARY_COLOR     Set the primary color ""${__AF_colored205_v0__26_68}""
" __AMBER_ARRAY_27[@];
    __AF_printf99_v0__26_5="$__AF_printf99_v0";
    echo "$__AF_printf99_v0__26_5" > /dev/null 2>&1
    colored__205_v0 "(default: 3;118;206;94)" 90;
    __AF_colored205_v0__27_70="${__AF_colored205_v0}";
    __AMBER_ARRAY_28=("");
    printf__99_v0 "  \$XYLITOL_SECONDARY_COLOR   Set the secondary color ""${__AF_colored205_v0__27_70}""
" __AMBER_ARRAY_28[@];
    __AF_printf99_v0__27_5="$__AF_printf99_v0";
    echo "$__AF_printf99_v0__27_5" > /dev/null 2>&1
    colored__205_v0 "(default: 234;72;121;95)" 90;
    __AF_colored205_v0__28_67="${__AF_colored205_v0}";
    __AMBER_ARRAY_29=("");
    printf__99_v0 "  \$XYLITOL_ACCENT_COLOR      Set the accent color ""${__AF_colored205_v0__28_67}""
" __AMBER_ARRAY_29[@];
    __AF_printf99_v0__28_5="$__AF_printf99_v0";
    echo "$__AF_printf99_v0__28_5" > /dev/null 2>&1
    echo ""
    colored_accent__187_v0 "./xylitol.sh <command> --help";
    __AF_colored_accent187_v0__30_21="${__AF_colored_accent187_v0}";
    __AMBER_ARRAY_30=("");
    printf__99_v0 "Run ""${__AF_colored_accent187_v0__30_21}"" for more information on a command.
" __AMBER_ARRAY_30[@];
    __AF_printf99_v0__30_5="$__AF_printf99_v0";
    echo "$__AF_printf99_v0__30_5" > /dev/null 2>&1
}
math_floor__406_v0() {
    local number=$1
    __AMBER_VAL_31=$( echo "${number}" | awk '{printf "%d", ($1 < 0 ? int($1) - 1 : int($1))}' );
    __AS=$?;
    __AF_math_floor406_v0="${__AMBER_VAL_31}";
    return 0
}
math_ceil__407_v0() {
    local number=$1
    math_floor__406_v0 ${number};
    __AF_math_floor406_v0__26_12="$__AF_math_floor406_v0";
    __AF_math_ceil407_v0=$(echo "$__AF_math_floor406_v0__26_12" '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
    return 0
}

# Perl Extensions Utilities
__AMBER_VAL_32=$( echo "$XYLITOL_USE_PERL" );
__AS=$?;
__9__perl_disabled=$([ "_${__AMBER_VAL_32}" != "_No" ]; echo $?)
__AMBER_VAL_33=$( command -v perl > /dev/null && echo 0 || echo 1 );
__AS=$?;
__10__perl_available=$(echo $(echo  '!' ${__9__perl_disabled} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '&&' $([ "_${__AMBER_VAL_33}" != "_0" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
perl_get_cjk_width__461_v0() {
    local text=$1
    if [ $(echo  '!' ${__10__perl_available} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        __AF_perl_get_cjk_width461_v0='';
        return 1
fi
    __AMBER_VAL_34=$( perl -CSDA -E '$w=0;$w+=/\p{EastAsianWidth=Wide}|\p{EastAsianWidth=Fullwidth}|\p{EastAsianWidth=Ambiguous}/?2:1 for split//,shift; say $w' "${text}" 2>/dev/null );
    __AS=$?;
if [ $__AS != 0 ]; then
__AF_perl_get_cjk_width461_v0=''
return $__AS
fi;
    local width_str="${__AMBER_VAL_34}"
    parse_number__12_v0 "${width_str}";
    __AS=$?;
if [ $__AS != 0 ]; then
__AF_perl_get_cjk_width461_v0=''
return $__AS
fi;
    __AF_parse_number12_v0__14_17="$__AF_parse_number12_v0";
    local width="$__AF_parse_number12_v0__14_17"
    __AF_perl_get_cjk_width461_v0=${width};
    return 0
}
perl_truncate_cjk__462_v0() {
    local text=$1
    local max_width=$2
    if [ $(echo  '!' ${__10__perl_available} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        __AF_perl_truncate_cjk462_v0='';
        return 1
fi
    __AMBER_VAL_35=$( perl -CSDA -E '$t=shift;$m=shift;$w=0;$r="";$c=/\p{EastAsianWidth=Wide}|\p{EastAsianWidth=Fullwidth}|\p{EastAsianWidth=Ambiguous}/?2:1,($w+$c<=$m?($w+=$c,$r.=$_):last) for split//,$t; print $r' "${text}" ${max_width} 2>/dev/null );
    __AS=$?;
if [ $__AS != 0 ]; then
__AF_perl_truncate_cjk462_v0=''
return $__AS
fi;
    local result="${__AMBER_VAL_35}"
    __AF_perl_truncate_cjk462_v0="${result}";
    return 0
}
# global variables to store terminal size
# (prevent multiple queries in one session)
__11__got_term_size=0
__AMBER_ARRAY_36=(80 24);
__12__term_size=("${__AMBER_ARRAY_36[@]}")
# stty lock/unlock using environment variable for cross-module state
 export XYLITOL_RUNTIME_STTY_COUNT=0 ;
__AS=$?
stty_lock__469_v0() {
    __AMBER_VAL_37=$( echo "${XYLITOL_RUNTIME_STTY_COUNT:-0}" );
    __AS=$?;
    local count="${__AMBER_VAL_37}"
    parse_number__12_v0 "${count}";
    __AS=$?;
if [ $__AS != 0 ]; then
        echo 0 > /dev/null 2>&1
fi;
    __AF_parse_number12_v0__14_21="$__AF_parse_number12_v0";
    local count_num="$__AF_parse_number12_v0__14_21"
    if [ $(echo ${count_num} '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
         stty -echo < /dev/tty ;
        __AS=$?
fi
    count_num=$(echo ${count_num} '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
     export XYLITOL_RUNTIME_STTY_COUNT=${count_num} ;
    __AS=$?
}
stty_unlock__470_v0() {
    __AMBER_VAL_38=$( echo "${XYLITOL_RUNTIME_STTY_COUNT:-0}" );
    __AS=$?;
    local count="${__AMBER_VAL_38}"
    parse_number__12_v0 "${count}";
    __AS=$?;
if [ $__AS != 0 ]; then
        echo 0 > /dev/null 2>&1
fi;
    __AF_parse_number12_v0__25_21="$__AF_parse_number12_v0";
    local count_num="$__AF_parse_number12_v0__25_21"
    if [ $(echo ${count_num} '>' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        count_num=$(echo ${count_num} '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
         export XYLITOL_RUNTIME_STTY_COUNT=${count_num} ;
        __AS=$?
        if [ $(echo ${count_num} '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
             stty echo < /dev/tty ;
            __AS=$?
fi
fi
}
get_term_size__471_v0() {
    # Query terminal size with \x1b[18t, response format: \x1b[8;rows;colst
    __AMBER_VAL_39=$( printf '\x1b[18t' > /dev/tty; IFS=';' read -rsd t _ignore height width < /dev/tty; echo "$height; $width" );
    __AS=$?;
    local result="${__AMBER_VAL_39}"
    split__3_v0 "${result}" ";";
    __AF_split3_v0__39_17=("${__AF_split3_v0[@]}");
    local parts=("${__AF_split3_v0__39_17[@]}")
    if [ $(echo "${#parts[@]}" '!=' 2 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        __AF_get_term_size471_v0='';
        return 1
fi
    parse_number__12_v0 "${parts[0]}";
    __AS=$?;
if [ $__AS != 0 ]; then
__AF_get_term_size471_v0=''
return $__AS
fi;
    __AF_parse_number12_v0__43_16="$__AF_parse_number12_v0";
    local rows="$__AF_parse_number12_v0__43_16"
    parse_number__12_v0 "${parts[1]}";
    __AS=$?;
if [ $__AS != 0 ]; then
__AF_get_term_size471_v0=''
return $__AS
fi;
    __AF_parse_number12_v0__44_16="$__AF_parse_number12_v0";
    local cols="$__AF_parse_number12_v0__44_16"
    __AMBER_ARRAY_40=(${cols} ${rows});
    __12__term_size=("${__AMBER_ARRAY_40[@]}")
    __11__got_term_size=1
}
term_width__473_v0() {
    if [ $(echo  '!' ${__11__got_term_size} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        get_term_size__471_v0 ;
        __AS=$?;
        __AF_get_term_size471_v0__60_15="$__AF_get_term_size471_v0";
        echo "$__AF_get_term_size471_v0__60_15" > /dev/null 2>&1
fi
    __AF_term_width473_v0="${__12__term_size[0]}";
    return 0
}
# A global variable indicating if the terminal supports truecolor.
# "None" or "Yes" or "No"
# 
# This value is only updated by the `get_supports_truecolor` function
# executed by `colored_rgb` on its first call.
__13__supports_truecolor="None"
# A global variable indicating if the Xylitol colors have been loaded from environment variables.
__14__got_xylitol_colors=0
__AMBER_ARRAY_41=(3 207 159 92);
__15__primary_color=("${__AMBER_ARRAY_41[@]}")
__AMBER_ARRAY_42=(3 118 206 94);
__16__secondary_color=("${__AMBER_ARRAY_42[@]}")
__AMBER_ARRAY_43=(234 72 121 95);
__17__accent_color=("${__AMBER_ARRAY_43[@]}")
get_supports_truecolor__484_v0() {
    env_const_get__89_v0 "XYLITOL_TRUECOLOR";
    __AS=$?;
if [ $__AS != 0 ]; then
        echo "" > /dev/null 2>&1
fi;
    __AF_env_const_get89_v0__20_18="${__AF_env_const_get89_v0}";
    local config="${__AF_env_const_get89_v0__20_18}"
    if [ $([ "_${config}" != "_No" ]; echo $?) != 0 ]; then
        __13__supports_truecolor="No"
        __AF_get_supports_truecolor484_v0=0;
        return 0
fi
    env_const_get__89_v0 "COLORTERM";
    __AS=$?;
if [ $__AS != 0 ]; then
        __13__supports_truecolor="No"
        __AF_get_supports_truecolor484_v0=0;
        return 0
fi;
    __AF_env_const_get89_v0__25_21="${__AF_env_const_get89_v0}";
    local colorterm="${__AF_env_const_get89_v0__25_21}"
    __13__supports_truecolor=$(if [ $(echo $([ "_${colorterm}" != "_truecolor" ]; echo $?) '||' $([ "_${colorterm}" != "_24bit" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then echo "Yes"; else echo "No"; fi)
    __AF_get_supports_truecolor484_v0=$([ "_${__13__supports_truecolor}" != "_Yes" ]; echo $?);
    return 0
}
colored_rgb__485_v0() {
    local message=$1
    local r=$2
    local g=$3
    local b=$4
    local fallback=$5
    if [ $([ "_${__13__supports_truecolor}" != "_Yes" ]; echo $?) != 0 ]; then
                    __AF_colored_rgb485_v0="\x1b[38;2;${r};${g};${b}m""${message}""\x1b[0m";
            return 0
elif [ $([ "_${__13__supports_truecolor}" != "_None" ]; echo $?) != 0 ]; then
                    get_supports_truecolor__484_v0 ;
            __AF_get_supports_truecolor484_v0__50_17="$__AF_get_supports_truecolor484_v0";
            if [ "$__AF_get_supports_truecolor484_v0__50_17" != 0 ]; then
                                    __AF_colored_rgb485_v0="\x1b[38;2;${r};${g};${b}m""${message}""\x1b[0m";
                    return 0
elif [ $(echo ${fallback} '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                __AF_colored_rgb485_v0="${message}";
                return 0
else
                __AF_colored_rgb485_v0="\x1b[${fallback}m""${message}""\x1b[0m";
                return 0
fi
else
        if [ $(echo ${fallback} '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            __AF_colored_rgb485_v0="${message}";
            return 0
fi
        __AF_colored_rgb485_v0="\x1b[${fallback}m""${message}""\x1b[0m";
        return 0
fi
}
inner_get_xylitol_colors__487_v0() {
    if [ $(echo  '!' ${__14__got_xylitol_colors} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        env_const_get__89_v0 "XYLITOL_PRIMARY_COLOR";
        __AS=$?;
if [ $__AS != 0 ]; then
            echo "" > /dev/null 2>&1
fi;
        __AF_env_const_get89_v0__110_27="${__AF_env_const_get89_v0}";
        local primary_env="${__AF_env_const_get89_v0__110_27}"
        if [ $([ "_${primary_env}" == "_" ]; echo $?) != 0 ]; then
            split__3_v0 "${primary_env}" ";";
            __AF_split3_v0__112_25=("${__AF_split3_v0[@]}");
            local parts=("${__AF_split3_v0__112_25[@]}")
            if [ $(echo "${#parts[@]}" '==' 4 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                parse_number__12_v0 "${parts[0]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors487_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__115_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[1]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors487_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__116_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[2]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors487_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__117_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[3]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors487_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__118_21="$__AF_parse_number12_v0";
                __AMBER_ARRAY_44=("$__AF_parse_number12_v0__115_21" "$__AF_parse_number12_v0__116_21" "$__AF_parse_number12_v0__117_21" "$__AF_parse_number12_v0__118_21");
                __15__primary_color=("${__AMBER_ARRAY_44[@]}")
fi
fi
        env_const_get__89_v0 "XYLITOL_SECONDARY_COLOR";
        __AS=$?;
if [ $__AS != 0 ]; then
            echo "" > /dev/null 2>&1
fi;
        __AF_env_const_get89_v0__123_29="${__AF_env_const_get89_v0}";
        local secondary_env="${__AF_env_const_get89_v0__123_29}"
        if [ $([ "_${secondary_env}" == "_" ]; echo $?) != 0 ]; then
            split__3_v0 "${secondary_env}" ";";
            __AF_split3_v0__125_25=("${__AF_split3_v0[@]}");
            local parts=("${__AF_split3_v0__125_25[@]}")
            if [ $(echo "${#parts[@]}" '==' 4 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                parse_number__12_v0 "${parts[0]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors487_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__128_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[1]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors487_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__129_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[2]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors487_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__130_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[3]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors487_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__131_21="$__AF_parse_number12_v0";
                __AMBER_ARRAY_45=("$__AF_parse_number12_v0__128_21" "$__AF_parse_number12_v0__129_21" "$__AF_parse_number12_v0__130_21" "$__AF_parse_number12_v0__131_21");
                __16__secondary_color=("${__AMBER_ARRAY_45[@]}")
fi
fi
        env_const_get__89_v0 "XYLITOL_ACCENT_COLOR";
        __AS=$?;
if [ $__AS != 0 ]; then
            echo "" > /dev/null 2>&1
fi;
        __AF_env_const_get89_v0__136_26="${__AF_env_const_get89_v0}";
        local accent_env="${__AF_env_const_get89_v0__136_26}"
        if [ $([ "_${accent_env}" == "_" ]; echo $?) != 0 ]; then
            split__3_v0 "${accent_env}" ";";
            __AF_split3_v0__138_25=("${__AF_split3_v0[@]}");
            local parts=("${__AF_split3_v0__138_25[@]}")
            if [ $(echo "${#parts[@]}" '==' 4 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                parse_number__12_v0 "${parts[0]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors487_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__141_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[1]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors487_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__142_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[2]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors487_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__143_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[3]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors487_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__144_21="$__AF_parse_number12_v0";
                __AMBER_ARRAY_46=("$__AF_parse_number12_v0__141_21" "$__AF_parse_number12_v0__142_21" "$__AF_parse_number12_v0__143_21" "$__AF_parse_number12_v0__144_21");
                __17__accent_color=("${__AMBER_ARRAY_46[@]}")
fi
fi
        __14__got_xylitol_colors=1
fi
}
get_xylitol_colors__488_v0() {
    inner_get_xylitol_colors__487_v0 ;
    __AS=$?;
if [ $__AS != 0 ]; then
        echo_colored__105_v0 "WARN: Failed to parse Xylitol colors from envs." 33;
        __AF_echo_colored105_v0__155_9="$__AF_echo_colored105_v0";
        echo "$__AF_echo_colored105_v0__155_9" > /dev/null 2>&1
fi;
    __AF_inner_get_xylitol_colors487_v0__154_5="$__AF_inner_get_xylitol_colors487_v0";
    echo "$__AF_inner_get_xylitol_colors487_v0__154_5" > /dev/null 2>&1
    __14__got_xylitol_colors=1
}
colored_primary__489_v0() {
    local message=$1
    if [ $(echo  '!' ${__14__got_xylitol_colors} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        get_xylitol_colors__488_v0 ;
        __AF_get_xylitol_colors488_v0__162_9="$__AF_get_xylitol_colors488_v0";
        echo "$__AF_get_xylitol_colors488_v0__162_9" > /dev/null 2>&1
fi
    colored_rgb__485_v0 "${message}" "${__15__primary_color[0]}" "${__15__primary_color[1]}" "${__15__primary_color[2]}" "${__15__primary_color[3]}";
    __AF_colored_rgb485_v0__164_12="${__AF_colored_rgb485_v0}";
    __AF_colored_primary489_v0="${__AF_colored_rgb485_v0__164_12}";
    return 0
}
colored_secondary__490_v0() {
    local message=$1
    if [ $(echo  '!' ${__14__got_xylitol_colors} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        get_xylitol_colors__488_v0 ;
        __AF_get_xylitol_colors488_v0__169_9="$__AF_get_xylitol_colors488_v0";
        echo "$__AF_get_xylitol_colors488_v0__169_9" > /dev/null 2>&1
fi
    colored_rgb__485_v0 "${message}" "${__16__secondary_color[0]}" "${__16__secondary_color[1]}" "${__16__secondary_color[2]}" "${__16__secondary_color[3]}";
    __AF_colored_rgb485_v0__171_12="${__AF_colored_rgb485_v0}";
    __AF_colored_secondary490_v0="${__AF_colored_rgb485_v0__171_12}";
    return 0
}
# // IO Functions /////
get_char__504_v0() {
    __AMBER_VAL_47=$( read -n 1 key < /dev/tty; printf "%s" "$key" );
    __AS=$?;
    local char="${__AMBER_VAL_47}"
    __AF_get_char504_v0="${char}";
    return 0
}
eprintf__507_v0() {
    local format=$1
    local args=("${!2}")
     args=("${format}" "${args[@]}") ;
    __AS=$?
     printf "${args[@]}" >&2 ;
    __AS=$?
}
eprintf_colored__508_v0() {
    local message=$1
    local color=$2
    # Prints an error message with a specified color.
    __AMBER_ARRAY_48=("${message}");
    eprintf__507_v0 "\x1b[${color}m%s\x1b[0m" __AMBER_ARRAY_48[@];
    __AF_eprintf507_v0__42_5="$__AF_eprintf507_v0";
    echo "$__AF_eprintf507_v0__42_5" > /dev/null 2>&1
}
colored__509_v0() {
    local message=$1
    local color=$2
    # Returns a text wrapped in color codes.
    __AF_colored509_v0="\x1b[${color}m""${message}""\x1b[0m";
    return 0
}
remove__510_v0() {
    local cnt=$1
     printf '%0.s\b \b' $(seq 1 ${cnt}) >&2 ;
    __AS=$?
}
remove_line__511_v0() {
    local cnt=$1
     printf '\x1b[2K\x1b[1A%.0s' $(seq ${cnt}) >&2 ;
    __AS=$?
    __AMBER_ARRAY_49=("");
    eprintf__507_v0 "\x1b[9999D" __AMBER_ARRAY_49[@];
    __AF_eprintf507_v0__58_5="$__AF_eprintf507_v0";
    echo "$__AF_eprintf507_v0__58_5" > /dev/null 2>&1
}
remove_current_line__512_v0() {
    __AMBER_ARRAY_50=("");
    eprintf__507_v0 "\x1b[2K\x1b[9999D" __AMBER_ARRAY_50[@];
    __AF_eprintf507_v0__63_5="$__AF_eprintf507_v0";
    echo "$__AF_eprintf507_v0__63_5" > /dev/null 2>&1
}
new_line__514_v0() {
    local cnt=$1
    for i in $(seq 0 $(echo ${cnt} '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')); do
        __AMBER_ARRAY_51=("");
        eprintf__507_v0 "
" __AMBER_ARRAY_51[@];
        __AF_eprintf507_v0__75_9="$__AF_eprintf507_v0";
        echo "$__AF_eprintf507_v0__75_9" > /dev/null 2>&1
done
}
go_up__515_v0() {
    local cnt=$1
    __AMBER_ARRAY_52=("");
    eprintf__507_v0 "\x1b[${cnt}A" __AMBER_ARRAY_52[@];
    __AF_eprintf507_v0__81_5="$__AF_eprintf507_v0";
    echo "$__AF_eprintf507_v0__81_5" > /dev/null 2>&1
}
go_down__516_v0() {
    local cnt=$1
    __AMBER_ARRAY_53=("");
    eprintf__507_v0 "\x1b[${cnt}B" __AMBER_ARRAY_53[@];
    __AF_eprintf507_v0__86_5="$__AF_eprintf507_v0";
    echo "$__AF_eprintf507_v0__86_5" > /dev/null 2>&1
}
# move the cursor up or down `cnt` lines.
# / Text Utilities /////
has_ansi_escape__520_v0() {
    local text=$1
    # Check for ESC character (0x1B = 27) or literal \x1b[
    __AMBER_VAL_54=$( [[ "${text}" == *$'\x1b'* || "${text}" == *'\x1b['* ]] && echo "1" || echo "0" );
    __AS=$?;
    local has_escape="${__AMBER_VAL_54}"
    __AF_has_ansi_escape520_v0=$([ "_${has_escape}" != "_1" ]; echo $?);
    return 0
}
escape_ansi__521_v0() {
    local text=$1
    __AMBER_VAL_55=$( printf '%s' "${text}" | sed $'s/\x1b/\\x1b/g' );
    __AS=$?;
    __AF_escape_ansi521_v0="${__AMBER_VAL_55}";
    return 0
}
strip_ansi__522_v0() {
    local text=$1
    __AMBER_VAL_56=$( printf "%s" "${text}" | sed $'s/\x1b\[[0-9;]*m//g' | sed 's/\\x1b\[[0-9;]*m//g' );
    __AS=$?;
    __AF_strip_ansi522_v0="${__AMBER_VAL_56}";
    return 0
}
is_all_ascii__523_v0() {
    local text=$1
    __AMBER_VAL_57=$( printf "%s" "${text}" | LC_ALL=C grep -q '^[ -~]*$' && echo 0 || echo 1 );
    __AS=$?;
    local result="${__AMBER_VAL_57}"
    __AF_is_all_ascii523_v0=$([ "_${result}" != "_0" ]; echo $?);
    return 0
}
get_visible_len__524_v0() {
    local text=$1
    strip_ansi__522_v0 "${text}";
    __AF_strip_ansi522_v0__138_20="${__AF_strip_ansi522_v0}";
    local stripped="${__AF_strip_ansi522_v0__138_20}"
    # Check if text is all ASCII
    is_all_ascii__523_v0 "${stripped}";
    __AF_is_all_ascii523_v0__140_12="$__AF_is_all_ascii523_v0";
    if [ $(echo  '!' "$__AF_is_all_ascii523_v0__140_12" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        # Try using perl
        perl_get_cjk_width__461_v0 "${stripped}";
        __AS=$?;
if [ $__AS != 0 ]; then
            __AMBER_LEN="${stripped}";
            __AF_get_visible_len524_v0="${#__AMBER_LEN}";
            return 0
fi;
        __AF_perl_get_cjk_width461_v0__142_16="$__AF_perl_get_cjk_width461_v0";
        __AF_get_visible_len524_v0="$__AF_perl_get_cjk_width461_v0__142_16";
        return 0
else
        __AMBER_LEN="${stripped}";
        __AF_get_visible_len524_v0="${#__AMBER_LEN}";
        return 0
fi
}
truncate_text__525_v0() {
    local text=$1
    local max_width=$2
    get_visible_len__524_v0 "${text}";
    __AF_get_visible_len524_v0__153_23="$__AF_get_visible_len524_v0";
    local visible_len="$__AF_get_visible_len524_v0__153_23"
    if [ $(echo ${visible_len} '<=' ${max_width} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        __AF_truncate_text525_v0="${text}";
        return 0
fi
    is_all_ascii__523_v0 "${text}";
    __AF_is_all_ascii523_v0__157_12="$__AF_is_all_ascii523_v0";
    if [ $(echo  '!' "$__AF_is_all_ascii523_v0__157_12" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        perl_truncate_cjk__462_v0 "${text}" ${max_width};
        __AS=$?;
if [ $__AS != 0 ]; then
             printf "%s" "${text}" | cut -c1-${max_width} ;
            __AS=$?
fi;
        __AF_perl_truncate_cjk462_v0__158_16="${__AF_perl_truncate_cjk462_v0}";
        __AF_truncate_text525_v0="${__AF_perl_truncate_cjk462_v0__158_16}";
        return 0
fi
    __AMBER_VAL_58=$( printf "%s" "${text}" | cut -c1-${max_width} );
    __AS=$?;
    __AF_truncate_text525_v0="${__AMBER_VAL_58}";
    return 0
}
truncate_ansi__526_v0() {
    local text=$1
    local max_width=$2
    has_ansi_escape__520_v0 "${text}";
    __AF_has_ansi_escape520_v0__169_12="$__AF_has_ansi_escape520_v0";
    if [ $(echo  '!' "$__AF_has_ansi_escape520_v0__169_12" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        truncate_text__525_v0 "${text}" ${max_width};
        __AF_truncate_text525_v0__170_16="${__AF_truncate_text525_v0}";
        __AF_truncate_ansi526_v0="${__AF_truncate_text525_v0__170_16}";
        return 0
fi
    # Check if text starts with \x1b[
    __AMBER_VAL_59=$( [[ "${text}" == '\x1b['* ]] && echo "1" || echo "0" );
    __AS=$?;
    local starts_with_ansi="${__AMBER_VAL_59}"
    # Replace \x1b[ with newline, then split
    __AMBER_VAL_60=$( t="${text}"; printf '%s' "${t//\\x1b[/
}" );
    __AS=$?;
    local replaced="${__AMBER_VAL_60}"
    split__3_v0 "${replaced}" "
";
    __AF_split3_v0__179_17=("${__AF_split3_v0[@]}");
    local parts=("${__AF_split3_v0__179_17[@]}")
    local result=""
    local remaining_width=${max_width}
    for idx in $(seq 0 $(echo "${#parts[@]}" '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')); do
        local part="${parts[${idx}]}"
        # If text starts with ANSI, all parts are "ANSIparams m text" format
        # If not, first part is pure text
        if [ $(echo $(echo ${idx} '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '&&' $([ "_${starts_with_ansi}" != "_0" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            # First part is pure text (before any ANSI)
            if [ $(echo $([ "_${part}" == "_" ]; echo $?) '&&' $(echo ${remaining_width} '>' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                truncate_text__525_v0 "${part}" ${remaining_width};
                __AF_truncate_text525_v0__191_33="${__AF_truncate_text525_v0}";
                local truncated="${__AF_truncate_text525_v0__191_33}"
                result+="${truncated}"
                get_visible_len__524_v0 "${truncated}";
                __AF_get_visible_len524_v0__193_36="$__AF_get_visible_len524_v0";
                remaining_width=$(echo ${remaining_width} '-' "$__AF_get_visible_len524_v0__193_36" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
fi
else
            # Part is "ANSIparams m text" format - find first 'm'
            __AMBER_VAL_61=$( __p="${part}"; for ((i=0; i<${#__p}; i++)); do [[ "${__p:$i:1}" == "m" ]] && echo $i && break; done );
            __AS=$?;
            local m_idx="${__AMBER_VAL_61}"
            if [ $([ "_${m_idx}" == "_" ]; echo $?) != 0 ]; then
                # Reconstruct ANSI sequence
                __AMBER_VAL_62=$( __p="${part}"; printf "%s" "${__p:0:${m_idx}}" );
                __AS=$?;
                local ansi_params="${__AMBER_VAL_62}"
                result+="\\x1b[""${ansi_params}""m"
                # Rest is text content
                parse_number__12_v0 "${m_idx}";
                __AS=$?;
                __AF_parse_number12_v0__204_39="$__AF_parse_number12_v0";
                local m_idx_num="$__AF_parse_number12_v0__204_39"
                local text_start=$(echo ${m_idx_num} '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
                __AMBER_VAL_63=$( __p="${part}"; printf "%s" "${__p:${text_start}}" );
                __AS=$?;
                local text_part="${__AMBER_VAL_63}"
                if [ $(echo $([ "_${text_part}" == "_" ]; echo $?) '&&' $(echo ${remaining_width} '>' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                    truncate_text__525_v0 "${text_part}" ${remaining_width};
                    __AF_truncate_text525_v0__208_37="${__AF_truncate_text525_v0}";
                    local truncated="${__AF_truncate_text525_v0__208_37}"
                    result+="${truncated}"
                    get_visible_len__524_v0 "${truncated}";
                    __AF_get_visible_len524_v0__210_40="$__AF_get_visible_len524_v0";
                    remaining_width=$(echo ${remaining_width} '-' "$__AF_get_visible_len524_v0__210_40" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
fi
else
                # No 'm' found, treat as text
                if [ $(echo $([ "_${part}" == "_" ]; echo $?) '&&' $(echo ${remaining_width} '>' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                    truncate_text__525_v0 "${part}" ${remaining_width};
                    __AF_truncate_text525_v0__215_37="${__AF_truncate_text525_v0}";
                    local truncated="${__AF_truncate_text525_v0__215_37}"
                    result+="${truncated}"
                    get_visible_len__524_v0 "${truncated}";
                    __AF_get_visible_len524_v0__217_40="$__AF_get_visible_len524_v0";
                    remaining_width=$(echo ${remaining_width} '-' "$__AF_get_visible_len524_v0__217_40" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
fi
fi
fi
done
    __AF_truncate_ansi526_v0="${result}";
    return 0
}
cutoff_text__527_v0() {
    local text=$1
    local max_width=$2
    get_visible_len__524_v0 "${text}";
    __AF_get_visible_len524_v0__229_23="$__AF_get_visible_len524_v0";
    local visible_len="$__AF_get_visible_len524_v0__229_23"
    if [ $(echo ${visible_len} '<=' ${max_width} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        __AF_cutoff_text527_v0="${text}";
        return 0
fi
    truncate_ansi__526_v0 "${text}" $(echo ${max_width} '-' 3 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
    __AF_truncate_ansi526_v0__233_12="${__AF_truncate_ansi526_v0}";
    __AF_cutoff_text527_v0="${__AF_truncate_ansi526_v0__233_12}""...";
    return 0
}
# // Application Utilities /////
render_tooltip__528_v0() {
    local items=("${!1}")
    local total_len=$2
    local term_width=$3
    local separator=" • "
    local separator_len=3
    # Fast path: no truncation needed
    if [ $(echo ${total_len} '<=' ${term_width} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        local iter=0
        while :
do
            if [ $(echo ${iter} '>=' "${#items[@]}" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                break
elif [ $(echo ${iter} '>' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                eprintf_colored__508_v0 "${separator}" 90;
                __AF_eprintf_colored508_v0__256_27="$__AF_eprintf_colored508_v0";
                echo "$__AF_eprintf_colored508_v0__256_27" > /dev/null 2>&1
fi
            colored__509_v0 "${items[$(echo ${iter} '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')]}" 2;
            __AF_colored509_v0__258_41="${__AF_colored509_v0}";
            __AMBER_ARRAY_64=("");
            eprintf__507_v0 "${items[${iter}]}"" ""${__AF_colored509_v0__258_41}" __AMBER_ARRAY_64[@];
            __AF_eprintf507_v0__258_13="$__AF_eprintf507_v0";
            echo "$__AF_eprintf507_v0__258_13" > /dev/null 2>&1
            iter=$(echo ${iter} '+' 2 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
done
else
        # Slow path: truncate
        local current_len=0
        local first=1
        local iter=0
        while :
do
            if [ $(echo ${iter} '>=' "${#items[@]}" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                break
fi
            local key="${items[${iter}]}"
            local action="${items[$(echo ${iter} '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')]}"
            __AMBER_LEN="${key}";
            __AMBER_LEN="${action}";
            local part_len=$(echo $(echo "${#__AMBER_LEN}" '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '+' "${#__AMBER_LEN}" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
            local needed=${part_len}
            if [ $(echo  '!' ${first} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                needed=$(echo ${needed} '+' ${separator_len} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
fi
            if [ $(echo $(echo ${current_len} '+' ${needed} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '>' ${term_width} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                break
fi
            if [ $(echo  '!' ${first} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                eprintf_colored__508_v0 "${separator}" 90;
                __AF_eprintf_colored508_v0__284_17="$__AF_eprintf_colored508_v0";
                echo "$__AF_eprintf_colored508_v0__284_17" > /dev/null 2>&1
fi
            colored__509_v0 "${action}" 2;
            __AF_colored509_v0__286_33="${__AF_colored509_v0}";
            __AMBER_ARRAY_65=("");
            eprintf__507_v0 "${key}"" ""${__AF_colored509_v0__286_33}" __AMBER_ARRAY_65[@];
            __AF_eprintf507_v0__286_13="$__AF_eprintf507_v0";
            echo "$__AF_eprintf507_v0__286_13" > /dev/null 2>&1
            current_len=$(echo ${current_len} '+' ${needed} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
            first=0
            iter=$(echo ${iter} '+' 2 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
done
fi
}
xyl_input__578_v0() {
    local prompt=$1
    local placeholder=$2
    local header=$3
    local password=$4
    stty_lock__469_v0 ;
    __AF_stty_lock469_v0__18_5="$__AF_stty_lock469_v0";
    echo "$__AF_stty_lock469_v0__18_5" > /dev/null 2>&1
    term_width__473_v0 ;
    __AF_term_width473_v0__20_22="$__AF_term_width473_v0";
    local term_width="$__AF_term_width473_v0__20_22"
    if [ $([ "_${header}" == "_" ]; echo $?) != 0 ]; then
        cutoff_text__527_v0 "${header}" ${term_width};
        __AF_cutoff_text527_v0__23_17="${__AF_cutoff_text527_v0}";
        __AMBER_ARRAY_66=("");
        eprintf__507_v0 "${__AF_cutoff_text527_v0__23_17}""
" __AMBER_ARRAY_66[@];
        __AF_eprintf507_v0__23_9="$__AF_eprintf507_v0";
        echo "$__AF_eprintf507_v0__23_9" > /dev/null 2>&1
fi
    new_line__514_v0 2;
    __AF_new_line514_v0__26_5="$__AF_new_line514_v0";
    echo "$__AF_new_line514_v0__26_5" > /dev/null 2>&1
    # "enter submit" = 12
    __AMBER_ARRAY_67=("enter" "submit");
    render_tooltip__528_v0 __AMBER_ARRAY_67[@] 12 ${term_width};
    __AF_render_tooltip528_v0__28_5="$__AF_render_tooltip528_v0";
    echo "$__AF_render_tooltip528_v0__28_5" > /dev/null 2>&1
    go_up__515_v0 2;
    __AF_go_up515_v0__29_5="$__AF_go_up515_v0";
    echo "$__AF_go_up515_v0__29_5" > /dev/null 2>&1
    __AMBER_ARRAY_68=("");
    eprintf__507_v0 "\x1b[99999D" __AMBER_ARRAY_68[@];
    __AF_eprintf507_v0__30_5="$__AF_eprintf507_v0";
    echo "$__AF_eprintf507_v0__30_5" > /dev/null 2>&1
    __AMBER_ARRAY_69=("");
    eprintf__507_v0 "${prompt}" __AMBER_ARRAY_69[@];
    __AF_eprintf507_v0__32_5="$__AF_eprintf507_v0";
    echo "$__AF_eprintf507_v0__32_5" > /dev/null 2>&1
    eprintf_colored__508_v0 "${placeholder}" 90;
    __AF_eprintf_colored508_v0__33_5="$__AF_eprintf_colored508_v0";
    echo "$__AF_eprintf_colored508_v0__33_5" > /dev/null 2>&1
    get_char__504_v0 ;
    __AF_get_char504_v0__35_16="${__AF_get_char504_v0}";
    local char="${__AF_get_char504_v0__35_16}"
    __AMBER_LEN="${prompt}";
    remove__510_v0 "${#__AMBER_LEN}";
    __AF_remove510_v0__36_5="$__AF_remove510_v0";
    echo "$__AF_remove510_v0__36_5" > /dev/null 2>&1
    __AMBER_LEN="${placeholder}";
    remove__510_v0 $(echo "${#__AMBER_LEN}" '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
    __AF_remove510_v0__37_5="$__AF_remove510_v0";
    echo "$__AF_remove510_v0__37_5" > /dev/null 2>&1
    local text=""
    if [ $(echo  '!' ${password} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        stty_unlock__470_v0 ;
        __AF_stty_unlock470_v0__41_9="$__AF_stty_unlock470_v0";
        echo "$__AF_stty_unlock470_v0__41_9" > /dev/null 2>&1
        __AMBER_VAL_70=$( read -e -i ${char} -p "${prompt}" text < /dev/tty; printf "%s" "$text" );
        __AS=$?;
        text="${__AMBER_VAL_70}"
else
        stty_unlock__470_v0 ;
        __AF_stty_unlock470_v0__44_9="$__AF_stty_unlock470_v0";
        echo "$__AF_stty_unlock470_v0__44_9" > /dev/null 2>&1
        __AMBER_VAL_71=$( read -es -i ${char} -p "${prompt}" text < /dev/tty; printf "%s" "$text" );
        __AS=$?;
        text="${__AMBER_VAL_71}"
fi
    stty_lock__469_v0 ;
    __AF_stty_lock469_v0__48_5="$__AF_stty_lock469_v0";
    echo "$__AF_stty_lock469_v0__48_5" > /dev/null 2>&1
    # Calculate how many lines the input takes up (prompt + text may wrap)
    get_visible_len__524_v0 "${prompt}""${text}";
    __AF_get_visible_len524_v0__51_29="$__AF_get_visible_len524_v0";
    local input_display_len="$__AF_get_visible_len524_v0__51_29"
    math_ceil__407_v0 $(echo ${input_display_len} '/' ${term_width} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
    __AF_math_ceil407_v0__52_23="$__AF_math_ceil407_v0";
    local input_lines="$__AF_math_ceil407_v0__52_23"
    if [ $(echo ${input_lines} '<' 3 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        go_down__516_v0 $(echo 2 '-' ${input_lines} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
        __AF_go_down516_v0__55_9="$__AF_go_down516_v0";
        echo "$__AF_go_down516_v0__55_9" > /dev/null 2>&1
        remove_line__511_v0 2;
        __AF_remove_line511_v0__56_9="$__AF_remove_line511_v0";
        echo "$__AF_remove_line511_v0__56_9" > /dev/null 2>&1
        remove_current_line__512_v0 ;
        __AF_remove_current_line512_v0__57_9="$__AF_remove_current_line512_v0";
        echo "$__AF_remove_current_line512_v0__57_9" > /dev/null 2>&1
fi
    if [ $(echo ${input_lines} '>=' 3 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        remove_line__511_v0 ${input_lines};
        __AF_remove_line511_v0__60_9="$__AF_remove_line511_v0";
        echo "$__AF_remove_line511_v0__60_9" > /dev/null 2>&1
fi
    if [ $([ "_${header}" == "_" ]; echo $?) != 0 ]; then
        remove_line__511_v0 1;
        __AF_remove_line511_v0__63_9="$__AF_remove_line511_v0";
        echo "$__AF_remove_line511_v0__63_9" > /dev/null 2>&1
        remove_current_line__512_v0 ;
        __AF_remove_current_line512_v0__64_9="$__AF_remove_current_line512_v0";
        echo "$__AF_remove_current_line512_v0__64_9" > /dev/null 2>&1
fi
    stty_unlock__470_v0 ;
    __AF_stty_unlock470_v0__67_5="$__AF_stty_unlock470_v0";
    echo "$__AF_stty_unlock470_v0__67_5" > /dev/null 2>&1
    __AF_xyl_input578_v0="${text}";
    return 0
}
print_input_help__654_v0() {
    echo "Usage: ./xylitol.sh input [flags]"
    echo ""
    colored_primary__489_v0 "input";
    __AF_colored_primary489_v0__7_12="${__AF_colored_primary489_v0}";
    __AMBER_ARRAY_72=("");
    printf__99_v0 "${__AF_colored_primary489_v0__7_12}" __AMBER_ARRAY_72[@];
    __AF_printf99_v0__7_5="$__AF_printf99_v0";
    echo "$__AF_printf99_v0__7_5" > /dev/null 2>&1
    __AMBER_ARRAY_73=("");
    printf__99_v0 " - Prompt for some input from the user." __AMBER_ARRAY_73[@];
    __AF_printf99_v0__8_5="$__AF_printf99_v0";
    echo "$__AF_printf99_v0__8_5" > /dev/null 2>&1
    echo ""
    echo ""
    colored_secondary__490_v0 "Flags: ";
    __AF_colored_secondary490_v0__11_12="${__AF_colored_secondary490_v0}";
    __AMBER_ARRAY_74=("");
    printf__99_v0 "${__AF_colored_secondary490_v0__11_12}""
" __AMBER_ARRAY_74[@];
    __AF_printf99_v0__11_5="$__AF_printf99_v0";
    echo "$__AF_printf99_v0__11_5" > /dev/null 2>&1
    echo "  -h, --help                 Show this help message"
    echo "  --placeholder=\"<text>\"     Set the placeholder text (default: 'Type here...')"
    echo "  --prompt=\"<text>\"          Set the prompt text (default: '> ')"
    echo "  --header=\"<text>\"          Set a header text to display above the prompt (ANSI escape supported)"
    echo "  --password                 Hide input (for password entry)"
    echo ""
}
execute_input__705_v0() {
    local parameters=("${!1}")
    local prompt="> "
    local placeholder="Type here..."
    local header=""
    local password=0
    for param in "${parameters[@]}"; do
        match_regex__17_v0 "${param}" "^-h\$" 0;
        __AF_match_regex17_v0__13_12="$__AF_match_regex17_v0";
        match_regex__17_v0 "${param}" "^--help\$" 0;
        __AF_match_regex17_v0__13_42="$__AF_match_regex17_v0";
        if [ $(echo "$__AF_match_regex17_v0__13_12" '||' "$__AF_match_regex17_v0__13_42" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            print_input_help__654_v0 ;
            __AF_print_input_help654_v0__14_13="$__AF_print_input_help654_v0";
            echo "$__AF_print_input_help654_v0__14_13" > /dev/null 2>&1
            exit 0
fi
        match_regex__17_v0 "${param}" "^--prompt=.*\$" 0;
        __AF_match_regex17_v0__17_12="$__AF_match_regex17_v0";
        if [ "$__AF_match_regex17_v0__17_12" != 0 ]; then
            split__3_v0 "${param}" "=";
            __AF_split3_v0__18_26=("${__AF_split3_v0[@]}");
            local result=("${__AF_split3_v0__18_26[@]}")
            prompt="${result[1]}"
fi
        match_regex__17_v0 "${param}" "^--placeholder=.*\$" 0;
        __AF_match_regex17_v0__21_12="$__AF_match_regex17_v0";
        if [ "$__AF_match_regex17_v0__21_12" != 0 ]; then
            split__3_v0 "${param}" "=";
            __AF_split3_v0__22_26=("${__AF_split3_v0[@]}");
            local result=("${__AF_split3_v0__22_26[@]}")
            placeholder="${result[1]}"
fi
        match_regex__17_v0 "${param}" "^--header=.*\$" 0;
        __AF_match_regex17_v0__25_12="$__AF_match_regex17_v0";
        if [ "$__AF_match_regex17_v0__25_12" != 0 ]; then
            split__3_v0 "${param}" "=";
            __AF_split3_v0__26_26=("${__AF_split3_v0[@]}");
            local result=("${__AF_split3_v0__26_26[@]}")
            header="${result[1]}"
fi
        match_regex__17_v0 "${param}" "^--password\$" 0;
        __AF_match_regex17_v0__29_12="$__AF_match_regex17_v0";
        if [ "$__AF_match_regex17_v0__29_12" != 0 ]; then
            password=1
fi
done
    has_ansi_escape__520_v0 "${header}";
    __AF_has_ansi_escape520_v0__34_42="$__AF_has_ansi_escape520_v0";
    escape_ansi__521_v0 "${header}";
    __AF_escape_ansi521_v0__34_71="${__AF_escape_ansi521_v0}";
    colored_primary__489_v0 "${header}";
    __AF_colored_primary489_v0__34_109="${__AF_colored_primary489_v0}";
    local display_header=$(if [ $(echo $([ "_${header}" != "_" ]; echo $?) '||' "$__AF_has_ansi_escape520_v0__34_42" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then echo "${__AF_escape_ansi521_v0__34_71}"; else echo "\\x1b[1m""${__AF_colored_primary489_v0__34_109}"; fi)
    xyl_input__578_v0 "${prompt}" "${placeholder}" "${display_header}" ${password};
    __AF_xyl_input578_v0__35_12="${__AF_xyl_input578_v0}";
    __AF_execute_input705_v0="${__AF_xyl_input578_v0__35_12}";
    return 0
}

# Perl Extensions Utilities
__AMBER_VAL_75=$( echo "$XYLITOL_USE_PERL" );
__AS=$?;
__18__perl_disabled=$([ "_${__AMBER_VAL_75}" != "_No" ]; echo $?)
__AMBER_VAL_76=$( command -v perl > /dev/null && echo 0 || echo 1 );
__AS=$?;
__19__perl_available=$(echo $(echo  '!' ${__18__perl_disabled} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '&&' $([ "_${__AMBER_VAL_76}" != "_0" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
perl_get_cjk_width__812_v0() {
    local text=$1
    if [ $(echo  '!' ${__19__perl_available} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        __AF_perl_get_cjk_width812_v0='';
        return 1
fi
    __AMBER_VAL_77=$( perl -CSDA -E '$w=0;$w+=/\p{EastAsianWidth=Wide}|\p{EastAsianWidth=Fullwidth}|\p{EastAsianWidth=Ambiguous}/?2:1 for split//,shift; say $w' "${text}" 2>/dev/null );
    __AS=$?;
if [ $__AS != 0 ]; then
__AF_perl_get_cjk_width812_v0=''
return $__AS
fi;
    local width_str="${__AMBER_VAL_77}"
    parse_number__12_v0 "${width_str}";
    __AS=$?;
if [ $__AS != 0 ]; then
__AF_perl_get_cjk_width812_v0=''
return $__AS
fi;
    __AF_parse_number12_v0__14_17="$__AF_parse_number12_v0";
    local width="$__AF_parse_number12_v0__14_17"
    __AF_perl_get_cjk_width812_v0=${width};
    return 0
}
perl_truncate_cjk__813_v0() {
    local text=$1
    local max_width=$2
    if [ $(echo  '!' ${__19__perl_available} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        __AF_perl_truncate_cjk813_v0='';
        return 1
fi
    __AMBER_VAL_78=$( perl -CSDA -E '$t=shift;$m=shift;$w=0;$r="";$c=/\p{EastAsianWidth=Wide}|\p{EastAsianWidth=Fullwidth}|\p{EastAsianWidth=Ambiguous}/?2:1,($w+$c<=$m?($w+=$c,$r.=$_):last) for split//,$t; print $r' "${text}" ${max_width} 2>/dev/null );
    __AS=$?;
if [ $__AS != 0 ]; then
__AF_perl_truncate_cjk813_v0=''
return $__AS
fi;
    local result="${__AMBER_VAL_78}"
    __AF_perl_truncate_cjk813_v0="${result}";
    return 0
}
# global variables to store terminal size
# (prevent multiple queries in one session)
__20__got_term_size=0
__AMBER_ARRAY_79=(80 24);
__21__term_size=("${__AMBER_ARRAY_79[@]}")
# stty lock/unlock using environment variable for cross-module state
 export XYLITOL_RUNTIME_STTY_COUNT=0 ;
__AS=$?
stty_lock__820_v0() {
    __AMBER_VAL_80=$( echo "${XYLITOL_RUNTIME_STTY_COUNT:-0}" );
    __AS=$?;
    local count="${__AMBER_VAL_80}"
    parse_number__12_v0 "${count}";
    __AS=$?;
if [ $__AS != 0 ]; then
        echo 0 > /dev/null 2>&1
fi;
    __AF_parse_number12_v0__14_21="$__AF_parse_number12_v0";
    local count_num="$__AF_parse_number12_v0__14_21"
    if [ $(echo ${count_num} '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
         stty -echo < /dev/tty ;
        __AS=$?
fi
    count_num=$(echo ${count_num} '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
     export XYLITOL_RUNTIME_STTY_COUNT=${count_num} ;
    __AS=$?
}
stty_unlock__821_v0() {
    __AMBER_VAL_81=$( echo "${XYLITOL_RUNTIME_STTY_COUNT:-0}" );
    __AS=$?;
    local count="${__AMBER_VAL_81}"
    parse_number__12_v0 "${count}";
    __AS=$?;
if [ $__AS != 0 ]; then
        echo 0 > /dev/null 2>&1
fi;
    __AF_parse_number12_v0__25_21="$__AF_parse_number12_v0";
    local count_num="$__AF_parse_number12_v0__25_21"
    if [ $(echo ${count_num} '>' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        count_num=$(echo ${count_num} '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
         export XYLITOL_RUNTIME_STTY_COUNT=${count_num} ;
        __AS=$?
        if [ $(echo ${count_num} '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
             stty echo < /dev/tty ;
            __AS=$?
fi
fi
}
get_term_size__822_v0() {
    # Query terminal size with \x1b[18t, response format: \x1b[8;rows;colst
    __AMBER_VAL_82=$( printf '\x1b[18t' > /dev/tty; IFS=';' read -rsd t _ignore height width < /dev/tty; echo "$height; $width" );
    __AS=$?;
    local result="${__AMBER_VAL_82}"
    split__3_v0 "${result}" ";";
    __AF_split3_v0__39_17=("${__AF_split3_v0[@]}");
    local parts=("${__AF_split3_v0__39_17[@]}")
    if [ $(echo "${#parts[@]}" '!=' 2 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        __AF_get_term_size822_v0='';
        return 1
fi
    parse_number__12_v0 "${parts[0]}";
    __AS=$?;
if [ $__AS != 0 ]; then
__AF_get_term_size822_v0=''
return $__AS
fi;
    __AF_parse_number12_v0__43_16="$__AF_parse_number12_v0";
    local rows="$__AF_parse_number12_v0__43_16"
    parse_number__12_v0 "${parts[1]}";
    __AS=$?;
if [ $__AS != 0 ]; then
__AF_get_term_size822_v0=''
return $__AS
fi;
    __AF_parse_number12_v0__44_16="$__AF_parse_number12_v0";
    local cols="$__AF_parse_number12_v0__44_16"
    __AMBER_ARRAY_83=(${cols} ${rows});
    __21__term_size=("${__AMBER_ARRAY_83[@]}")
    __20__got_term_size=1
}
term_width__824_v0() {
    if [ $(echo  '!' ${__20__got_term_size} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        get_term_size__822_v0 ;
        __AS=$?;
        __AF_get_term_size822_v0__60_15="$__AF_get_term_size822_v0";
        echo "$__AF_get_term_size822_v0__60_15" > /dev/null 2>&1
fi
    __AF_term_width824_v0="${__21__term_size[0]}";
    return 0
}
term_height__825_v0() {
    if [ $(echo  '!' ${__20__got_term_size} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        get_term_size__822_v0 ;
        __AS=$?;
        __AF_get_term_size822_v0__68_15="$__AF_get_term_size822_v0";
        echo "$__AF_get_term_size822_v0__68_15" > /dev/null 2>&1
fi
    __AF_term_height825_v0="${__21__term_size[1]}";
    return 0
}
# A global variable indicating if the terminal supports truecolor.
# "None" or "Yes" or "No"
# 
# This value is only updated by the `get_supports_truecolor` function
# executed by `colored_rgb` on its first call.
__22__supports_truecolor="None"
# A global variable indicating if the Xylitol colors have been loaded from environment variables.
__23__got_xylitol_colors=0
__AMBER_ARRAY_84=(3 207 159 92);
__24__primary_color=("${__AMBER_ARRAY_84[@]}")
__AMBER_ARRAY_85=(3 118 206 94);
__25__secondary_color=("${__AMBER_ARRAY_85[@]}")
__AMBER_ARRAY_86=(234 72 121 95);
__26__accent_color=("${__AMBER_ARRAY_86[@]}")
get_supports_truecolor__835_v0() {
    env_const_get__89_v0 "XYLITOL_TRUECOLOR";
    __AS=$?;
if [ $__AS != 0 ]; then
        echo "" > /dev/null 2>&1
fi;
    __AF_env_const_get89_v0__20_18="${__AF_env_const_get89_v0}";
    local config="${__AF_env_const_get89_v0__20_18}"
    if [ $([ "_${config}" != "_No" ]; echo $?) != 0 ]; then
        __22__supports_truecolor="No"
        __AF_get_supports_truecolor835_v0=0;
        return 0
fi
    env_const_get__89_v0 "COLORTERM";
    __AS=$?;
if [ $__AS != 0 ]; then
        __22__supports_truecolor="No"
        __AF_get_supports_truecolor835_v0=0;
        return 0
fi;
    __AF_env_const_get89_v0__25_21="${__AF_env_const_get89_v0}";
    local colorterm="${__AF_env_const_get89_v0__25_21}"
    __22__supports_truecolor=$(if [ $(echo $([ "_${colorterm}" != "_truecolor" ]; echo $?) '||' $([ "_${colorterm}" != "_24bit" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then echo "Yes"; else echo "No"; fi)
    __AF_get_supports_truecolor835_v0=$([ "_${__22__supports_truecolor}" != "_Yes" ]; echo $?);
    return 0
}
colored_rgb__836_v0() {
    local message=$1
    local r=$2
    local g=$3
    local b=$4
    local fallback=$5
    if [ $([ "_${__22__supports_truecolor}" != "_Yes" ]; echo $?) != 0 ]; then
                    __AF_colored_rgb836_v0="\x1b[38;2;${r};${g};${b}m""${message}""\x1b[0m";
            return 0
elif [ $([ "_${__22__supports_truecolor}" != "_None" ]; echo $?) != 0 ]; then
                    get_supports_truecolor__835_v0 ;
            __AF_get_supports_truecolor835_v0__50_17="$__AF_get_supports_truecolor835_v0";
            if [ "$__AF_get_supports_truecolor835_v0__50_17" != 0 ]; then
                                    __AF_colored_rgb836_v0="\x1b[38;2;${r};${g};${b}m""${message}""\x1b[0m";
                    return 0
elif [ $(echo ${fallback} '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                __AF_colored_rgb836_v0="${message}";
                return 0
else
                __AF_colored_rgb836_v0="\x1b[${fallback}m""${message}""\x1b[0m";
                return 0
fi
else
        if [ $(echo ${fallback} '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            __AF_colored_rgb836_v0="${message}";
            return 0
fi
        __AF_colored_rgb836_v0="\x1b[${fallback}m""${message}""\x1b[0m";
        return 0
fi
}
inner_get_xylitol_colors__838_v0() {
    if [ $(echo  '!' ${__23__got_xylitol_colors} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        env_const_get__89_v0 "XYLITOL_PRIMARY_COLOR";
        __AS=$?;
if [ $__AS != 0 ]; then
            echo "" > /dev/null 2>&1
fi;
        __AF_env_const_get89_v0__110_27="${__AF_env_const_get89_v0}";
        local primary_env="${__AF_env_const_get89_v0__110_27}"
        if [ $([ "_${primary_env}" == "_" ]; echo $?) != 0 ]; then
            split__3_v0 "${primary_env}" ";";
            __AF_split3_v0__112_25=("${__AF_split3_v0[@]}");
            local parts=("${__AF_split3_v0__112_25[@]}")
            if [ $(echo "${#parts[@]}" '==' 4 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                parse_number__12_v0 "${parts[0]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors838_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__115_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[1]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors838_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__116_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[2]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors838_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__117_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[3]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors838_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__118_21="$__AF_parse_number12_v0";
                __AMBER_ARRAY_87=("$__AF_parse_number12_v0__115_21" "$__AF_parse_number12_v0__116_21" "$__AF_parse_number12_v0__117_21" "$__AF_parse_number12_v0__118_21");
                __24__primary_color=("${__AMBER_ARRAY_87[@]}")
fi
fi
        env_const_get__89_v0 "XYLITOL_SECONDARY_COLOR";
        __AS=$?;
if [ $__AS != 0 ]; then
            echo "" > /dev/null 2>&1
fi;
        __AF_env_const_get89_v0__123_29="${__AF_env_const_get89_v0}";
        local secondary_env="${__AF_env_const_get89_v0__123_29}"
        if [ $([ "_${secondary_env}" == "_" ]; echo $?) != 0 ]; then
            split__3_v0 "${secondary_env}" ";";
            __AF_split3_v0__125_25=("${__AF_split3_v0[@]}");
            local parts=("${__AF_split3_v0__125_25[@]}")
            if [ $(echo "${#parts[@]}" '==' 4 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                parse_number__12_v0 "${parts[0]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors838_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__128_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[1]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors838_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__129_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[2]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors838_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__130_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[3]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors838_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__131_21="$__AF_parse_number12_v0";
                __AMBER_ARRAY_88=("$__AF_parse_number12_v0__128_21" "$__AF_parse_number12_v0__129_21" "$__AF_parse_number12_v0__130_21" "$__AF_parse_number12_v0__131_21");
                __25__secondary_color=("${__AMBER_ARRAY_88[@]}")
fi
fi
        env_const_get__89_v0 "XYLITOL_ACCENT_COLOR";
        __AS=$?;
if [ $__AS != 0 ]; then
            echo "" > /dev/null 2>&1
fi;
        __AF_env_const_get89_v0__136_26="${__AF_env_const_get89_v0}";
        local accent_env="${__AF_env_const_get89_v0__136_26}"
        if [ $([ "_${accent_env}" == "_" ]; echo $?) != 0 ]; then
            split__3_v0 "${accent_env}" ";";
            __AF_split3_v0__138_25=("${__AF_split3_v0[@]}");
            local parts=("${__AF_split3_v0__138_25[@]}")
            if [ $(echo "${#parts[@]}" '==' 4 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                parse_number__12_v0 "${parts[0]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors838_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__141_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[1]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors838_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__142_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[2]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors838_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__143_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[3]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors838_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__144_21="$__AF_parse_number12_v0";
                __AMBER_ARRAY_89=("$__AF_parse_number12_v0__141_21" "$__AF_parse_number12_v0__142_21" "$__AF_parse_number12_v0__143_21" "$__AF_parse_number12_v0__144_21");
                __26__accent_color=("${__AMBER_ARRAY_89[@]}")
fi
fi
        __23__got_xylitol_colors=1
fi
}
get_xylitol_colors__839_v0() {
    inner_get_xylitol_colors__838_v0 ;
    __AS=$?;
if [ $__AS != 0 ]; then
        echo_colored__105_v0 "WARN: Failed to parse Xylitol colors from envs." 33;
        __AF_echo_colored105_v0__155_9="$__AF_echo_colored105_v0";
        echo "$__AF_echo_colored105_v0__155_9" > /dev/null 2>&1
fi;
    __AF_inner_get_xylitol_colors838_v0__154_5="$__AF_inner_get_xylitol_colors838_v0";
    echo "$__AF_inner_get_xylitol_colors838_v0__154_5" > /dev/null 2>&1
    __23__got_xylitol_colors=1
}
colored_primary__840_v0() {
    local message=$1
    if [ $(echo  '!' ${__23__got_xylitol_colors} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        get_xylitol_colors__839_v0 ;
        __AF_get_xylitol_colors839_v0__162_9="$__AF_get_xylitol_colors839_v0";
        echo "$__AF_get_xylitol_colors839_v0__162_9" > /dev/null 2>&1
fi
    colored_rgb__836_v0 "${message}" "${__24__primary_color[0]}" "${__24__primary_color[1]}" "${__24__primary_color[2]}" "${__24__primary_color[3]}";
    __AF_colored_rgb836_v0__164_12="${__AF_colored_rgb836_v0}";
    __AF_colored_primary840_v0="${__AF_colored_rgb836_v0__164_12}";
    return 0
}
colored_secondary__841_v0() {
    local message=$1
    if [ $(echo  '!' ${__23__got_xylitol_colors} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        get_xylitol_colors__839_v0 ;
        __AF_get_xylitol_colors839_v0__169_9="$__AF_get_xylitol_colors839_v0";
        echo "$__AF_get_xylitol_colors839_v0__169_9" > /dev/null 2>&1
fi
    colored_rgb__836_v0 "${message}" "${__25__secondary_color[0]}" "${__25__secondary_color[1]}" "${__25__secondary_color[2]}" "${__25__secondary_color[3]}";
    __AF_colored_rgb836_v0__171_12="${__AF_colored_rgb836_v0}";
    __AF_colored_secondary841_v0="${__AF_colored_rgb836_v0__171_12}";
    return 0
}
# // IO Functions /////
get_key__856_v0() {
    __AMBER_VAL_90=$( read -rsn1 k < /dev/tty; if [[ "$k" == $'\e' ]]; then read -rsn2 r < /dev/tty; k+=$r; fi; printf '%q' "$k" );
    __AS=$?;
    local var="${__AMBER_VAL_90}"
    if [ $([ "_${var}" != "_\$'\E[A'" ]; echo $?) != 0 ]; then
        __AF_get_key856_v0="UP";
        return 0
elif [ $([ "_${var}" != "_\$'\E[B'" ]; echo $?) != 0 ]; then
        __AF_get_key856_v0="DOWN";
        return 0
elif [ $([ "_${var}" != "_\$'\E[C'" ]; echo $?) != 0 ]; then
        __AF_get_key856_v0="RIGHT";
        return 0
elif [ $([ "_${var}" != "_\$'\E[D'" ]; echo $?) != 0 ]; then
        __AF_get_key856_v0="LEFT";
        return 0
elif [ $([ "_${var}" != "_\$'\177'" ]; echo $?) != 0 ]; then
        __AF_get_key856_v0="BACKSPACE";
        return 0
elif [ $([ "_${var}" != "_''" ]; echo $?) != 0 ]; then
        __AF_get_key856_v0="INPUT";
        return 0
else
        __AF_get_key856_v0="${var}";
        return 0
fi
}
eprintf__858_v0() {
    local format=$1
    local args=("${!2}")
     args=("${format}" "${args[@]}") ;
    __AS=$?
     printf "${args[@]}" >&2 ;
    __AS=$?
}
eprintf_colored__859_v0() {
    local message=$1
    local color=$2
    # Prints an error message with a specified color.
    __AMBER_ARRAY_91=("${message}");
    eprintf__858_v0 "\x1b[${color}m%s\x1b[0m" __AMBER_ARRAY_91[@];
    __AF_eprintf858_v0__42_5="$__AF_eprintf858_v0";
    echo "$__AF_eprintf858_v0__42_5" > /dev/null 2>&1
}
colored__860_v0() {
    local message=$1
    local color=$2
    # Returns a text wrapped in color codes.
    __AF_colored860_v0="\x1b[${color}m""${message}""\x1b[0m";
    return 0
}
remove_line__862_v0() {
    local cnt=$1
     printf '\x1b[2K\x1b[1A%.0s' $(seq ${cnt}) >&2 ;
    __AS=$?
    __AMBER_ARRAY_92=("");
    eprintf__858_v0 "\x1b[9999D" __AMBER_ARRAY_92[@];
    __AF_eprintf858_v0__58_5="$__AF_eprintf858_v0";
    echo "$__AF_eprintf858_v0__58_5" > /dev/null 2>&1
}
remove_current_line__863_v0() {
    __AMBER_ARRAY_93=("");
    eprintf__858_v0 "\x1b[2K\x1b[9999D" __AMBER_ARRAY_93[@];
    __AF_eprintf858_v0__63_5="$__AF_eprintf858_v0";
    echo "$__AF_eprintf858_v0__63_5" > /dev/null 2>&1
}
print_blank__864_v0() {
    local cnt=$1
     printf '%*s' "${cnt}" ' ' >&2 ;
    __AS=$?
}
new_line__865_v0() {
    local cnt=$1
    for i in $(seq 0 $(echo ${cnt} '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')); do
        __AMBER_ARRAY_94=("");
        eprintf__858_v0 "
" __AMBER_ARRAY_94[@];
        __AF_eprintf858_v0__75_9="$__AF_eprintf858_v0";
        echo "$__AF_eprintf858_v0__75_9" > /dev/null 2>&1
done
}
go_up__866_v0() {
    local cnt=$1
    __AMBER_ARRAY_95=("");
    eprintf__858_v0 "\x1b[${cnt}A" __AMBER_ARRAY_95[@];
    __AF_eprintf858_v0__81_5="$__AF_eprintf858_v0";
    echo "$__AF_eprintf858_v0__81_5" > /dev/null 2>&1
}
go_down__867_v0() {
    local cnt=$1
    __AMBER_ARRAY_96=("");
    eprintf__858_v0 "\x1b[${cnt}B" __AMBER_ARRAY_96[@];
    __AF_eprintf858_v0__86_5="$__AF_eprintf858_v0";
    echo "$__AF_eprintf858_v0__86_5" > /dev/null 2>&1
}
# move the cursor up or down `cnt` lines.
go_up_or_down__868_v0() {
    local cnt=$1
    if [ $(echo ${cnt} '>' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        go_down__867_v0 ${cnt};
        __AF_go_down867_v0__92_9="$__AF_go_down867_v0";
        echo "$__AF_go_down867_v0__92_9" > /dev/null 2>&1
else
        go_up__866_v0 $(echo  '-' ${cnt} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
        __AF_go_up866_v0__94_9="$__AF_go_up866_v0";
        echo "$__AF_go_up866_v0__94_9" > /dev/null 2>&1
fi
}
hide_cursor__869_v0() {
    __AMBER_ARRAY_97=("");
    eprintf__858_v0 "\x1b[?25l" __AMBER_ARRAY_97[@];
    __AF_eprintf858_v0__99_5="$__AF_eprintf858_v0";
    echo "$__AF_eprintf858_v0__99_5" > /dev/null 2>&1
}
show_cursor__870_v0() {
    __AMBER_ARRAY_98=("");
    eprintf__858_v0 "\x1b[?25h" __AMBER_ARRAY_98[@];
    __AF_eprintf858_v0__103_5="$__AF_eprintf858_v0";
    echo "$__AF_eprintf858_v0__103_5" > /dev/null 2>&1
}
# / Text Utilities /////
has_ansi_escape__871_v0() {
    local text=$1
    # Check for ESC character (0x1B = 27) or literal \x1b[
    __AMBER_VAL_99=$( [[ "${text}" == *$'\x1b'* || "${text}" == *'\x1b['* ]] && echo "1" || echo "0" );
    __AS=$?;
    local has_escape="${__AMBER_VAL_99}"
    __AF_has_ansi_escape871_v0=$([ "_${has_escape}" != "_1" ]; echo $?);
    return 0
}
escape_ansi__872_v0() {
    local text=$1
    __AMBER_VAL_100=$( printf '%s' "${text}" | sed $'s/\x1b/\\x1b/g' );
    __AS=$?;
    __AF_escape_ansi872_v0="${__AMBER_VAL_100}";
    return 0
}
strip_ansi__873_v0() {
    local text=$1
    __AMBER_VAL_101=$( printf "%s" "${text}" | sed $'s/\x1b\[[0-9;]*m//g' | sed 's/\\x1b\[[0-9;]*m//g' );
    __AS=$?;
    __AF_strip_ansi873_v0="${__AMBER_VAL_101}";
    return 0
}
is_all_ascii__874_v0() {
    local text=$1
    __AMBER_VAL_102=$( printf "%s" "${text}" | LC_ALL=C grep -q '^[ -~]*$' && echo 0 || echo 1 );
    __AS=$?;
    local result="${__AMBER_VAL_102}"
    __AF_is_all_ascii874_v0=$([ "_${result}" != "_0" ]; echo $?);
    return 0
}
get_visible_len__875_v0() {
    local text=$1
    strip_ansi__873_v0 "${text}";
    __AF_strip_ansi873_v0__138_20="${__AF_strip_ansi873_v0}";
    local stripped="${__AF_strip_ansi873_v0__138_20}"
    # Check if text is all ASCII
    is_all_ascii__874_v0 "${stripped}";
    __AF_is_all_ascii874_v0__140_12="$__AF_is_all_ascii874_v0";
    if [ $(echo  '!' "$__AF_is_all_ascii874_v0__140_12" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        # Try using perl
        perl_get_cjk_width__812_v0 "${stripped}";
        __AS=$?;
if [ $__AS != 0 ]; then
            __AMBER_LEN="${stripped}";
            __AF_get_visible_len875_v0="${#__AMBER_LEN}";
            return 0
fi;
        __AF_perl_get_cjk_width812_v0__142_16="$__AF_perl_get_cjk_width812_v0";
        __AF_get_visible_len875_v0="$__AF_perl_get_cjk_width812_v0__142_16";
        return 0
else
        __AMBER_LEN="${stripped}";
        __AF_get_visible_len875_v0="${#__AMBER_LEN}";
        return 0
fi
}
truncate_text__876_v0() {
    local text=$1
    local max_width=$2
    get_visible_len__875_v0 "${text}";
    __AF_get_visible_len875_v0__153_23="$__AF_get_visible_len875_v0";
    local visible_len="$__AF_get_visible_len875_v0__153_23"
    if [ $(echo ${visible_len} '<=' ${max_width} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        __AF_truncate_text876_v0="${text}";
        return 0
fi
    is_all_ascii__874_v0 "${text}";
    __AF_is_all_ascii874_v0__157_12="$__AF_is_all_ascii874_v0";
    if [ $(echo  '!' "$__AF_is_all_ascii874_v0__157_12" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        perl_truncate_cjk__813_v0 "${text}" ${max_width};
        __AS=$?;
if [ $__AS != 0 ]; then
             printf "%s" "${text}" | cut -c1-${max_width} ;
            __AS=$?
fi;
        __AF_perl_truncate_cjk813_v0__158_16="${__AF_perl_truncate_cjk813_v0}";
        __AF_truncate_text876_v0="${__AF_perl_truncate_cjk813_v0__158_16}";
        return 0
fi
    __AMBER_VAL_103=$( printf "%s" "${text}" | cut -c1-${max_width} );
    __AS=$?;
    __AF_truncate_text876_v0="${__AMBER_VAL_103}";
    return 0
}
truncate_ansi__877_v0() {
    local text=$1
    local max_width=$2
    has_ansi_escape__871_v0 "${text}";
    __AF_has_ansi_escape871_v0__169_12="$__AF_has_ansi_escape871_v0";
    if [ $(echo  '!' "$__AF_has_ansi_escape871_v0__169_12" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        truncate_text__876_v0 "${text}" ${max_width};
        __AF_truncate_text876_v0__170_16="${__AF_truncate_text876_v0}";
        __AF_truncate_ansi877_v0="${__AF_truncate_text876_v0__170_16}";
        return 0
fi
    # Check if text starts with \x1b[
    __AMBER_VAL_104=$( [[ "${text}" == '\x1b['* ]] && echo "1" || echo "0" );
    __AS=$?;
    local starts_with_ansi="${__AMBER_VAL_104}"
    # Replace \x1b[ with newline, then split
    __AMBER_VAL_105=$( t="${text}"; printf '%s' "${t//\\x1b[/
}" );
    __AS=$?;
    local replaced="${__AMBER_VAL_105}"
    split__3_v0 "${replaced}" "
";
    __AF_split3_v0__179_17=("${__AF_split3_v0[@]}");
    local parts=("${__AF_split3_v0__179_17[@]}")
    local result=""
    local remaining_width=${max_width}
    for idx in $(seq 0 $(echo "${#parts[@]}" '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')); do
        local part="${parts[${idx}]}"
        # If text starts with ANSI, all parts are "ANSIparams m text" format
        # If not, first part is pure text
        if [ $(echo $(echo ${idx} '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '&&' $([ "_${starts_with_ansi}" != "_0" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            # First part is pure text (before any ANSI)
            if [ $(echo $([ "_${part}" == "_" ]; echo $?) '&&' $(echo ${remaining_width} '>' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                truncate_text__876_v0 "${part}" ${remaining_width};
                __AF_truncate_text876_v0__191_33="${__AF_truncate_text876_v0}";
                local truncated="${__AF_truncate_text876_v0__191_33}"
                result+="${truncated}"
                get_visible_len__875_v0 "${truncated}";
                __AF_get_visible_len875_v0__193_36="$__AF_get_visible_len875_v0";
                remaining_width=$(echo ${remaining_width} '-' "$__AF_get_visible_len875_v0__193_36" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
fi
else
            # Part is "ANSIparams m text" format - find first 'm'
            __AMBER_VAL_106=$( __p="${part}"; for ((i=0; i<${#__p}; i++)); do [[ "${__p:$i:1}" == "m" ]] && echo $i && break; done );
            __AS=$?;
            local m_idx="${__AMBER_VAL_106}"
            if [ $([ "_${m_idx}" == "_" ]; echo $?) != 0 ]; then
                # Reconstruct ANSI sequence
                __AMBER_VAL_107=$( __p="${part}"; printf "%s" "${__p:0:${m_idx}}" );
                __AS=$?;
                local ansi_params="${__AMBER_VAL_107}"
                result+="\\x1b[""${ansi_params}""m"
                # Rest is text content
                parse_number__12_v0 "${m_idx}";
                __AS=$?;
                __AF_parse_number12_v0__204_39="$__AF_parse_number12_v0";
                local m_idx_num="$__AF_parse_number12_v0__204_39"
                local text_start=$(echo ${m_idx_num} '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
                __AMBER_VAL_108=$( __p="${part}"; printf "%s" "${__p:${text_start}}" );
                __AS=$?;
                local text_part="${__AMBER_VAL_108}"
                if [ $(echo $([ "_${text_part}" == "_" ]; echo $?) '&&' $(echo ${remaining_width} '>' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                    truncate_text__876_v0 "${text_part}" ${remaining_width};
                    __AF_truncate_text876_v0__208_37="${__AF_truncate_text876_v0}";
                    local truncated="${__AF_truncate_text876_v0__208_37}"
                    result+="${truncated}"
                    get_visible_len__875_v0 "${truncated}";
                    __AF_get_visible_len875_v0__210_40="$__AF_get_visible_len875_v0";
                    remaining_width=$(echo ${remaining_width} '-' "$__AF_get_visible_len875_v0__210_40" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
fi
else
                # No 'm' found, treat as text
                if [ $(echo $([ "_${part}" == "_" ]; echo $?) '&&' $(echo ${remaining_width} '>' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                    truncate_text__876_v0 "${part}" ${remaining_width};
                    __AF_truncate_text876_v0__215_37="${__AF_truncate_text876_v0}";
                    local truncated="${__AF_truncate_text876_v0__215_37}"
                    result+="${truncated}"
                    get_visible_len__875_v0 "${truncated}";
                    __AF_get_visible_len875_v0__217_40="$__AF_get_visible_len875_v0";
                    remaining_width=$(echo ${remaining_width} '-' "$__AF_get_visible_len875_v0__217_40" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
fi
fi
fi
done
    __AF_truncate_ansi877_v0="${result}";
    return 0
}
cutoff_text__878_v0() {
    local text=$1
    local max_width=$2
    get_visible_len__875_v0 "${text}";
    __AF_get_visible_len875_v0__229_23="$__AF_get_visible_len875_v0";
    local visible_len="$__AF_get_visible_len875_v0__229_23"
    if [ $(echo ${visible_len} '<=' ${max_width} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        __AF_cutoff_text878_v0="${text}";
        return 0
fi
    truncate_ansi__877_v0 "${text}" $(echo ${max_width} '-' 3 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
    __AF_truncate_ansi877_v0__233_12="${__AF_truncate_ansi877_v0}";
    __AF_cutoff_text878_v0="${__AF_truncate_ansi877_v0__233_12}""...";
    return 0
}
# // Application Utilities /////
render_tooltip__879_v0() {
    local items=("${!1}")
    local total_len=$2
    local term_width=$3
    local separator=" • "
    local separator_len=3
    # Fast path: no truncation needed
    if [ $(echo ${total_len} '<=' ${term_width} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        local iter=0
        while :
do
            if [ $(echo ${iter} '>=' "${#items[@]}" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                break
elif [ $(echo ${iter} '>' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                eprintf_colored__859_v0 "${separator}" 90;
                __AF_eprintf_colored859_v0__256_27="$__AF_eprintf_colored859_v0";
                echo "$__AF_eprintf_colored859_v0__256_27" > /dev/null 2>&1
fi
            colored__860_v0 "${items[$(echo ${iter} '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')]}" 2;
            __AF_colored860_v0__258_41="${__AF_colored860_v0}";
            __AMBER_ARRAY_109=("");
            eprintf__858_v0 "${items[${iter}]}"" ""${__AF_colored860_v0__258_41}" __AMBER_ARRAY_109[@];
            __AF_eprintf858_v0__258_13="$__AF_eprintf858_v0";
            echo "$__AF_eprintf858_v0__258_13" > /dev/null 2>&1
            iter=$(echo ${iter} '+' 2 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
done
else
        # Slow path: truncate
        local current_len=0
        local first=1
        local iter=0
        while :
do
            if [ $(echo ${iter} '>=' "${#items[@]}" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                break
fi
            local key="${items[${iter}]}"
            local action="${items[$(echo ${iter} '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')]}"
            __AMBER_LEN="${key}";
            __AMBER_LEN="${action}";
            local part_len=$(echo $(echo "${#__AMBER_LEN}" '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '+' "${#__AMBER_LEN}" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
            local needed=${part_len}
            if [ $(echo  '!' ${first} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                needed=$(echo ${needed} '+' ${separator_len} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
fi
            if [ $(echo $(echo ${current_len} '+' ${needed} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '>' ${term_width} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                break
fi
            if [ $(echo  '!' ${first} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                eprintf_colored__859_v0 "${separator}" 90;
                __AF_eprintf_colored859_v0__284_17="$__AF_eprintf_colored859_v0";
                echo "$__AF_eprintf_colored859_v0__284_17" > /dev/null 2>&1
fi
            colored__860_v0 "${action}" 2;
            __AF_colored860_v0__286_33="${__AF_colored860_v0}";
            __AMBER_ARRAY_110=("");
            eprintf__858_v0 "${key}"" ""${__AF_colored860_v0__286_33}" __AMBER_ARRAY_110[@];
            __AF_eprintf858_v0__286_13="$__AF_eprintf858_v0";
            echo "$__AF_eprintf858_v0__286_13" > /dev/null 2>&1
            current_len=$(echo ${current_len} '+' ${needed} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
            first=0
            iter=$(echo ${iter} '+' 2 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
done
fi
}
get_page_options__929_v0() {
    local options=("${!1}")
    local page=$2
    local page_size=$3
    local start=$(echo ${page} '*' ${page_size} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
    local end=$(echo ${start} '+' ${page_size} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
    if [ $(echo ${end} '>' "${#options[@]}" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        end="${#options[@]}"
fi
    __AMBER_ARRAY_111=();
    local result=("${__AMBER_ARRAY_111[@]}")
    for i in $(seq ${start} $(echo ${end} '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')); do
        __AMBER_ARRAY_112=("${options[${i}]}");
        result+=("${__AMBER_ARRAY_112[@]}")
done
    __AF_get_page_options929_v0=("${result[@]}");
    return 0
}
get_page_start__930_v0() {
    local page=$1
    local page_size=$2
    __AF_get_page_start930_v0=$(echo ${page} '*' ${page_size} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
    return 0
}
render_choose_page__931_v0() {
    local page_options=("${!1}")
    local sel=$2
    local cursor=$3
    local display_count=$4
    local term_width=$5
    __AMBER_LEN="${cursor}";
    local cursor_len="${#__AMBER_LEN}"
    local max_option_width=$(echo $(echo ${term_width} '-' ${cursor_len} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
    for i in $(seq 0 $(echo "${#page_options[@]}" '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')); do
        cutoff_text__878_v0 "${page_options[${i}]}" ${max_option_width};
        __AF_cutoff_text878_v0__26_32="${__AF_cutoff_text878_v0}";
        local truncated_option="${__AF_cutoff_text878_v0__26_32}"
        if [ $(echo ${i} '==' ${sel} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            colored_secondary__841_v0 "${cursor}""${truncated_option}""
";
            __AF_colored_secondary841_v0__28_21="${__AF_colored_secondary841_v0}";
            __AMBER_ARRAY_113=("");
            eprintf__858_v0 "${__AF_colored_secondary841_v0__28_21}" __AMBER_ARRAY_113[@];
            __AF_eprintf858_v0__28_13="$__AF_eprintf858_v0";
            echo "$__AF_eprintf858_v0__28_13" > /dev/null 2>&1
else
            print_blank__864_v0 ${cursor_len};
            __AF_print_blank864_v0__30_13="$__AF_print_blank864_v0";
            echo "$__AF_print_blank864_v0__30_13" > /dev/null 2>&1
            __AMBER_ARRAY_114=("");
            eprintf__858_v0 "${truncated_option}""
" __AMBER_ARRAY_114[@];
            __AF_eprintf858_v0__31_13="$__AF_eprintf858_v0";
            echo "$__AF_eprintf858_v0__31_13" > /dev/null 2>&1
fi
done
    local remaining_slots=$(echo ${display_count} '-' "${#page_options[@]}" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
    if [ $(echo ${remaining_slots} '>' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        # Amber bug gaurd
        for _ in $(seq 0 $(echo ${remaining_slots} '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')); do
            __AMBER_ARRAY_115=("");
            eprintf__858_v0 "\x1b[K
" __AMBER_ARRAY_115[@];
            __AF_eprintf858_v0__37_13="$__AF_eprintf858_v0";
            echo "$__AF_eprintf858_v0__37_13" > /dev/null 2>&1
done
fi
}
render_multi_choose_page__932_v0() {
    local page_options=("${!1}")
    local checked=("${!2}")
    local page_start=$3
    local sel=$4
    local cursor=$5
    local display_count=$6
    local term_width=$7
    __AMBER_LEN="${cursor}";
    local cursor_len="${#__AMBER_LEN}"
    local check_mark_len=2
    # "✓ " or "• "
    local max_option_width=$(echo $(echo $(echo ${term_width} '-' ${cursor_len} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '-' ${check_mark_len} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
    for i in $(seq 0 $(echo "${#page_options[@]}" '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')); do
        local global_idx=$(echo ${page_start} '+' ${i} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
        local check_mark=$(if [ "${checked[${global_idx}]}" != 0 ]; then echo "✓ "; else echo "• "; fi)
        cutoff_text__878_v0 "${page_options[${i}]}" ${max_option_width};
        __AF_cutoff_text878_v0__49_32="${__AF_cutoff_text878_v0}";
        local truncated_option="${__AF_cutoff_text878_v0__49_32}"
        if [ $(echo ${i} '==' ${sel} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            colored_secondary__841_v0 "${cursor}""${check_mark}""${truncated_option}""
";
            __AF_colored_secondary841_v0__51_31="${__AF_colored_secondary841_v0}";
            __AMBER_ARRAY_116=("");
            eprintf__858_v0 "${__AF_colored_secondary841_v0__51_31}" __AMBER_ARRAY_116[@];
            __AF_eprintf858_v0__51_23="$__AF_eprintf858_v0";
            echo "$__AF_eprintf858_v0__51_23" > /dev/null 2>&1
elif [ "${checked[${global_idx}]}" != 0 ]; then
                            print_blank__864_v0 ${cursor_len};
                __AF_print_blank864_v0__53_17="$__AF_print_blank864_v0";
                echo "$__AF_print_blank864_v0__53_17" > /dev/null 2>&1
                colored_secondary__841_v0 "${check_mark}""${truncated_option}""
";
                __AF_colored_secondary841_v0__54_25="${__AF_colored_secondary841_v0}";
                __AMBER_ARRAY_117=("");
                eprintf__858_v0 "${__AF_colored_secondary841_v0__54_25}" __AMBER_ARRAY_117[@];
                __AF_eprintf858_v0__54_17="$__AF_eprintf858_v0";
                echo "$__AF_eprintf858_v0__54_17" > /dev/null 2>&1
else
                            print_blank__864_v0 ${cursor_len};
                __AF_print_blank864_v0__57_17="$__AF_print_blank864_v0";
                echo "$__AF_print_blank864_v0__57_17" > /dev/null 2>&1
                __AMBER_ARRAY_118=("");
                eprintf__858_v0 "${check_mark}""${truncated_option}""
" __AMBER_ARRAY_118[@];
                __AF_eprintf858_v0__58_17="$__AF_eprintf858_v0";
                echo "$__AF_eprintf858_v0__58_17" > /dev/null 2>&1
fi
done
    local remaining_slots=$(echo ${display_count} '-' "${#page_options[@]}" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
    if [ $(echo ${remaining_slots} '>' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        # Amber bug guard
        for _ in $(seq 0 $(echo ${remaining_slots} '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')); do
            __AMBER_ARRAY_119=("");
            eprintf__858_v0 "\x1b[K
" __AMBER_ARRAY_119[@];
            __AF_eprintf858_v0__65_13="$__AF_eprintf858_v0";
            echo "$__AF_eprintf858_v0__65_13" > /dev/null 2>&1
done
fi
}
render_page_indicator__933_v0() {
    local page=$1
    local total_pages=$2
    if [ $(echo ${total_pages} '>' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        __AMBER_ARRAY_120=("");
        eprintf__858_v0 "\x1b[9999D\x1b[K" __AMBER_ARRAY_120[@];
        __AF_eprintf858_v0__72_9="$__AF_eprintf858_v0";
        echo "$__AF_eprintf858_v0__72_9" > /dev/null 2>&1
        eprintf_colored__859_v0 "Page $(echo ${page} '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')/${total_pages}" 90;
        __AF_eprintf_colored859_v0__73_9="$__AF_eprintf_colored859_v0";
        echo "$__AF_eprintf_colored859_v0__73_9" > /dev/null 2>&1
        __AMBER_ARRAY_121=("");
        eprintf__858_v0 "\x1b[9999D" __AMBER_ARRAY_121[@];
        __AF_eprintf858_v0__74_9="$__AF_eprintf858_v0";
        echo "$__AF_eprintf858_v0__74_9" > /dev/null 2>&1
fi
}
xyl_choose__934_v0() {
    local options=("${!1}")
    local cursor=$2
    local header=$3
    local page_size=$4
    if [ $(echo "${#options[@]}" '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        eprintf_colored__859_v0 "ERROR: No options provided.
" 31;
        __AF_eprintf_colored859_v0__92_9="$__AF_eprintf_colored859_v0";
        echo "$__AF_eprintf_colored859_v0__92_9" > /dev/null 2>&1
        exit 1
fi
    stty_lock__820_v0 ;
    __AF_stty_lock820_v0__96_5="$__AF_stty_lock820_v0";
    echo "$__AF_stty_lock820_v0__96_5" > /dev/null 2>&1
    hide_cursor__869_v0 ;
    __AF_hide_cursor869_v0__97_5="$__AF_hide_cursor869_v0";
    echo "$__AF_hide_cursor869_v0__97_5" > /dev/null 2>&1
    term_width__824_v0 ;
    __AF_term_width824_v0__99_22="$__AF_term_width824_v0";
    local term_width="$__AF_term_width824_v0__99_22"
    term_height__825_v0 ;
    __AF_term_height825_v0__100_23="$__AF_term_height825_v0";
    local term_height="$__AF_term_height825_v0__100_23"
    local max_page_size=$(echo ${term_height} '-' $(if [ $([ "_${header}" != "_" ]; echo $?) != 0 ]; then echo 2; else echo 3; fi) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
    if [ $(echo ${page_size} '>' ${max_page_size} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        page_size=${max_page_size}
fi
    if [ $([ "_${header}" == "_" ]; echo $?) != 0 ]; then
        cutoff_text__878_v0 "${header}" ${term_width};
        __AF_cutoff_text878_v0__107_17="${__AF_cutoff_text878_v0}";
        __AMBER_ARRAY_122=("");
        eprintf__858_v0 "${__AF_cutoff_text878_v0__107_17}""
" __AMBER_ARRAY_122[@];
        __AF_eprintf858_v0__107_9="$__AF_eprintf858_v0";
        echo "$__AF_eprintf858_v0__107_9" > /dev/null 2>&1
fi
    math_floor__406_v0 $(echo $(echo $(echo "${#options[@]}" '+' ${page_size} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '/' ${page_size} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
    __AF_math_floor406_v0__110_23="$__AF_math_floor406_v0";
    local total_pages="$__AF_math_floor406_v0__110_23"
    local current_page=0
    local selected=0
    local display_count=${page_size}
    if [ $(echo "${#options[@]}" '<' ${page_size} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        display_count="${#options[@]}"
fi
    new_line__865_v0 ${display_count};
    __AF_new_line865_v0__119_5="$__AF_new_line865_v0";
    echo "$__AF_new_line865_v0__119_5" > /dev/null 2>&1
    __AMBER_ARRAY_123=("");
    eprintf__858_v0 "\x1b[9999D" __AMBER_ARRAY_123[@];
    __AF_eprintf858_v0__120_5="$__AF_eprintf858_v0";
    echo "$__AF_eprintf858_v0__120_5" > /dev/null 2>&1
    if [ $(echo ${total_pages} '>' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        eprintf_colored__859_v0 "Page $(echo ${current_page} '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')/${total_pages}" 90;
        __AF_eprintf_colored859_v0__122_9="$__AF_eprintf_colored859_v0";
        echo "$__AF_eprintf_colored859_v0__122_9" > /dev/null 2>&1
fi
    new_line__865_v0 1;
    __AF_new_line865_v0__124_5="$__AF_new_line865_v0";
    echo "$__AF_new_line865_v0__124_5" > /dev/null 2>&1
    # "↑↓ select • enter confirm" = 9 + 3 + 13 = 25
    # "↑↓ select • ←→ page • enter confirm" = 9 + 3 + 8 + 3 + 13 = 36
    if [ $(echo ${total_pages} '>' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        __AMBER_ARRAY_124=("↑↓" "select" "←→" "page" "enter" "confirm");
        render_tooltip__879_v0 __AMBER_ARRAY_124[@] 36 ${term_width};
        __AF_render_tooltip879_v0__129_9="$__AF_render_tooltip879_v0";
        echo "$__AF_render_tooltip879_v0__129_9" > /dev/null 2>&1
else
        __AMBER_ARRAY_125=("↑↓" "select" "enter" "confirm");
        render_tooltip__879_v0 __AMBER_ARRAY_125[@] 25 ${term_width};
        __AF_render_tooltip879_v0__131_9="$__AF_render_tooltip879_v0";
        echo "$__AF_render_tooltip879_v0__131_9" > /dev/null 2>&1
fi
    go_up__866_v0 $(echo ${display_count} '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
    __AF_go_up866_v0__133_5="$__AF_go_up866_v0";
    echo "$__AF_go_up866_v0__133_5" > /dev/null 2>&1
    __AMBER_ARRAY_126=("");
    eprintf__858_v0 "\x1b[9999D" __AMBER_ARRAY_126[@];
    __AF_eprintf858_v0__134_5="$__AF_eprintf858_v0";
    echo "$__AF_eprintf858_v0__134_5" > /dev/null 2>&1
    get_page_options__929_v0 options[@] ${current_page} ${page_size};
    __AF_get_page_options929_v0__136_24=("${__AF_get_page_options929_v0[@]}");
    local page_options=("${__AF_get_page_options929_v0__136_24[@]}")
    render_choose_page__931_v0 page_options[@] ${selected} "${cursor}" ${display_count} ${term_width};
    __AF_render_choose_page931_v0__137_5="$__AF_render_choose_page931_v0";
    echo "$__AF_render_choose_page931_v0__137_5" > /dev/null 2>&1
    while :
do
        get_key__856_v0 ;
        __AF_get_key856_v0__140_19="${__AF_get_key856_v0}";
        local key="${__AF_get_key856_v0__140_19}"
        local prev_selected=${selected}
        local prev_page=${current_page}
        local up_paged=0
        if [ $(echo $([ "_${key}" != "_UP" ]; echo $?) '||' $([ "_${key}" != "_k" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            if [ $(echo $(echo ${selected} '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '&&' $(echo ${total_pages} '>' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                if [ $(echo ${current_page} '>' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                    current_page=$(echo ${current_page} '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
else
                    current_page=$(echo ${total_pages} '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
fi
                up_paged=1
elif [ $(echo ${selected} '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                selected=$(echo "${#page_options[@]}" '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
else
                selected=$(echo ${selected} '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
fi
elif [ $(echo $([ "_${key}" != "_DOWN" ]; echo $?) '||' $([ "_${key}" != "_j" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            if [ $(echo ${selected} '==' $(echo "${#page_options[@]}" '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                if [ $(echo ${current_page} '<' $(echo ${total_pages} '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                    current_page=$(echo ${current_page} '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
                    selected=0
else
                    current_page=0
                    selected=0
fi
else
                selected=$(echo ${selected} '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
fi
elif [ $(echo $([ "_${key}" != "_LEFT" ]; echo $?) '||' $([ "_${key}" != "_h" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            if [ $(echo ${current_page} '>' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                current_page=$(echo ${current_page} '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
                selected=0
else
                selected=0
fi
elif [ $(echo $([ "_${key}" != "_RIGHT" ]; echo $?) '||' $([ "_${key}" != "_l" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            if [ $(echo ${current_page} '<' $(echo ${total_pages} '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                current_page=$(echo ${current_page} '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
                selected=0
else
                selected=$(echo "${#page_options[@]}" '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
fi
elif [ $([ "_${key}" != "_INPUT" ]; echo $?) != 0 ]; then
            break
else
            continue
fi
        __AMBER_LEN="${cursor}";
        local max_option_width=$(echo $(echo ${term_width} '-' "${#__AMBER_LEN}" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
        if [ $(echo ${prev_page} '!=' ${current_page} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            get_page_options__929_v0 options[@] ${current_page} ${page_size};
            __AF_get_page_options929_v0__203_32=("${__AF_get_page_options929_v0[@]}");
            page_options=("${__AF_get_page_options929_v0__203_32[@]}")
            if [ ${up_paged} != 0 ]; then
                selected=$(echo "${#page_options[@]}" '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
fi
            go_up__866_v0 1;
            __AF_go_up866_v0__207_17="$__AF_go_up866_v0";
            echo "$__AF_go_up866_v0__207_17" > /dev/null 2>&1
            remove_line__862_v0 $(echo ${display_count} '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
            __AF_remove_line862_v0__208_17="$__AF_remove_line862_v0";
            echo "$__AF_remove_line862_v0__208_17" > /dev/null 2>&1
            remove_current_line__863_v0 ;
            __AF_remove_current_line863_v0__209_17="$__AF_remove_current_line863_v0";
            echo "$__AF_remove_current_line863_v0__209_17" > /dev/null 2>&1
            __AMBER_ARRAY_127=("");
            eprintf__858_v0 "\x1b[9999D" __AMBER_ARRAY_127[@];
            __AF_eprintf858_v0__210_17="$__AF_eprintf858_v0";
            echo "$__AF_eprintf858_v0__210_17" > /dev/null 2>&1
            render_choose_page__931_v0 page_options[@] ${selected} "${cursor}" ${display_count} ${term_width};
            __AF_render_choose_page931_v0__211_17="$__AF_render_choose_page931_v0";
            echo "$__AF_render_choose_page931_v0__211_17" > /dev/null 2>&1
            render_page_indicator__933_v0 ${current_page} ${total_pages};
            __AF_render_page_indicator933_v0__212_17="$__AF_render_page_indicator933_v0";
            echo "$__AF_render_page_indicator933_v0__212_17" > /dev/null 2>&1
elif [ $(echo ${prev_selected} '!=' ${selected} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            go_up__866_v0 $(echo ${display_count} '-' ${prev_selected} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
            __AF_go_up866_v0__215_17="$__AF_go_up866_v0";
            echo "$__AF_go_up866_v0__215_17" > /dev/null 2>&1
            __AMBER_ARRAY_128=("");
            eprintf__858_v0 "\x1b[K" __AMBER_ARRAY_128[@];
            __AF_eprintf858_v0__216_17="$__AF_eprintf858_v0";
            echo "$__AF_eprintf858_v0__216_17" > /dev/null 2>&1
            __AMBER_LEN="${cursor}";
            print_blank__864_v0 "${#__AMBER_LEN}";
            __AF_print_blank864_v0__217_17="$__AF_print_blank864_v0";
            echo "$__AF_print_blank864_v0__217_17" > /dev/null 2>&1
            cutoff_text__878_v0 "${page_options[${prev_selected}]}" ${max_option_width};
            __AF_cutoff_text878_v0__218_25="${__AF_cutoff_text878_v0}";
            __AMBER_ARRAY_129=("");
            eprintf__858_v0 "${__AF_cutoff_text878_v0__218_25}" __AMBER_ARRAY_129[@];
            __AF_eprintf858_v0__218_17="$__AF_eprintf858_v0";
            echo "$__AF_eprintf858_v0__218_17" > /dev/null 2>&1
            local diff=$(echo ${selected} '-' ${prev_selected} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
            go_up_or_down__868_v0 ${diff};
            __AF_go_up_or_down868_v0__221_17="$__AF_go_up_or_down868_v0";
            echo "$__AF_go_up_or_down868_v0__221_17" > /dev/null 2>&1
            __AMBER_ARRAY_130=("");
            eprintf__858_v0 "\x1b[9999D" __AMBER_ARRAY_130[@];
            __AF_eprintf858_v0__222_17="$__AF_eprintf858_v0";
            echo "$__AF_eprintf858_v0__222_17" > /dev/null 2>&1
            __AMBER_ARRAY_131=("");
            eprintf__858_v0 "\x1b[K" __AMBER_ARRAY_131[@];
            __AF_eprintf858_v0__223_17="$__AF_eprintf858_v0";
            echo "$__AF_eprintf858_v0__223_17" > /dev/null 2>&1
            cutoff_text__878_v0 "${page_options[${selected}]}" ${max_option_width};
            __AF_cutoff_text878_v0__224_52="${__AF_cutoff_text878_v0}";
            colored_secondary__841_v0 "${cursor}""${__AF_cutoff_text878_v0__224_52}";
            __AF_colored_secondary841_v0__224_25="${__AF_colored_secondary841_v0}";
            __AMBER_ARRAY_132=("");
            eprintf__858_v0 "${__AF_colored_secondary841_v0__224_25}" __AMBER_ARRAY_132[@];
            __AF_eprintf858_v0__224_17="$__AF_eprintf858_v0";
            echo "$__AF_eprintf858_v0__224_17" > /dev/null 2>&1
            go_down__867_v0 $(echo ${display_count} '-' ${selected} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
            __AF_go_down867_v0__226_17="$__AF_go_down867_v0";
            echo "$__AF_go_down867_v0__226_17" > /dev/null 2>&1
            __AMBER_ARRAY_133=("");
            eprintf__858_v0 "\x1b[9999D" __AMBER_ARRAY_133[@];
            __AF_eprintf858_v0__227_17="$__AF_eprintf858_v0";
            echo "$__AF_eprintf858_v0__227_17" > /dev/null 2>&1
fi
done
    local total_lines=$(echo ${display_count} '+' 2 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
    if [ $([ "_${header}" == "_" ]; echo $?) != 0 ]; then
        total_lines=$(echo ${total_lines} '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
fi
    go_down__867_v0 1;
    __AF_go_down867_v0__237_5="$__AF_go_down867_v0";
    echo "$__AF_go_down867_v0__237_5" > /dev/null 2>&1
    remove_line__862_v0 $(echo ${total_lines} '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
    __AF_remove_line862_v0__238_5="$__AF_remove_line862_v0";
    echo "$__AF_remove_line862_v0__238_5" > /dev/null 2>&1
    remove_current_line__863_v0 ;
    __AF_remove_current_line863_v0__239_5="$__AF_remove_current_line863_v0";
    echo "$__AF_remove_current_line863_v0__239_5" > /dev/null 2>&1
    stty_unlock__821_v0 ;
    __AF_stty_unlock821_v0__241_5="$__AF_stty_unlock821_v0";
    echo "$__AF_stty_unlock821_v0__241_5" > /dev/null 2>&1
    show_cursor__870_v0 ;
    __AF_show_cursor870_v0__242_5="$__AF_show_cursor870_v0";
    echo "$__AF_show_cursor870_v0__242_5" > /dev/null 2>&1
    local global_selected=$(echo $(echo ${current_page} '*' ${page_size} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '+' ${selected} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
    __AF_xyl_choose934_v0="${options[${global_selected}]}";
    return 0
}
count_checked__935_v0() {
    local checked=("${!1}")
    local count=0
    for c in "${checked[@]}"; do
        if [ ${c} != 0 ]; then
            count=$(echo ${count} '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
fi
done
    __AF_count_checked935_v0=${count};
    return 0
}
xyl_multi_choose__936_v0() {
    local options=("${!1}")
    local cursor=$2
    local header=$3
    local limit=$4
    local page_size=$5
    if [ $(echo "${#options[@]}" '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        eprintf_colored__859_v0 "ERROR: No options provided.
" 31;
        __AF_eprintf_colored859_v0__273_9="$__AF_eprintf_colored859_v0";
        echo "$__AF_eprintf_colored859_v0__273_9" > /dev/null 2>&1
        __AMBER_ARRAY_134=();
        __AF_xyl_multi_choose936_v0=("${__AMBER_ARRAY_134[@]}");
        return 0
fi
    stty_lock__820_v0 ;
    __AF_stty_lock820_v0__277_5="$__AF_stty_lock820_v0";
    echo "$__AF_stty_lock820_v0__277_5" > /dev/null 2>&1
    hide_cursor__869_v0 ;
    __AF_hide_cursor869_v0__278_5="$__AF_hide_cursor869_v0";
    echo "$__AF_hide_cursor869_v0__278_5" > /dev/null 2>&1
    term_width__824_v0 ;
    __AF_term_width824_v0__280_22="$__AF_term_width824_v0";
    local term_width="$__AF_term_width824_v0__280_22"
    term_height__825_v0 ;
    __AF_term_height825_v0__281_23="$__AF_term_height825_v0";
    local term_height="$__AF_term_height825_v0__281_23"
    local max_page_size=$(echo ${term_height} '-' $(if [ $([ "_${header}" != "_" ]; echo $?) != 0 ]; then echo 2; else echo 3; fi) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
    if [ $(echo ${page_size} '>' ${max_page_size} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        page_size=${max_page_size}
fi
    if [ $([ "_${header}" == "_" ]; echo $?) != 0 ]; then
        cutoff_text__878_v0 "${header}" ${term_width};
        __AF_cutoff_text878_v0__288_17="${__AF_cutoff_text878_v0}";
        __AMBER_ARRAY_135=("");
        eprintf__858_v0 "${__AF_cutoff_text878_v0__288_17}""
" __AMBER_ARRAY_135[@];
        __AF_eprintf858_v0__288_9="$__AF_eprintf858_v0";
        echo "$__AF_eprintf858_v0__288_9" > /dev/null 2>&1
fi
    math_floor__406_v0 $(echo $(echo $(echo "${#options[@]}" '+' ${page_size} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '/' ${page_size} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
    __AF_math_floor406_v0__291_23="$__AF_math_floor406_v0";
    local total_pages="$__AF_math_floor406_v0__291_23"
    local current_page=0
    local selected=0
    local display_count=${page_size}
    if [ $(echo "${#options[@]}" '<' ${page_size} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        display_count="${#options[@]}"
fi
    new_line__865_v0 ${display_count};
    __AF_new_line865_v0__300_5="$__AF_new_line865_v0";
    echo "$__AF_new_line865_v0__300_5" > /dev/null 2>&1
    __AMBER_ARRAY_136=("");
    eprintf__858_v0 "\x1b[9999D" __AMBER_ARRAY_136[@];
    __AF_eprintf858_v0__301_5="$__AF_eprintf858_v0";
    echo "$__AF_eprintf858_v0__301_5" > /dev/null 2>&1
    if [ $(echo ${total_pages} '>' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        eprintf_colored__859_v0 "Page $(echo ${current_page} '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')/${total_pages}" 90;
        __AF_eprintf_colored859_v0__303_9="$__AF_eprintf_colored859_v0";
        echo "$__AF_eprintf_colored859_v0__303_9" > /dev/null 2>&1
fi
    new_line__865_v0 1;
    __AF_new_line865_v0__305_5="$__AF_new_line865_v0";
    echo "$__AF_new_line865_v0__305_5" > /dev/null 2>&1
    # "↑↓ select • x toggle • enter confirm" = 9 + 3 + 8 + 3 + 13 = 36
    # "↑↓ select • x toggle • a all • enter confirm" = 36 + 5 + 3 = 44
    # "↑↓ select • x toggle • ←→ page • enter confirm" = 36 + 8 + 3 = 47
    # "↑↓ select • x toggle • a all • ←→ page • enter confirm" = 36 + 5 + 3 + 8 + 3 = 55
    if [ $(echo $(echo ${total_pages} '>' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '&&' $(echo ${limit} '<' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        __AMBER_ARRAY_137=("↑↓" "select" "x" "toggle" "a" "all" "←→" "page" "enter" "confirm");
        render_tooltip__879_v0 __AMBER_ARRAY_137[@] 55 ${term_width};
        __AF_render_tooltip879_v0__312_40="$__AF_render_tooltip879_v0";
        echo "$__AF_render_tooltip879_v0__312_40" > /dev/null 2>&1
elif [ $(echo ${total_pages} '>' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        __AMBER_ARRAY_138=("↑↓" "select" "x" "toggle" "←→" "page" "enter" "confirm");
        render_tooltip__879_v0 __AMBER_ARRAY_138[@] 47 ${term_width};
        __AF_render_tooltip879_v0__313_26="$__AF_render_tooltip879_v0";
        echo "$__AF_render_tooltip879_v0__313_26" > /dev/null 2>&1
elif [ $(echo ${limit} '<' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        __AMBER_ARRAY_139=("↑↓" "select" "x" "toggle" "a" "all" "enter" "confirm");
        render_tooltip__879_v0 __AMBER_ARRAY_139[@] 44 ${term_width};
        __AF_render_tooltip879_v0__314_20="$__AF_render_tooltip879_v0";
        echo "$__AF_render_tooltip879_v0__314_20" > /dev/null 2>&1
else
        __AMBER_ARRAY_140=("↑↓" "select" "x" "toggle" "enter" "confirm");
        render_tooltip__879_v0 __AMBER_ARRAY_140[@] 36 ${term_width};
        __AF_render_tooltip879_v0__315_15="$__AF_render_tooltip879_v0";
        echo "$__AF_render_tooltip879_v0__315_15" > /dev/null 2>&1
fi
    go_up__866_v0 $(echo ${display_count} '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
    __AF_go_up866_v0__317_5="$__AF_go_up866_v0";
    echo "$__AF_go_up866_v0__317_5" > /dev/null 2>&1
    __AMBER_ARRAY_141=("");
    eprintf__858_v0 "\x1b[9999D" __AMBER_ARRAY_141[@];
    __AF_eprintf858_v0__318_5="$__AF_eprintf858_v0";
    echo "$__AF_eprintf858_v0__318_5" > /dev/null 2>&1
    __AMBER_ARRAY_142=();
    local checked=("${__AMBER_ARRAY_142[@]}")
    for _ in $(seq 0 $(echo "${#options[@]}" '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')); do
        __AMBER_ARRAY_143=(0);
        checked+=("${__AMBER_ARRAY_143[@]}")
done
    get_page_options__929_v0 options[@] ${current_page} ${page_size};
    __AF_get_page_options929_v0__325_24=("${__AF_get_page_options929_v0[@]}");
    local page_options=("${__AF_get_page_options929_v0__325_24[@]}")
    get_page_start__930_v0 ${current_page} ${page_size};
    __AF_get_page_start930_v0__326_22="$__AF_get_page_start930_v0";
    local page_start="$__AF_get_page_start930_v0__326_22"
    render_multi_choose_page__932_v0 page_options[@] checked[@] ${page_start} ${selected} "${cursor}" ${display_count} ${term_width};
    __AF_render_multi_choose_page932_v0__327_5="$__AF_render_multi_choose_page932_v0";
    echo "$__AF_render_multi_choose_page932_v0__327_5" > /dev/null 2>&1
    while :
do
        get_key__856_v0 ;
        __AF_get_key856_v0__330_19="${__AF_get_key856_v0}";
        local key="${__AF_get_key856_v0__330_19}"
        local prev_selected=${selected}
        local prev_page=${current_page}
        local global_selected=$(echo ${page_start} '+' ${selected} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
        local up_paged=0
        if [ $(echo $([ "_${key}" != "_UP" ]; echo $?) '||' $([ "_${key}" != "_k" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            if [ $(echo $(echo ${selected} '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '&&' $(echo ${total_pages} '>' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                if [ $(echo ${current_page} '>' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                    current_page=$(echo ${current_page} '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
else
                    current_page=$(echo ${total_pages} '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
fi
                up_paged=1
elif [ $(echo ${selected} '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                selected=$(echo "${#page_options[@]}" '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
else
                selected=$(echo ${selected} '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
fi
elif [ $(echo $([ "_${key}" != "_DOWN" ]; echo $?) '||' $([ "_${key}" != "_j" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            if [ $(echo ${selected} '==' $(echo "${#page_options[@]}" '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                if [ $(echo ${current_page} '<' $(echo ${total_pages} '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                    current_page=$(echo ${current_page} '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
                    selected=0
else
                    current_page=0
                    selected=0
fi
else
                selected=$(echo ${selected} '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
fi
elif [ $(echo $([ "_${key}" != "_LEFT" ]; echo $?) '||' $([ "_${key}" != "_h" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            if [ $(echo ${current_page} '>' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                current_page=$(echo ${current_page} '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
                selected=0
else
                selected=0
fi
elif [ $(echo $([ "_${key}" != "_RIGHT" ]; echo $?) '||' $([ "_${key}" != "_l" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            if [ $(echo ${current_page} '<' $(echo ${total_pages} '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                current_page=$(echo ${current_page} '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
                selected=0
else
                selected=$(echo "${#page_options[@]}" '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
fi
elif [ $(echo $([ "_${key}" != "_x" ]; echo $?) '||' $([ "_${key}" != "_X" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            count_checked__935_v0 checked[@];
            __AF_count_checked935_v0__390_34="$__AF_count_checked935_v0";
            if [ "${checked[${global_selected}]}" != 0 ]; then
                checked[${global_selected}]=0
elif [ $(echo $(echo ${limit} '<' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '||' $(echo "$__AF_count_checked935_v0__390_34" '<' ${limit} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                checked[${global_selected}]=1
else
                continue
fi
            __AMBER_LEN="${cursor}";
            local max_option_width=$(echo $(echo $(echo ${term_width} '-' "${#__AMBER_LEN}" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '-' 2 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
            # 2 for check mark
            go_up__866_v0 $(echo ${display_count} '-' ${selected} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
            __AF_go_up866_v0__396_17="$__AF_go_up866_v0";
            echo "$__AF_go_up866_v0__396_17" > /dev/null 2>&1
            __AMBER_ARRAY_144=("");
            eprintf__858_v0 "\x1b[9999D" __AMBER_ARRAY_144[@];
            __AF_eprintf858_v0__397_17="$__AF_eprintf858_v0";
            echo "$__AF_eprintf858_v0__397_17" > /dev/null 2>&1
            __AMBER_ARRAY_145=("");
            eprintf__858_v0 "\x1b[K" __AMBER_ARRAY_145[@];
            __AF_eprintf858_v0__398_17="$__AF_eprintf858_v0";
            echo "$__AF_eprintf858_v0__398_17" > /dev/null 2>&1
            local check_mark=$(if [ "${checked[${global_selected}]}" != 0 ]; then echo "✓ "; else echo "• "; fi)
            cutoff_text__878_v0 "${page_options[${selected}]}" ${max_option_width};
            __AF_cutoff_text878_v0__400_65="${__AF_cutoff_text878_v0}";
            colored_secondary__841_v0 "${cursor}""${check_mark}""${__AF_cutoff_text878_v0__400_65}";
            __AF_colored_secondary841_v0__400_25="${__AF_colored_secondary841_v0}";
            __AMBER_ARRAY_146=("");
            eprintf__858_v0 "${__AF_colored_secondary841_v0__400_25}" __AMBER_ARRAY_146[@];
            __AF_eprintf858_v0__400_17="$__AF_eprintf858_v0";
            echo "$__AF_eprintf858_v0__400_17" > /dev/null 2>&1
            go_down__867_v0 $(echo ${display_count} '-' ${selected} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
            __AF_go_down867_v0__401_17="$__AF_go_down867_v0";
            echo "$__AF_go_down867_v0__401_17" > /dev/null 2>&1
            __AMBER_ARRAY_147=("");
            eprintf__858_v0 "\x1b[9999D" __AMBER_ARRAY_147[@];
            __AF_eprintf858_v0__402_17="$__AF_eprintf858_v0";
            echo "$__AF_eprintf858_v0__402_17" > /dev/null 2>&1
            continue
elif [ $(echo $(echo $([ "_${key}" != "_a" ]; echo $?) '||' $([ "_${key}" != "_A" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '&&' $(echo ${limit} '<' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            count_checked__935_v0 checked[@];
            __AF_count_checked935_v0__406_35="$__AF_count_checked935_v0";
            local all_checked=$(echo "$__AF_count_checked935_v0__406_35" '==' "${#options[@]}" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
            for i in $(seq 0 $(echo "${#checked[@]}" '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')); do
                checked[${i}]=$(echo  '!' ${all_checked} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
done
            go_up__866_v0 ${display_count};
            __AF_go_up866_v0__410_17="$__AF_go_up866_v0";
            echo "$__AF_go_up866_v0__410_17" > /dev/null 2>&1
            __AMBER_ARRAY_148=("");
            eprintf__858_v0 "\x1b[9999D" __AMBER_ARRAY_148[@];
            __AF_eprintf858_v0__411_17="$__AF_eprintf858_v0";
            echo "$__AF_eprintf858_v0__411_17" > /dev/null 2>&1
            render_multi_choose_page__932_v0 page_options[@] checked[@] ${page_start} ${selected} "${cursor}" ${display_count} ${term_width};
            __AF_render_multi_choose_page932_v0__412_17="$__AF_render_multi_choose_page932_v0";
            echo "$__AF_render_multi_choose_page932_v0__412_17" > /dev/null 2>&1
            continue
elif [ $([ "_${key}" != "_INPUT" ]; echo $?) != 0 ]; then
            break
else
            continue
fi
        __AMBER_LEN="${cursor}";
        local max_option_width=$(echo $(echo $(echo ${term_width} '-' "${#__AMBER_LEN}" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '-' 2 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
        # 2 for check mark
        if [ $(echo ${prev_page} '!=' ${current_page} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            get_page_options__929_v0 options[@] ${current_page} ${page_size};
            __AF_get_page_options929_v0__424_32=("${__AF_get_page_options929_v0[@]}");
            page_options=("${__AF_get_page_options929_v0__424_32[@]}")
            get_page_start__930_v0 ${current_page} ${page_size};
            __AF_get_page_start930_v0__425_30="$__AF_get_page_start930_v0";
            page_start="$__AF_get_page_start930_v0__425_30"
            if [ ${up_paged} != 0 ]; then
                selected=$(echo "${#page_options[@]}" '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
fi
            go_up__866_v0 1;
            __AF_go_up866_v0__429_17="$__AF_go_up866_v0";
            echo "$__AF_go_up866_v0__429_17" > /dev/null 2>&1
            remove_line__862_v0 $(echo ${display_count} '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
            __AF_remove_line862_v0__430_17="$__AF_remove_line862_v0";
            echo "$__AF_remove_line862_v0__430_17" > /dev/null 2>&1
            remove_current_line__863_v0 ;
            __AF_remove_current_line863_v0__431_17="$__AF_remove_current_line863_v0";
            echo "$__AF_remove_current_line863_v0__431_17" > /dev/null 2>&1
            __AMBER_ARRAY_149=("");
            eprintf__858_v0 "\x1b[9999D" __AMBER_ARRAY_149[@];
            __AF_eprintf858_v0__432_17="$__AF_eprintf858_v0";
            echo "$__AF_eprintf858_v0__432_17" > /dev/null 2>&1
            render_multi_choose_page__932_v0 page_options[@] checked[@] ${page_start} ${selected} "${cursor}" ${display_count} ${term_width};
            __AF_render_multi_choose_page932_v0__433_17="$__AF_render_multi_choose_page932_v0";
            echo "$__AF_render_multi_choose_page932_v0__433_17" > /dev/null 2>&1
            render_page_indicator__933_v0 ${current_page} ${total_pages};
            __AF_render_page_indicator933_v0__434_17="$__AF_render_page_indicator933_v0";
            echo "$__AF_render_page_indicator933_v0__434_17" > /dev/null 2>&1
elif [ $(echo ${prev_selected} '!=' ${selected} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            local prev_global=$(echo ${page_start} '+' ${prev_selected} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
            go_up__866_v0 $(echo ${display_count} '-' ${prev_selected} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
            __AF_go_up866_v0__438_17="$__AF_go_up866_v0";
            echo "$__AF_go_up866_v0__438_17" > /dev/null 2>&1
            __AMBER_ARRAY_150=("");
            eprintf__858_v0 "\x1b[K" __AMBER_ARRAY_150[@];
            __AF_eprintf858_v0__439_17="$__AF_eprintf858_v0";
            echo "$__AF_eprintf858_v0__439_17" > /dev/null 2>&1
            __AMBER_LEN="${cursor}";
            print_blank__864_v0 "${#__AMBER_LEN}";
            __AF_print_blank864_v0__440_17="$__AF_print_blank864_v0";
            echo "$__AF_print_blank864_v0__440_17" > /dev/null 2>&1
            if [ "${checked[${prev_global}]}" != 0 ]; then
                cutoff_text__878_v0 "${page_options[${prev_selected}]}" ${max_option_width};
                __AF_cutoff_text878_v0__442_54="${__AF_cutoff_text878_v0}";
                colored_secondary__841_v0 "✓ ""${__AF_cutoff_text878_v0__442_54}";
                __AF_colored_secondary841_v0__442_29="${__AF_colored_secondary841_v0}";
                __AMBER_ARRAY_151=("");
                eprintf__858_v0 "${__AF_colored_secondary841_v0__442_29}" __AMBER_ARRAY_151[@];
                __AF_eprintf858_v0__442_21="$__AF_eprintf858_v0";
                echo "$__AF_eprintf858_v0__442_21" > /dev/null 2>&1
else
                cutoff_text__878_v0 "${page_options[${prev_selected}]}" ${max_option_width};
                __AF_cutoff_text878_v0__444_36="${__AF_cutoff_text878_v0}";
                __AMBER_ARRAY_152=("");
                eprintf__858_v0 "• ""${__AF_cutoff_text878_v0__444_36}" __AMBER_ARRAY_152[@];
                __AF_eprintf858_v0__444_21="$__AF_eprintf858_v0";
                echo "$__AF_eprintf858_v0__444_21" > /dev/null 2>&1
fi
            local diff=$(echo ${selected} '-' ${prev_selected} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
            go_up_or_down__868_v0 ${diff};
            __AF_go_up_or_down868_v0__448_17="$__AF_go_up_or_down868_v0";
            echo "$__AF_go_up_or_down868_v0__448_17" > /dev/null 2>&1
            __AMBER_ARRAY_153=("");
            eprintf__858_v0 "\x1b[9999D" __AMBER_ARRAY_153[@];
            __AF_eprintf858_v0__449_17="$__AF_eprintf858_v0";
            echo "$__AF_eprintf858_v0__449_17" > /dev/null 2>&1
            __AMBER_ARRAY_154=("");
            eprintf__858_v0 "\x1b[K" __AMBER_ARRAY_154[@];
            __AF_eprintf858_v0__450_17="$__AF_eprintf858_v0";
            echo "$__AF_eprintf858_v0__450_17" > /dev/null 2>&1
            local new_global=$(echo ${page_start} '+' ${selected} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
            local check_mark=$(if [ "${checked[${new_global}]}" != 0 ]; then echo "✓ "; else echo "• "; fi)
            cutoff_text__878_v0 "${page_options[${selected}]}" ${max_option_width};
            __AF_cutoff_text878_v0__453_65="${__AF_cutoff_text878_v0}";
            colored_secondary__841_v0 "${cursor}""${check_mark}""${__AF_cutoff_text878_v0__453_65}";
            __AF_colored_secondary841_v0__453_25="${__AF_colored_secondary841_v0}";
            __AMBER_ARRAY_155=("");
            eprintf__858_v0 "${__AF_colored_secondary841_v0__453_25}" __AMBER_ARRAY_155[@];
            __AF_eprintf858_v0__453_17="$__AF_eprintf858_v0";
            echo "$__AF_eprintf858_v0__453_17" > /dev/null 2>&1
            go_down__867_v0 $(echo ${display_count} '-' ${selected} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
            __AF_go_down867_v0__455_17="$__AF_go_down867_v0";
            echo "$__AF_go_down867_v0__455_17" > /dev/null 2>&1
            __AMBER_ARRAY_156=("");
            eprintf__858_v0 "\x1b[9999D" __AMBER_ARRAY_156[@];
            __AF_eprintf858_v0__456_17="$__AF_eprintf858_v0";
            echo "$__AF_eprintf858_v0__456_17" > /dev/null 2>&1
fi
done
    local total_lines=$(echo ${display_count} '+' 2 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
    if [ $([ "_${header}" == "_" ]; echo $?) != 0 ]; then
        total_lines=$(echo ${total_lines} '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
fi
    go_down__867_v0 1;
    __AF_go_down867_v0__466_5="$__AF_go_down867_v0";
    echo "$__AF_go_down867_v0__466_5" > /dev/null 2>&1
    remove_line__862_v0 $(echo ${total_lines} '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
    __AF_remove_line862_v0__467_5="$__AF_remove_line862_v0";
    echo "$__AF_remove_line862_v0__467_5" > /dev/null 2>&1
    remove_current_line__863_v0 ;
    __AF_remove_current_line863_v0__468_5="$__AF_remove_current_line863_v0";
    echo "$__AF_remove_current_line863_v0__468_5" > /dev/null 2>&1
    __AMBER_ARRAY_157=();
    local result=("${__AMBER_ARRAY_157[@]}")
    for i in $(seq 0 $(echo "${#options[@]}" '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')); do
        if [ "${checked[${i}]}" != 0 ]; then
            __AMBER_ARRAY_158=("${options[${i}]}");
            result+=("${__AMBER_ARRAY_158[@]}")
fi
done
    stty_unlock__821_v0 ;
    __AF_stty_unlock821_v0__477_5="$__AF_stty_unlock821_v0";
    echo "$__AF_stty_unlock821_v0__477_5" > /dev/null 2>&1
    show_cursor__870_v0 ;
    __AF_show_cursor870_v0__478_5="$__AF_show_cursor870_v0";
    echo "$__AF_show_cursor870_v0__478_5" > /dev/null 2>&1
    __AF_xyl_multi_choose936_v0=("${result[@]}");
    return 0
}
print_choose_help__1013_v0() {
    echo "Usage: ./xylitol.sh choose [<options> ...] [flags]"
    echo ""
    colored_primary__840_v0 "choose";
    __AF_colored_primary840_v0__7_12="${__AF_colored_primary840_v0}";
    __AMBER_ARRAY_159=("");
    printf__99_v0 "${__AF_colored_primary840_v0__7_12}" __AMBER_ARRAY_159[@];
    __AF_printf99_v0__7_5="$__AF_printf99_v0";
    echo "$__AF_printf99_v0__7_5" > /dev/null 2>&1
    __AMBER_ARRAY_160=("");
    printf__99_v0 " - Choose from a list of options." __AMBER_ARRAY_160[@];
    __AF_printf99_v0__8_5="$__AF_printf99_v0";
    echo "$__AF_printf99_v0__8_5" > /dev/null 2>&1
    echo ""
    echo ""
    colored_secondary__841_v0 "Arguments: ";
    __AF_colored_secondary841_v0__11_12="${__AF_colored_secondary841_v0}";
    __AMBER_ARRAY_161=("");
    printf__99_v0 "${__AF_colored_secondary841_v0__11_12}""
" __AMBER_ARRAY_161[@];
    __AF_printf99_v0__11_5="$__AF_printf99_v0";
    echo "$__AF_printf99_v0__11_5" > /dev/null 2>&1
    echo "  [<options> ...]        List of options to choose from"
    echo ""
    colored_secondary__841_v0 "Flags: ";
    __AF_colored_secondary841_v0__14_12="${__AF_colored_secondary841_v0}";
    __AMBER_ARRAY_162=("");
    printf__99_v0 "${__AF_colored_secondary841_v0__14_12}""
" __AMBER_ARRAY_162[@];
    __AF_printf99_v0__14_5="$__AF_printf99_v0";
    echo "$__AF_printf99_v0__14_5" > /dev/null 2>&1
    echo "  -h, --help             Show this help message"
    echo "  --limit=<number>       Enable multi-selection mode with a limit of selections"
    echo "  --no-limit             Enable multi-selection mode with no limit"
    echo "  --cursor=\"<text>\"      Set the cursor text (default: '> ')"
    echo "  --header=\"<text>\"      Set a header text to display above the options (ANSI escape supported)"
    echo "  --page-size=<number>   Set the number of options per page (default: 10)"
    echo ""
}
read_stdin_options__1064_v0() {
    __AMBER_ARRAY_163=();
    local options=("${__AMBER_ARRAY_163[@]}")
    __AMBER_VAL_164=$( [ -t 0 ] && echo "true" || echo "false" );
    __AS=$?;
    local is_tty="${__AMBER_VAL_164}"
    if [ $([ "_${is_tty}" != "_false" ]; echo $?) != 0 ]; then
         while IFS= read -r line || [[ -n "$line" ]]; do options+=("$line"); done ;
        __AS=$?
fi
    __AF_read_stdin_options1064_v0=("${options[@]}");
    return 0
}
execute_choose__1065_v0() {
    local parameters=("${!1}")
    local cursor="> "
    colored_primary__840_v0 "Choose: ";
    __AF_colored_primary840_v0__17_30="${__AF_colored_primary840_v0}";
    local header="\x1b[1m""${__AF_colored_primary840_v0__17_30}"
    read_stdin_options__1064_v0 ;
    __AF_read_stdin_options1064_v0__18_19=("${__AF_read_stdin_options1064_v0[@]}");
    local options=("${__AF_read_stdin_options1064_v0__18_19[@]}")
    local multi=0
    local limit=$(echo  '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
    local page_size=10
    for param in "${parameters[@]:2:9997}"; do
        match_regex__17_v0 "${param}" "^-h\$" 0;
        __AF_match_regex17_v0__25_13="$__AF_match_regex17_v0";
        match_regex__17_v0 "${param}" "^--help\$" 0;
        __AF_match_regex17_v0__25_43="$__AF_match_regex17_v0";
        match_regex__17_v0 "${param}" "^--cursor=.*\$" 0;
        __AF_match_regex17_v0__29_13="$__AF_match_regex17_v0";
        match_regex__17_v0 "${param}" "^--header=.*\$" 0;
        __AF_match_regex17_v0__33_13="$__AF_match_regex17_v0";
        match_regex__17_v0 "${param}" "^--limit=.*\$" 0;
        __AF_match_regex17_v0__37_13="$__AF_match_regex17_v0";
        match_regex__17_v0 "${param}" "^--no-limit\$" 0;
        __AF_match_regex17_v0__45_13="$__AF_match_regex17_v0";
        match_regex__17_v0 "${param}" "^--page-size=.*\$" 0;
        __AF_match_regex17_v0__48_13="$__AF_match_regex17_v0";
        if [ $(echo "$__AF_match_regex17_v0__25_13" '||' "$__AF_match_regex17_v0__25_43" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            print_choose_help__1013_v0 ;
            __AF_print_choose_help1013_v0__26_17="$__AF_print_choose_help1013_v0";
            echo "$__AF_print_choose_help1013_v0__26_17" > /dev/null 2>&1
            exit 0
elif [ "$__AF_match_regex17_v0__29_13" != 0 ]; then
            split__3_v0 "${param}" "=";
            __AF_split3_v0__30_30=("${__AF_split3_v0[@]}");
            local result=("${__AF_split3_v0__30_30[@]}")
            cursor="${result[1]}"
elif [ "$__AF_match_regex17_v0__33_13" != 0 ]; then
            split__3_v0 "${param}" "=";
            __AF_split3_v0__34_30=("${__AF_split3_v0[@]}");
            local result=("${__AF_split3_v0__34_30[@]}")
            header="${result[1]}"
elif [ "$__AF_match_regex17_v0__37_13" != 0 ]; then
            split__3_v0 "${param}" "=";
            __AF_split3_v0__38_30=("${__AF_split3_v0[@]}");
            local result=("${__AF_split3_v0__38_30[@]}")
            parse_number__12_v0 "${result[1]}";
            __AS=$?;
if [ $__AS != 0 ]; then
                eprintf_colored__859_v0 "ERROR: Invalid limit value: ""${result[1]}""
" 31;
                __AF_eprintf_colored859_v0__40_21="$__AF_eprintf_colored859_v0";
                echo "$__AF_eprintf_colored859_v0__40_21" > /dev/null 2>&1
                exit 1
fi;
            __AF_parse_number12_v0__39_25="$__AF_parse_number12_v0";
            limit="$__AF_parse_number12_v0__39_25"
            multi=1
elif [ "$__AF_match_regex17_v0__45_13" != 0 ]; then
            multi=1
elif [ "$__AF_match_regex17_v0__48_13" != 0 ]; then
            split__3_v0 "${param}" "=";
            __AF_split3_v0__49_30=("${__AF_split3_v0[@]}");
            local result=("${__AF_split3_v0__49_30[@]}")
            parse_number__12_v0 "${result[1]}";
            __AS=$?;
if [ $__AS != 0 ]; then
                eprintf_colored__859_v0 "ERROR: Invalid page-size value: ""${result[1]}""
" 31;
                __AF_eprintf_colored859_v0__51_21="$__AF_eprintf_colored859_v0";
                echo "$__AF_eprintf_colored859_v0__51_21" > /dev/null 2>&1
                exit 1
fi;
            __AF_parse_number12_v0__50_29="$__AF_parse_number12_v0";
            page_size="$__AF_parse_number12_v0__50_29"
else
            __AMBER_ARRAY_165=("${param}");
            options+=("${__AMBER_ARRAY_165[@]}")
fi
done
    has_ansi_escape__871_v0 "${header}";
    __AF_has_ansi_escape871_v0__61_42="$__AF_has_ansi_escape871_v0";
    escape_ansi__872_v0 "${header}";
    __AF_escape_ansi872_v0__61_71="${__AF_escape_ansi872_v0}";
    colored_primary__840_v0 "${header}";
    __AF_colored_primary840_v0__61_109="${__AF_colored_primary840_v0}";
    local display_header=$(if [ $(echo $([ "_${header}" != "_" ]; echo $?) '||' "$__AF_has_ansi_escape871_v0__61_42" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then echo "${__AF_escape_ansi872_v0__61_71}"; else echo "\\x1b[1m""${__AF_colored_primary840_v0__61_109}"; fi)
    if [ ${multi} != 0 ]; then
        xyl_multi_choose__936_v0 options[@] "${cursor}" "${display_header}" ${limit} ${page_size};
        __AF_xyl_multi_choose936_v0__64_23=("${__AF_xyl_multi_choose936_v0[@]}");
        local results=("${__AF_xyl_multi_choose936_v0__64_23[@]}")
        join__6_v0 results[@] "
";
        __AF_join6_v0__65_16="${__AF_join6_v0}";
        __AF_execute_choose1065_v0="${__AF_join6_v0__65_16}";
        return 0
fi
    xyl_choose__934_v0 options[@] "${cursor}" "${display_header}" ${page_size};
    __AF_xyl_choose934_v0__68_12="${__AF_xyl_choose934_v0}";
    __AF_execute_choose1065_v0="${__AF_xyl_choose934_v0__68_12}";
    return 0
}

# Perl Extensions Utilities
__AMBER_VAL_166=$( echo "$XYLITOL_USE_PERL" );
__AS=$?;
__27__perl_disabled=$([ "_${__AMBER_VAL_166}" != "_No" ]; echo $?)
__AMBER_VAL_167=$( command -v perl > /dev/null && echo 0 || echo 1 );
__AS=$?;
__28__perl_available=$(echo $(echo  '!' ${__27__perl_disabled} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '&&' $([ "_${__AMBER_VAL_167}" != "_0" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
perl_get_cjk_width__1192_v0() {
    local text=$1
    if [ $(echo  '!' ${__28__perl_available} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        __AF_perl_get_cjk_width1192_v0='';
        return 1
fi
    __AMBER_VAL_168=$( perl -CSDA -E '$w=0;$w+=/\p{EastAsianWidth=Wide}|\p{EastAsianWidth=Fullwidth}|\p{EastAsianWidth=Ambiguous}/?2:1 for split//,shift; say $w' "${text}" 2>/dev/null );
    __AS=$?;
if [ $__AS != 0 ]; then
__AF_perl_get_cjk_width1192_v0=''
return $__AS
fi;
    local width_str="${__AMBER_VAL_168}"
    parse_number__12_v0 "${width_str}";
    __AS=$?;
if [ $__AS != 0 ]; then
__AF_perl_get_cjk_width1192_v0=''
return $__AS
fi;
    __AF_parse_number12_v0__14_17="$__AF_parse_number12_v0";
    local width="$__AF_parse_number12_v0__14_17"
    __AF_perl_get_cjk_width1192_v0=${width};
    return 0
}
perl_truncate_cjk__1193_v0() {
    local text=$1
    local max_width=$2
    if [ $(echo  '!' ${__28__perl_available} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        __AF_perl_truncate_cjk1193_v0='';
        return 1
fi
    __AMBER_VAL_169=$( perl -CSDA -E '$t=shift;$m=shift;$w=0;$r="";$c=/\p{EastAsianWidth=Wide}|\p{EastAsianWidth=Fullwidth}|\p{EastAsianWidth=Ambiguous}/?2:1,($w+$c<=$m?($w+=$c,$r.=$_):last) for split//,$t; print $r' "${text}" ${max_width} 2>/dev/null );
    __AS=$?;
if [ $__AS != 0 ]; then
__AF_perl_truncate_cjk1193_v0=''
return $__AS
fi;
    local result="${__AMBER_VAL_169}"
    __AF_perl_truncate_cjk1193_v0="${result}";
    return 0
}
# global variables to store terminal size
# (prevent multiple queries in one session)
__29__got_term_size=0
__AMBER_ARRAY_170=(80 24);
__30__term_size=("${__AMBER_ARRAY_170[@]}")
# stty lock/unlock using environment variable for cross-module state
 export XYLITOL_RUNTIME_STTY_COUNT=0 ;
__AS=$?
stty_lock__1200_v0() {
    __AMBER_VAL_171=$( echo "${XYLITOL_RUNTIME_STTY_COUNT:-0}" );
    __AS=$?;
    local count="${__AMBER_VAL_171}"
    parse_number__12_v0 "${count}";
    __AS=$?;
if [ $__AS != 0 ]; then
        echo 0 > /dev/null 2>&1
fi;
    __AF_parse_number12_v0__14_21="$__AF_parse_number12_v0";
    local count_num="$__AF_parse_number12_v0__14_21"
    if [ $(echo ${count_num} '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
         stty -echo < /dev/tty ;
        __AS=$?
fi
    count_num=$(echo ${count_num} '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
     export XYLITOL_RUNTIME_STTY_COUNT=${count_num} ;
    __AS=$?
}
stty_unlock__1201_v0() {
    __AMBER_VAL_172=$( echo "${XYLITOL_RUNTIME_STTY_COUNT:-0}" );
    __AS=$?;
    local count="${__AMBER_VAL_172}"
    parse_number__12_v0 "${count}";
    __AS=$?;
if [ $__AS != 0 ]; then
        echo 0 > /dev/null 2>&1
fi;
    __AF_parse_number12_v0__25_21="$__AF_parse_number12_v0";
    local count_num="$__AF_parse_number12_v0__25_21"
    if [ $(echo ${count_num} '>' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        count_num=$(echo ${count_num} '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
         export XYLITOL_RUNTIME_STTY_COUNT=${count_num} ;
        __AS=$?
        if [ $(echo ${count_num} '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
             stty echo < /dev/tty ;
            __AS=$?
fi
fi
}
get_term_size__1202_v0() {
    # Query terminal size with \x1b[18t, response format: \x1b[8;rows;colst
    __AMBER_VAL_173=$( printf '\x1b[18t' > /dev/tty; IFS=';' read -rsd t _ignore height width < /dev/tty; echo "$height; $width" );
    __AS=$?;
    local result="${__AMBER_VAL_173}"
    split__3_v0 "${result}" ";";
    __AF_split3_v0__39_17=("${__AF_split3_v0[@]}");
    local parts=("${__AF_split3_v0__39_17[@]}")
    if [ $(echo "${#parts[@]}" '!=' 2 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        __AF_get_term_size1202_v0='';
        return 1
fi
    parse_number__12_v0 "${parts[0]}";
    __AS=$?;
if [ $__AS != 0 ]; then
__AF_get_term_size1202_v0=''
return $__AS
fi;
    __AF_parse_number12_v0__43_16="$__AF_parse_number12_v0";
    local rows="$__AF_parse_number12_v0__43_16"
    parse_number__12_v0 "${parts[1]}";
    __AS=$?;
if [ $__AS != 0 ]; then
__AF_get_term_size1202_v0=''
return $__AS
fi;
    __AF_parse_number12_v0__44_16="$__AF_parse_number12_v0";
    local cols="$__AF_parse_number12_v0__44_16"
    __AMBER_ARRAY_174=(${cols} ${rows});
    __30__term_size=("${__AMBER_ARRAY_174[@]}")
    __29__got_term_size=1
}
term_width__1204_v0() {
    if [ $(echo  '!' ${__29__got_term_size} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        get_term_size__1202_v0 ;
        __AS=$?;
        __AF_get_term_size1202_v0__60_15="$__AF_get_term_size1202_v0";
        echo "$__AF_get_term_size1202_v0__60_15" > /dev/null 2>&1
fi
    __AF_term_width1204_v0="${__30__term_size[0]}";
    return 0
}
# A global variable indicating if the terminal supports truecolor.
# "None" or "Yes" or "No"
# 
# This value is only updated by the `get_supports_truecolor` function
# executed by `colored_rgb` on its first call.
__31__supports_truecolor="None"
# A global variable indicating if the Xylitol colors have been loaded from environment variables.
__32__got_xylitol_colors=0
__AMBER_ARRAY_175=(3 207 159 92);
__33__primary_color=("${__AMBER_ARRAY_175[@]}")
__AMBER_ARRAY_176=(3 118 206 94);
__34__secondary_color=("${__AMBER_ARRAY_176[@]}")
__AMBER_ARRAY_177=(234 72 121 95);
__35__accent_color=("${__AMBER_ARRAY_177[@]}")
get_supports_truecolor__1215_v0() {
    env_const_get__89_v0 "XYLITOL_TRUECOLOR";
    __AS=$?;
if [ $__AS != 0 ]; then
        echo "" > /dev/null 2>&1
fi;
    __AF_env_const_get89_v0__20_18="${__AF_env_const_get89_v0}";
    local config="${__AF_env_const_get89_v0__20_18}"
    if [ $([ "_${config}" != "_No" ]; echo $?) != 0 ]; then
        __31__supports_truecolor="No"
        __AF_get_supports_truecolor1215_v0=0;
        return 0
fi
    env_const_get__89_v0 "COLORTERM";
    __AS=$?;
if [ $__AS != 0 ]; then
        __31__supports_truecolor="No"
        __AF_get_supports_truecolor1215_v0=0;
        return 0
fi;
    __AF_env_const_get89_v0__25_21="${__AF_env_const_get89_v0}";
    local colorterm="${__AF_env_const_get89_v0__25_21}"
    __31__supports_truecolor=$(if [ $(echo $([ "_${colorterm}" != "_truecolor" ]; echo $?) '||' $([ "_${colorterm}" != "_24bit" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then echo "Yes"; else echo "No"; fi)
    __AF_get_supports_truecolor1215_v0=$([ "_${__31__supports_truecolor}" != "_Yes" ]; echo $?);
    return 0
}
colored_rgb__1216_v0() {
    local message=$1
    local r=$2
    local g=$3
    local b=$4
    local fallback=$5
    if [ $([ "_${__31__supports_truecolor}" != "_Yes" ]; echo $?) != 0 ]; then
                    __AF_colored_rgb1216_v0="\x1b[38;2;${r};${g};${b}m""${message}""\x1b[0m";
            return 0
elif [ $([ "_${__31__supports_truecolor}" != "_None" ]; echo $?) != 0 ]; then
                    get_supports_truecolor__1215_v0 ;
            __AF_get_supports_truecolor1215_v0__50_17="$__AF_get_supports_truecolor1215_v0";
            if [ "$__AF_get_supports_truecolor1215_v0__50_17" != 0 ]; then
                                    __AF_colored_rgb1216_v0="\x1b[38;2;${r};${g};${b}m""${message}""\x1b[0m";
                    return 0
elif [ $(echo ${fallback} '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                __AF_colored_rgb1216_v0="${message}";
                return 0
else
                __AF_colored_rgb1216_v0="\x1b[${fallback}m""${message}""\x1b[0m";
                return 0
fi
else
        if [ $(echo ${fallback} '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            __AF_colored_rgb1216_v0="${message}";
            return 0
fi
        __AF_colored_rgb1216_v0="\x1b[${fallback}m""${message}""\x1b[0m";
        return 0
fi
}
background_rgb__1217_v0() {
    local message=$1
    local r=$2
    local g=$3
    local b=$4
    local fallback=$5
    # Convert foreground color code to background color code
    # 30-37 -> 40-47, 90-97 -> 100-107
    local bg_fallback=${fallback}
    if [ $(echo $(echo ${fallback} '>=' 30 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '&&' $(echo ${fallback} '<=' 37 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        bg_fallback=$(echo ${fallback} '+' 10 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
fi
    if [ $(echo $(echo ${fallback} '>=' 90 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '&&' $(echo ${fallback} '<=' 97 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        bg_fallback=$(echo ${fallback} '+' 10 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
fi
    if [ $([ "_${__31__supports_truecolor}" != "_Yes" ]; echo $?) != 0 ]; then
                    __AF_background_rgb1217_v0="\x1b[48;2;${r};${g};${b}m""${message}""\x1b[0m";
            return 0
elif [ $([ "_${__31__supports_truecolor}" != "_None" ]; echo $?) != 0 ]; then
                    get_supports_truecolor__1215_v0 ;
            __AF_get_supports_truecolor1215_v0__92_17="$__AF_get_supports_truecolor1215_v0";
            if [ "$__AF_get_supports_truecolor1215_v0__92_17" != 0 ]; then
                                    __AF_background_rgb1217_v0="\x1b[48;2;${r};${g};${b}m""${message}""\x1b[0m";
                    return 0
elif [ $(echo ${bg_fallback} '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                __AF_background_rgb1217_v0="${message}";
                return 0
else
                __AF_background_rgb1217_v0="\x1b[${bg_fallback}m""${message}""\x1b[0m";
                return 0
fi
else
        if [ $(echo ${bg_fallback} '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            __AF_background_rgb1217_v0="${message}";
            return 0
fi
        __AF_background_rgb1217_v0="\x1b[${bg_fallback}m""${message}""\x1b[0m";
        return 0
fi
}
inner_get_xylitol_colors__1218_v0() {
    if [ $(echo  '!' ${__32__got_xylitol_colors} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        env_const_get__89_v0 "XYLITOL_PRIMARY_COLOR";
        __AS=$?;
if [ $__AS != 0 ]; then
            echo "" > /dev/null 2>&1
fi;
        __AF_env_const_get89_v0__110_27="${__AF_env_const_get89_v0}";
        local primary_env="${__AF_env_const_get89_v0__110_27}"
        if [ $([ "_${primary_env}" == "_" ]; echo $?) != 0 ]; then
            split__3_v0 "${primary_env}" ";";
            __AF_split3_v0__112_25=("${__AF_split3_v0[@]}");
            local parts=("${__AF_split3_v0__112_25[@]}")
            if [ $(echo "${#parts[@]}" '==' 4 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                parse_number__12_v0 "${parts[0]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors1218_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__115_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[1]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors1218_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__116_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[2]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors1218_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__117_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[3]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors1218_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__118_21="$__AF_parse_number12_v0";
                __AMBER_ARRAY_178=("$__AF_parse_number12_v0__115_21" "$__AF_parse_number12_v0__116_21" "$__AF_parse_number12_v0__117_21" "$__AF_parse_number12_v0__118_21");
                __33__primary_color=("${__AMBER_ARRAY_178[@]}")
fi
fi
        env_const_get__89_v0 "XYLITOL_SECONDARY_COLOR";
        __AS=$?;
if [ $__AS != 0 ]; then
            echo "" > /dev/null 2>&1
fi;
        __AF_env_const_get89_v0__123_29="${__AF_env_const_get89_v0}";
        local secondary_env="${__AF_env_const_get89_v0__123_29}"
        if [ $([ "_${secondary_env}" == "_" ]; echo $?) != 0 ]; then
            split__3_v0 "${secondary_env}" ";";
            __AF_split3_v0__125_25=("${__AF_split3_v0[@]}");
            local parts=("${__AF_split3_v0__125_25[@]}")
            if [ $(echo "${#parts[@]}" '==' 4 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                parse_number__12_v0 "${parts[0]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors1218_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__128_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[1]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors1218_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__129_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[2]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors1218_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__130_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[3]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors1218_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__131_21="$__AF_parse_number12_v0";
                __AMBER_ARRAY_179=("$__AF_parse_number12_v0__128_21" "$__AF_parse_number12_v0__129_21" "$__AF_parse_number12_v0__130_21" "$__AF_parse_number12_v0__131_21");
                __34__secondary_color=("${__AMBER_ARRAY_179[@]}")
fi
fi
        env_const_get__89_v0 "XYLITOL_ACCENT_COLOR";
        __AS=$?;
if [ $__AS != 0 ]; then
            echo "" > /dev/null 2>&1
fi;
        __AF_env_const_get89_v0__136_26="${__AF_env_const_get89_v0}";
        local accent_env="${__AF_env_const_get89_v0__136_26}"
        if [ $([ "_${accent_env}" == "_" ]; echo $?) != 0 ]; then
            split__3_v0 "${accent_env}" ";";
            __AF_split3_v0__138_25=("${__AF_split3_v0[@]}");
            local parts=("${__AF_split3_v0__138_25[@]}")
            if [ $(echo "${#parts[@]}" '==' 4 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                parse_number__12_v0 "${parts[0]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors1218_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__141_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[1]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors1218_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__142_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[2]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors1218_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__143_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[3]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors1218_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__144_21="$__AF_parse_number12_v0";
                __AMBER_ARRAY_180=("$__AF_parse_number12_v0__141_21" "$__AF_parse_number12_v0__142_21" "$__AF_parse_number12_v0__143_21" "$__AF_parse_number12_v0__144_21");
                __35__accent_color=("${__AMBER_ARRAY_180[@]}")
fi
fi
        __32__got_xylitol_colors=1
fi
}
get_xylitol_colors__1219_v0() {
    inner_get_xylitol_colors__1218_v0 ;
    __AS=$?;
if [ $__AS != 0 ]; then
        echo_colored__105_v0 "WARN: Failed to parse Xylitol colors from envs." 33;
        __AF_echo_colored105_v0__155_9="$__AF_echo_colored105_v0";
        echo "$__AF_echo_colored105_v0__155_9" > /dev/null 2>&1
fi;
    __AF_inner_get_xylitol_colors1218_v0__154_5="$__AF_inner_get_xylitol_colors1218_v0";
    echo "$__AF_inner_get_xylitol_colors1218_v0__154_5" > /dev/null 2>&1
    __32__got_xylitol_colors=1
}
colored_primary__1220_v0() {
    local message=$1
    if [ $(echo  '!' ${__32__got_xylitol_colors} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        get_xylitol_colors__1219_v0 ;
        __AF_get_xylitol_colors1219_v0__162_9="$__AF_get_xylitol_colors1219_v0";
        echo "$__AF_get_xylitol_colors1219_v0__162_9" > /dev/null 2>&1
fi
    colored_rgb__1216_v0 "${message}" "${__33__primary_color[0]}" "${__33__primary_color[1]}" "${__33__primary_color[2]}" "${__33__primary_color[3]}";
    __AF_colored_rgb1216_v0__164_12="${__AF_colored_rgb1216_v0}";
    __AF_colored_primary1220_v0="${__AF_colored_rgb1216_v0__164_12}";
    return 0
}
colored_secondary__1221_v0() {
    local message=$1
    if [ $(echo  '!' ${__32__got_xylitol_colors} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        get_xylitol_colors__1219_v0 ;
        __AF_get_xylitol_colors1219_v0__169_9="$__AF_get_xylitol_colors1219_v0";
        echo "$__AF_get_xylitol_colors1219_v0__169_9" > /dev/null 2>&1
fi
    colored_rgb__1216_v0 "${message}" "${__34__secondary_color[0]}" "${__34__secondary_color[1]}" "${__34__secondary_color[2]}" "${__34__secondary_color[3]}";
    __AF_colored_rgb1216_v0__171_12="${__AF_colored_rgb1216_v0}";
    __AF_colored_secondary1221_v0="${__AF_colored_rgb1216_v0__171_12}";
    return 0
}
background_secondary__1224_v0() {
    local message=$1
    if [ $(echo  '!' ${__32__got_xylitol_colors} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        get_xylitol_colors__1219_v0 ;
        __AF_get_xylitol_colors1219_v0__190_9="$__AF_get_xylitol_colors1219_v0";
        echo "$__AF_get_xylitol_colors1219_v0__190_9" > /dev/null 2>&1
fi
    background_rgb__1217_v0 "${message}" "${__34__secondary_color[0]}" "${__34__secondary_color[1]}" "${__34__secondary_color[2]}" "${__34__secondary_color[3]}";
    __AF_background_rgb1217_v0__192_12="${__AF_background_rgb1217_v0}";
    __AF_background_secondary1224_v0="${__AF_background_rgb1217_v0__192_12}";
    return 0
}
# // IO Functions /////
get_key__1236_v0() {
    __AMBER_VAL_181=$( read -rsn1 k < /dev/tty; if [[ "$k" == $'\e' ]]; then read -rsn2 r < /dev/tty; k+=$r; fi; printf '%q' "$k" );
    __AS=$?;
    local var="${__AMBER_VAL_181}"
    if [ $([ "_${var}" != "_\$'\E[A'" ]; echo $?) != 0 ]; then
        __AF_get_key1236_v0="UP";
        return 0
elif [ $([ "_${var}" != "_\$'\E[B'" ]; echo $?) != 0 ]; then
        __AF_get_key1236_v0="DOWN";
        return 0
elif [ $([ "_${var}" != "_\$'\E[C'" ]; echo $?) != 0 ]; then
        __AF_get_key1236_v0="RIGHT";
        return 0
elif [ $([ "_${var}" != "_\$'\E[D'" ]; echo $?) != 0 ]; then
        __AF_get_key1236_v0="LEFT";
        return 0
elif [ $([ "_${var}" != "_\$'\177'" ]; echo $?) != 0 ]; then
        __AF_get_key1236_v0="BACKSPACE";
        return 0
elif [ $([ "_${var}" != "_''" ]; echo $?) != 0 ]; then
        __AF_get_key1236_v0="INPUT";
        return 0
else
        __AF_get_key1236_v0="${var}";
        return 0
fi
}
eprintf__1238_v0() {
    local format=$1
    local args=("${!2}")
     args=("${format}" "${args[@]}") ;
    __AS=$?
     printf "${args[@]}" >&2 ;
    __AS=$?
}
eprintf_colored__1239_v0() {
    local message=$1
    local color=$2
    # Prints an error message with a specified color.
    __AMBER_ARRAY_182=("${message}");
    eprintf__1238_v0 "\x1b[${color}m%s\x1b[0m" __AMBER_ARRAY_182[@];
    __AF_eprintf1238_v0__42_5="$__AF_eprintf1238_v0";
    echo "$__AF_eprintf1238_v0__42_5" > /dev/null 2>&1
}
colored__1240_v0() {
    local message=$1
    local color=$2
    # Returns a text wrapped in color codes.
    __AF_colored1240_v0="\x1b[${color}m""${message}""\x1b[0m";
    return 0
}
remove_line__1242_v0() {
    local cnt=$1
     printf '\x1b[2K\x1b[1A%.0s' $(seq ${cnt}) >&2 ;
    __AS=$?
    __AMBER_ARRAY_183=("");
    eprintf__1238_v0 "\x1b[9999D" __AMBER_ARRAY_183[@];
    __AF_eprintf1238_v0__58_5="$__AF_eprintf1238_v0";
    echo "$__AF_eprintf1238_v0__58_5" > /dev/null 2>&1
}
remove_current_line__1243_v0() {
    __AMBER_ARRAY_184=("");
    eprintf__1238_v0 "\x1b[2K\x1b[9999D" __AMBER_ARRAY_184[@];
    __AF_eprintf1238_v0__63_5="$__AF_eprintf1238_v0";
    echo "$__AF_eprintf1238_v0__63_5" > /dev/null 2>&1
}
go_up__1246_v0() {
    local cnt=$1
    __AMBER_ARRAY_185=("");
    eprintf__1238_v0 "\x1b[${cnt}A" __AMBER_ARRAY_185[@];
    __AF_eprintf1238_v0__81_5="$__AF_eprintf1238_v0";
    echo "$__AF_eprintf1238_v0__81_5" > /dev/null 2>&1
}
go_down__1247_v0() {
    local cnt=$1
    __AMBER_ARRAY_186=("");
    eprintf__1238_v0 "\x1b[${cnt}B" __AMBER_ARRAY_186[@];
    __AF_eprintf1238_v0__86_5="$__AF_eprintf1238_v0";
    echo "$__AF_eprintf1238_v0__86_5" > /dev/null 2>&1
}
# move the cursor up or down `cnt` lines.
hide_cursor__1249_v0() {
    __AMBER_ARRAY_187=("");
    eprintf__1238_v0 "\x1b[?25l" __AMBER_ARRAY_187[@];
    __AF_eprintf1238_v0__99_5="$__AF_eprintf1238_v0";
    echo "$__AF_eprintf1238_v0__99_5" > /dev/null 2>&1
}
show_cursor__1250_v0() {
    __AMBER_ARRAY_188=("");
    eprintf__1238_v0 "\x1b[?25h" __AMBER_ARRAY_188[@];
    __AF_eprintf1238_v0__103_5="$__AF_eprintf1238_v0";
    echo "$__AF_eprintf1238_v0__103_5" > /dev/null 2>&1
}
# / Text Utilities /////
has_ansi_escape__1251_v0() {
    local text=$1
    # Check for ESC character (0x1B = 27) or literal \x1b[
    __AMBER_VAL_189=$( [[ "${text}" == *$'\x1b'* || "${text}" == *'\x1b['* ]] && echo "1" || echo "0" );
    __AS=$?;
    local has_escape="${__AMBER_VAL_189}"
    __AF_has_ansi_escape1251_v0=$([ "_${has_escape}" != "_1" ]; echo $?);
    return 0
}
escape_ansi__1252_v0() {
    local text=$1
    __AMBER_VAL_190=$( printf '%s' "${text}" | sed $'s/\x1b/\\x1b/g' );
    __AS=$?;
    __AF_escape_ansi1252_v0="${__AMBER_VAL_190}";
    return 0
}
strip_ansi__1253_v0() {
    local text=$1
    __AMBER_VAL_191=$( printf "%s" "${text}" | sed $'s/\x1b\[[0-9;]*m//g' | sed 's/\\x1b\[[0-9;]*m//g' );
    __AS=$?;
    __AF_strip_ansi1253_v0="${__AMBER_VAL_191}";
    return 0
}
is_all_ascii__1254_v0() {
    local text=$1
    __AMBER_VAL_192=$( printf "%s" "${text}" | LC_ALL=C grep -q '^[ -~]*$' && echo 0 || echo 1 );
    __AS=$?;
    local result="${__AMBER_VAL_192}"
    __AF_is_all_ascii1254_v0=$([ "_${result}" != "_0" ]; echo $?);
    return 0
}
get_visible_len__1255_v0() {
    local text=$1
    strip_ansi__1253_v0 "${text}";
    __AF_strip_ansi1253_v0__138_20="${__AF_strip_ansi1253_v0}";
    local stripped="${__AF_strip_ansi1253_v0__138_20}"
    # Check if text is all ASCII
    is_all_ascii__1254_v0 "${stripped}";
    __AF_is_all_ascii1254_v0__140_12="$__AF_is_all_ascii1254_v0";
    if [ $(echo  '!' "$__AF_is_all_ascii1254_v0__140_12" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        # Try using perl
        perl_get_cjk_width__1192_v0 "${stripped}";
        __AS=$?;
if [ $__AS != 0 ]; then
            __AMBER_LEN="${stripped}";
            __AF_get_visible_len1255_v0="${#__AMBER_LEN}";
            return 0
fi;
        __AF_perl_get_cjk_width1192_v0__142_16="$__AF_perl_get_cjk_width1192_v0";
        __AF_get_visible_len1255_v0="$__AF_perl_get_cjk_width1192_v0__142_16";
        return 0
else
        __AMBER_LEN="${stripped}";
        __AF_get_visible_len1255_v0="${#__AMBER_LEN}";
        return 0
fi
}
truncate_text__1256_v0() {
    local text=$1
    local max_width=$2
    get_visible_len__1255_v0 "${text}";
    __AF_get_visible_len1255_v0__153_23="$__AF_get_visible_len1255_v0";
    local visible_len="$__AF_get_visible_len1255_v0__153_23"
    if [ $(echo ${visible_len} '<=' ${max_width} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        __AF_truncate_text1256_v0="${text}";
        return 0
fi
    is_all_ascii__1254_v0 "${text}";
    __AF_is_all_ascii1254_v0__157_12="$__AF_is_all_ascii1254_v0";
    if [ $(echo  '!' "$__AF_is_all_ascii1254_v0__157_12" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        perl_truncate_cjk__1193_v0 "${text}" ${max_width};
        __AS=$?;
if [ $__AS != 0 ]; then
             printf "%s" "${text}" | cut -c1-${max_width} ;
            __AS=$?
fi;
        __AF_perl_truncate_cjk1193_v0__158_16="${__AF_perl_truncate_cjk1193_v0}";
        __AF_truncate_text1256_v0="${__AF_perl_truncate_cjk1193_v0__158_16}";
        return 0
fi
    __AMBER_VAL_193=$( printf "%s" "${text}" | cut -c1-${max_width} );
    __AS=$?;
    __AF_truncate_text1256_v0="${__AMBER_VAL_193}";
    return 0
}
truncate_ansi__1257_v0() {
    local text=$1
    local max_width=$2
    has_ansi_escape__1251_v0 "${text}";
    __AF_has_ansi_escape1251_v0__169_12="$__AF_has_ansi_escape1251_v0";
    if [ $(echo  '!' "$__AF_has_ansi_escape1251_v0__169_12" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        truncate_text__1256_v0 "${text}" ${max_width};
        __AF_truncate_text1256_v0__170_16="${__AF_truncate_text1256_v0}";
        __AF_truncate_ansi1257_v0="${__AF_truncate_text1256_v0__170_16}";
        return 0
fi
    # Check if text starts with \x1b[
    __AMBER_VAL_194=$( [[ "${text}" == '\x1b['* ]] && echo "1" || echo "0" );
    __AS=$?;
    local starts_with_ansi="${__AMBER_VAL_194}"
    # Replace \x1b[ with newline, then split
    __AMBER_VAL_195=$( t="${text}"; printf '%s' "${t//\\x1b[/
}" );
    __AS=$?;
    local replaced="${__AMBER_VAL_195}"
    split__3_v0 "${replaced}" "
";
    __AF_split3_v0__179_17=("${__AF_split3_v0[@]}");
    local parts=("${__AF_split3_v0__179_17[@]}")
    local result=""
    local remaining_width=${max_width}
    for idx in $(seq 0 $(echo "${#parts[@]}" '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')); do
        local part="${parts[${idx}]}"
        # If text starts with ANSI, all parts are "ANSIparams m text" format
        # If not, first part is pure text
        if [ $(echo $(echo ${idx} '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '&&' $([ "_${starts_with_ansi}" != "_0" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            # First part is pure text (before any ANSI)
            if [ $(echo $([ "_${part}" == "_" ]; echo $?) '&&' $(echo ${remaining_width} '>' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                truncate_text__1256_v0 "${part}" ${remaining_width};
                __AF_truncate_text1256_v0__191_33="${__AF_truncate_text1256_v0}";
                local truncated="${__AF_truncate_text1256_v0__191_33}"
                result+="${truncated}"
                get_visible_len__1255_v0 "${truncated}";
                __AF_get_visible_len1255_v0__193_36="$__AF_get_visible_len1255_v0";
                remaining_width=$(echo ${remaining_width} '-' "$__AF_get_visible_len1255_v0__193_36" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
fi
else
            # Part is "ANSIparams m text" format - find first 'm'
            __AMBER_VAL_196=$( __p="${part}"; for ((i=0; i<${#__p}; i++)); do [[ "${__p:$i:1}" == "m" ]] && echo $i && break; done );
            __AS=$?;
            local m_idx="${__AMBER_VAL_196}"
            if [ $([ "_${m_idx}" == "_" ]; echo $?) != 0 ]; then
                # Reconstruct ANSI sequence
                __AMBER_VAL_197=$( __p="${part}"; printf "%s" "${__p:0:${m_idx}}" );
                __AS=$?;
                local ansi_params="${__AMBER_VAL_197}"
                result+="\\x1b[""${ansi_params}""m"
                # Rest is text content
                parse_number__12_v0 "${m_idx}";
                __AS=$?;
                __AF_parse_number12_v0__204_39="$__AF_parse_number12_v0";
                local m_idx_num="$__AF_parse_number12_v0__204_39"
                local text_start=$(echo ${m_idx_num} '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
                __AMBER_VAL_198=$( __p="${part}"; printf "%s" "${__p:${text_start}}" );
                __AS=$?;
                local text_part="${__AMBER_VAL_198}"
                if [ $(echo $([ "_${text_part}" == "_" ]; echo $?) '&&' $(echo ${remaining_width} '>' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                    truncate_text__1256_v0 "${text_part}" ${remaining_width};
                    __AF_truncate_text1256_v0__208_37="${__AF_truncate_text1256_v0}";
                    local truncated="${__AF_truncate_text1256_v0__208_37}"
                    result+="${truncated}"
                    get_visible_len__1255_v0 "${truncated}";
                    __AF_get_visible_len1255_v0__210_40="$__AF_get_visible_len1255_v0";
                    remaining_width=$(echo ${remaining_width} '-' "$__AF_get_visible_len1255_v0__210_40" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
fi
else
                # No 'm' found, treat as text
                if [ $(echo $([ "_${part}" == "_" ]; echo $?) '&&' $(echo ${remaining_width} '>' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                    truncate_text__1256_v0 "${part}" ${remaining_width};
                    __AF_truncate_text1256_v0__215_37="${__AF_truncate_text1256_v0}";
                    local truncated="${__AF_truncate_text1256_v0__215_37}"
                    result+="${truncated}"
                    get_visible_len__1255_v0 "${truncated}";
                    __AF_get_visible_len1255_v0__217_40="$__AF_get_visible_len1255_v0";
                    remaining_width=$(echo ${remaining_width} '-' "$__AF_get_visible_len1255_v0__217_40" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
fi
fi
fi
done
    __AF_truncate_ansi1257_v0="${result}";
    return 0
}
cutoff_text__1258_v0() {
    local text=$1
    local max_width=$2
    get_visible_len__1255_v0 "${text}";
    __AF_get_visible_len1255_v0__229_23="$__AF_get_visible_len1255_v0";
    local visible_len="$__AF_get_visible_len1255_v0__229_23"
    if [ $(echo ${visible_len} '<=' ${max_width} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        __AF_cutoff_text1258_v0="${text}";
        return 0
fi
    truncate_ansi__1257_v0 "${text}" $(echo ${max_width} '-' 3 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
    __AF_truncate_ansi1257_v0__233_12="${__AF_truncate_ansi1257_v0}";
    __AF_cutoff_text1258_v0="${__AF_truncate_ansi1257_v0__233_12}""...";
    return 0
}
# // Application Utilities /////
render_tooltip__1259_v0() {
    local items=("${!1}")
    local total_len=$2
    local term_width=$3
    local separator=" • "
    local separator_len=3
    # Fast path: no truncation needed
    if [ $(echo ${total_len} '<=' ${term_width} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        local iter=0
        while :
do
            if [ $(echo ${iter} '>=' "${#items[@]}" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                break
elif [ $(echo ${iter} '>' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                eprintf_colored__1239_v0 "${separator}" 90;
                __AF_eprintf_colored1239_v0__256_27="$__AF_eprintf_colored1239_v0";
                echo "$__AF_eprintf_colored1239_v0__256_27" > /dev/null 2>&1
fi
            colored__1240_v0 "${items[$(echo ${iter} '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')]}" 2;
            __AF_colored1240_v0__258_41="${__AF_colored1240_v0}";
            __AMBER_ARRAY_199=("");
            eprintf__1238_v0 "${items[${iter}]}"" ""${__AF_colored1240_v0__258_41}" __AMBER_ARRAY_199[@];
            __AF_eprintf1238_v0__258_13="$__AF_eprintf1238_v0";
            echo "$__AF_eprintf1238_v0__258_13" > /dev/null 2>&1
            iter=$(echo ${iter} '+' 2 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
done
else
        # Slow path: truncate
        local current_len=0
        local first=1
        local iter=0
        while :
do
            if [ $(echo ${iter} '>=' "${#items[@]}" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                break
fi
            local key="${items[${iter}]}"
            local action="${items[$(echo ${iter} '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')]}"
            __AMBER_LEN="${key}";
            __AMBER_LEN="${action}";
            local part_len=$(echo $(echo "${#__AMBER_LEN}" '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '+' "${#__AMBER_LEN}" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
            local needed=${part_len}
            if [ $(echo  '!' ${first} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                needed=$(echo ${needed} '+' ${separator_len} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
fi
            if [ $(echo $(echo ${current_len} '+' ${needed} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '>' ${term_width} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                break
fi
            if [ $(echo  '!' ${first} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                eprintf_colored__1239_v0 "${separator}" 90;
                __AF_eprintf_colored1239_v0__284_17="$__AF_eprintf_colored1239_v0";
                echo "$__AF_eprintf_colored1239_v0__284_17" > /dev/null 2>&1
fi
            colored__1240_v0 "${action}" 2;
            __AF_colored1240_v0__286_33="${__AF_colored1240_v0}";
            __AMBER_ARRAY_200=("");
            eprintf__1238_v0 "${key}"" ""${__AF_colored1240_v0__286_33}" __AMBER_ARRAY_200[@];
            __AF_eprintf1238_v0__286_13="$__AF_eprintf1238_v0";
            echo "$__AF_eprintf1238_v0__286_13" > /dev/null 2>&1
            current_len=$(echo ${current_len} '+' ${needed} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
            first=0
            iter=$(echo ${iter} '+' 2 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
done
fi
}
render_confirm_options__1309_v0() {
    local selected=$1
    local term_width=$2
    local small=$(echo ${term_width} '<' 30 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
    local yes_label=$(if [ ${small} != 0 ]; then echo " Yes "; else echo "    Yes    "; fi)
    local no_label=$(if [ ${small} != 0 ]; then echo " No "; else echo "    No    "; fi)
    local gap=$(if [ ${small} != 0 ]; then echo " "; else echo "  "; fi)
    __AMBER_ARRAY_201=("");
    eprintf__1238_v0 " " __AMBER_ARRAY_201[@];
    __AF_eprintf1238_v0__12_5="$__AF_eprintf1238_v0";
    echo "$__AF_eprintf1238_v0__12_5" > /dev/null 2>&1
    if [ ${selected} != 0 ]; then
        # Yes selected
        background_secondary__1224_v0 "${yes_label}";
        __AF_background_secondary1224_v0__15_30="${__AF_background_secondary1224_v0}";
        __AMBER_ARRAY_202=("");
        eprintf__1238_v0 "\x1b[97m""${__AF_background_secondary1224_v0__15_30}" __AMBER_ARRAY_202[@];
        __AF_eprintf1238_v0__15_9="$__AF_eprintf1238_v0";
        echo "$__AF_eprintf1238_v0__15_9" > /dev/null 2>&1
        __AMBER_ARRAY_203=("");
        eprintf__1238_v0 "${gap}" __AMBER_ARRAY_203[@];
        __AF_eprintf1238_v0__16_9="$__AF_eprintf1238_v0";
        echo "$__AF_eprintf1238_v0__16_9" > /dev/null 2>&1
        # No not selected (dim)
        __AMBER_ARRAY_204=("");
        eprintf__1238_v0 "\x1b[49;37m""${no_label}""\x1b[0m" __AMBER_ARRAY_204[@];
        __AF_eprintf1238_v0__18_9="$__AF_eprintf1238_v0";
        echo "$__AF_eprintf1238_v0__18_9" > /dev/null 2>&1
else
        # No selected
        __AMBER_ARRAY_205=("");
        eprintf__1238_v0 "\x1b[49;37m""${yes_label}""\x1b[0m" __AMBER_ARRAY_205[@];
        __AF_eprintf1238_v0__21_9="$__AF_eprintf1238_v0";
        echo "$__AF_eprintf1238_v0__21_9" > /dev/null 2>&1
        __AMBER_ARRAY_206=("");
        eprintf__1238_v0 "${gap}" __AMBER_ARRAY_206[@];
        __AF_eprintf1238_v0__22_9="$__AF_eprintf1238_v0";
        echo "$__AF_eprintf1238_v0__22_9" > /dev/null 2>&1
        background_secondary__1224_v0 "${no_label}";
        __AF_background_secondary1224_v0__23_30="${__AF_background_secondary1224_v0}";
        __AMBER_ARRAY_207=("");
        eprintf__1238_v0 "\x1b[97m""${__AF_background_secondary1224_v0__23_30}" __AMBER_ARRAY_207[@];
        __AF_eprintf1238_v0__23_9="$__AF_eprintf1238_v0";
        echo "$__AF_eprintf1238_v0__23_9" > /dev/null 2>&1
fi
}
xyl_confirm__1310_v0() {
    local header=$1
    local default_yes=$2
    stty_lock__1200_v0 ;
    __AF_stty_lock1200_v0__39_5="$__AF_stty_lock1200_v0";
    echo "$__AF_stty_lock1200_v0__39_5" > /dev/null 2>&1
    hide_cursor__1249_v0 ;
    __AF_hide_cursor1249_v0__40_5="$__AF_hide_cursor1249_v0";
    echo "$__AF_hide_cursor1249_v0__40_5" > /dev/null 2>&1
    term_width__1204_v0 ;
    __AF_term_width1204_v0__42_22="$__AF_term_width1204_v0";
    local term_width="$__AF_term_width1204_v0__42_22"
    if [ $([ "_${header}" == "_" ]; echo $?) != 0 ]; then
        cutoff_text__1258_v0 "${header}" ${term_width};
        __AF_cutoff_text1258_v0__45_17="${__AF_cutoff_text1258_v0}";
        __AMBER_ARRAY_208=("");
        eprintf__1238_v0 "${__AF_cutoff_text1258_v0__45_17}""

" __AMBER_ARRAY_208[@];
        __AF_eprintf1238_v0__45_9="$__AF_eprintf1238_v0";
        echo "$__AF_eprintf1238_v0__45_9" > /dev/null 2>&1
fi
    local selected=${default_yes}
    # Render initial options
    render_confirm_options__1309_v0 ${selected} ${term_width};
    __AF_render_confirm_options1309_v0__51_5="$__AF_render_confirm_options1309_v0";
    echo "$__AF_render_confirm_options1309_v0__51_5" > /dev/null 2>&1
    __AMBER_ARRAY_209=("");
    eprintf__1238_v0 "

" __AMBER_ARRAY_209[@];
    __AF_eprintf1238_v0__53_5="$__AF_eprintf1238_v0";
    echo "$__AF_eprintf1238_v0__53_5" > /dev/null 2>&1
    # "←→ select • enter confirm • y yes • n no" = 9 + 3 + 13 + 3 + 5 + 3 + 4 = 40
    __AMBER_ARRAY_210=("←→" "select" "enter" "confirm" "y" "yes" "n" "no");
    render_tooltip__1259_v0 __AMBER_ARRAY_210[@] 40 ${term_width};
    __AF_render_tooltip1259_v0__55_5="$__AF_render_tooltip1259_v0";
    echo "$__AF_render_tooltip1259_v0__55_5" > /dev/null 2>&1
    go_up__1246_v0 2;
    __AF_go_up1246_v0__56_5="$__AF_go_up1246_v0";
    echo "$__AF_go_up1246_v0__56_5" > /dev/null 2>&1
    while :
do
        get_key__1236_v0 ;
        __AF_get_key1236_v0__59_19="${__AF_get_key1236_v0}";
        local key="${__AF_get_key1236_v0__59_19}"
        if [ $(echo $(echo $(echo $([ "_${key}" != "_LEFT" ]; echo $?) '||' $([ "_${key}" != "_h" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '||' $([ "_${key}" != "_RIGHT" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '||' $([ "_${key}" != "_l" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            if [ ${selected} != 0 ]; then
                selected=0
                __AMBER_ARRAY_211=("");
                eprintf__1238_v0 "\x1b[9999D\x1b[K" __AMBER_ARRAY_211[@];
                __AF_eprintf1238_v0__66_25="$__AF_eprintf1238_v0";
                echo "$__AF_eprintf1238_v0__66_25" > /dev/null 2>&1
                render_confirm_options__1309_v0 ${selected} ${term_width};
                __AF_render_confirm_options1309_v0__67_25="$__AF_render_confirm_options1309_v0";
                echo "$__AF_render_confirm_options1309_v0__67_25" > /dev/null 2>&1
elif [ $(echo  '!' ${selected} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                selected=1
                __AMBER_ARRAY_212=("");
                eprintf__1238_v0 "\x1b[9999D\x1b[K" __AMBER_ARRAY_212[@];
                __AF_eprintf1238_v0__71_25="$__AF_eprintf1238_v0";
                echo "$__AF_eprintf1238_v0__71_25" > /dev/null 2>&1
                render_confirm_options__1309_v0 ${selected} ${term_width};
                __AF_render_confirm_options1309_v0__72_25="$__AF_render_confirm_options1309_v0";
                echo "$__AF_render_confirm_options1309_v0__72_25" > /dev/null 2>&1
fi
elif [ $(echo $([ "_${key}" != "_y" ]; echo $?) '||' $([ "_${key}" != "_Y" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            selected=1
            break
elif [ $(echo $([ "_${key}" != "_n" ]; echo $?) '||' $([ "_${key}" != "_N" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            selected=0
            break
elif [ $([ "_${key}" != "_INPUT" ]; echo $?) != 0 ]; then
            break
else
            continue
fi
done
    # Clean up: remove options line and hint line
    local total_lines=4
    if [ $([ "_${header}" == "_" ]; echo $?) != 0 ]; then
        total_lines=$(echo ${total_lines} '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
fi
    go_down__1247_v0 2;
    __AF_go_down1247_v0__97_5="$__AF_go_down1247_v0";
    echo "$__AF_go_down1247_v0__97_5" > /dev/null 2>&1
    remove_line__1242_v0 $(echo ${total_lines} '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
    __AF_remove_line1242_v0__98_5="$__AF_remove_line1242_v0";
    echo "$__AF_remove_line1242_v0__98_5" > /dev/null 2>&1
    remove_current_line__1243_v0 ;
    __AF_remove_current_line1243_v0__99_5="$__AF_remove_current_line1243_v0";
    echo "$__AF_remove_current_line1243_v0__99_5" > /dev/null 2>&1
    stty_unlock__1201_v0 ;
    __AF_stty_unlock1201_v0__101_5="$__AF_stty_unlock1201_v0";
    echo "$__AF_stty_unlock1201_v0__101_5" > /dev/null 2>&1
    show_cursor__1250_v0 ;
    __AF_show_cursor1250_v0__102_5="$__AF_show_cursor1250_v0";
    echo "$__AF_show_cursor1250_v0__102_5" > /dev/null 2>&1
    __AF_xyl_confirm1310_v0=${selected};
    return 0
}
print_confirm_help__1386_v0() {
    echo "Usage: ./xylitol.sh confirm [flags]"
    echo ""
    colored_primary__1220_v0 "confirm";
    __AF_colored_primary1220_v0__7_12="${__AF_colored_primary1220_v0}";
    __AMBER_ARRAY_213=("");
    printf__99_v0 "${__AF_colored_primary1220_v0__7_12}" __AMBER_ARRAY_213[@];
    __AF_printf99_v0__7_5="$__AF_printf99_v0";
    echo "$__AF_printf99_v0__7_5" > /dev/null 2>&1
    __AMBER_ARRAY_214=("");
    printf__99_v0 " - Display a Yes/No confirmation dialog." __AMBER_ARRAY_214[@];
    __AF_printf99_v0__8_5="$__AF_printf99_v0";
    echo "$__AF_printf99_v0__8_5" > /dev/null 2>&1
    echo ""
    echo ""
    colored_secondary__1221_v0 "Flags: ";
    __AF_colored_secondary1221_v0__11_12="${__AF_colored_secondary1221_v0}";
    __AMBER_ARRAY_215=("");
    printf__99_v0 "${__AF_colored_secondary1221_v0__11_12}""
" __AMBER_ARRAY_215[@];
    __AF_printf99_v0__11_5="$__AF_printf99_v0";
    echo "$__AF_printf99_v0__11_5" > /dev/null 2>&1
    echo "  -h, --help             Show this help message"
    echo "  --header=\"<text>\"      Set a header text to display above the options (ANSI escape supported)"
    echo "  --default=<yes|no>     Set the default selection (default: yes)"
    echo ""
}
execute_confirm__1437_v0() {
    local parameters=("${!1}")
    colored_primary__1220_v0 "Are you sure?";
    __AF_colored_primary1220_v0__9_30="${__AF_colored_primary1220_v0}";
    local header="\x1b[1m""${__AF_colored_primary1220_v0__9_30}"
    local default_yes=1
    for param in "${parameters[@]}"; do
        match_regex__17_v0 "${param}" "^-h\$" 0;
        __AF_match_regex17_v0__14_13="$__AF_match_regex17_v0";
        match_regex__17_v0 "${param}" "^--help\$" 0;
        __AF_match_regex17_v0__14_43="$__AF_match_regex17_v0";
        match_regex__17_v0 "${param}" "^--header=.*\$" 0;
        __AF_match_regex17_v0__18_13="$__AF_match_regex17_v0";
        match_regex__17_v0 "${param}" "^--default=.*\$" 0;
        __AF_match_regex17_v0__22_13="$__AF_match_regex17_v0";
        if [ $(echo "$__AF_match_regex17_v0__14_13" '||' "$__AF_match_regex17_v0__14_43" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            print_confirm_help__1386_v0 ;
            __AF_print_confirm_help1386_v0__15_17="$__AF_print_confirm_help1386_v0";
            echo "$__AF_print_confirm_help1386_v0__15_17" > /dev/null 2>&1
            exit 0
elif [ "$__AF_match_regex17_v0__18_13" != 0 ]; then
            split__3_v0 "${param}" "=";
            __AF_split3_v0__19_30=("${__AF_split3_v0[@]}");
            local result=("${__AF_split3_v0__19_30[@]}")
            header="${result[1]}"
elif [ "$__AF_match_regex17_v0__22_13" != 0 ]; then
            split__3_v0 "${param}" "=";
            __AF_split3_v0__23_30=("${__AF_split3_v0[@]}");
            local result=("${__AF_split3_v0__23_30[@]}")
            if [ $(echo $([ "_${result[1]}" != "_yes" ]; echo $?) '||' $([ "_${result[1]}" != "_y" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                default_yes=1
elif [ $(echo $([ "_${result[1]}" != "_no" ]; echo $?) '||' $([ "_${result[1]}" != "_n" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                default_yes=0
else
                                    eprintf_colored__1239_v0 "ERROR: Invalid default value: ""${result[1]}"". Use 'yes' or 'no'.
" 31;
                    __AF_eprintf_colored1239_v0__28_25="$__AF_eprintf_colored1239_v0";
                    echo "$__AF_eprintf_colored1239_v0__28_25" > /dev/null 2>&1
                    exit 1
fi
fi
done
    has_ansi_escape__1251_v0 "${header}";
    __AF_has_ansi_escape1251_v0__36_42="$__AF_has_ansi_escape1251_v0";
    escape_ansi__1252_v0 "${header}";
    __AF_escape_ansi1252_v0__36_71="${__AF_escape_ansi1252_v0}";
    colored_primary__1220_v0 "${header}";
    __AF_colored_primary1220_v0__36_109="${__AF_colored_primary1220_v0}";
    local display_header=$(if [ $(echo $([ "_${header}" != "_" ]; echo $?) '||' "$__AF_has_ansi_escape1251_v0__36_42" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then echo "${__AF_escape_ansi1252_v0__36_71}"; else echo "\\x1b[1m""${__AF_colored_primary1220_v0__36_109}"; fi)
    xyl_confirm__1310_v0 "${display_header}" ${default_yes};
    __AF_xyl_confirm1310_v0__37_18="$__AF_xyl_confirm1310_v0";
    local result="$__AF_xyl_confirm1310_v0__37_18"
    __AF_execute_confirm1437_v0=$(if [ ${result} != 0 ]; then echo "yes"; else echo "no"; fi);
    return 0
}
get_directory_entries__1552_v0() {
    local path=$1
    __AMBER_VAL_216=$( ls -lA "${path}" 2>/dev/null | tail -n +2 );
    __AS=$?;
    local raw="${__AMBER_VAL_216}"
    __AMBER_VAL_217=$( ls -lA "${path}" | tail -n +2 | sed -E 's/^(.).*/\1/' );
    __AS=$?;
    local types="${__AMBER_VAL_217}"
    __AMBER_VAL_218=$( ls -1A "${path}" );
    __AS=$?;
    local names="${__AMBER_VAL_218}"
    split__3_v0 "${types}" "
";
    __AF_split3_v0__10_17=("${__AF_split3_v0[@]}");
    local types=("${__AF_split3_v0__10_17[@]}")
    split__3_v0 "${raw}" "
";
    __AF_split3_v0__11_15=("${__AF_split3_v0[@]}");
    local raw=("${__AF_split3_v0__11_15[@]}")
    split__3_v0 "${names}" "
";
    __AF_split3_v0__12_17=("${__AF_split3_v0[@]}");
    local names=("${__AF_split3_v0__12_17[@]}")
    __AMBER_ARRAY_219=();
    local entries=("${__AMBER_ARRAY_219[@]}")
    for i in $(seq 0 $(echo "${#raw[@]}" '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')); do
        local file_type="f"
        local target=""
        if [ $([ "_${types[${i}]}" != "_-" ]; echo $?) != 0 ]; then
            file_type="f"
elif [ $([ "_${types[${i}]}" != "_l" ]; echo $?) != 0 ]; then
            __AMBER_VAL_220=$( echo ${raw[${i}]} | sed 's/.*-> //' );
            __AS=$?;
            target="${__AMBER_VAL_220}"
            file_type="l"
fi
        if [ $([ "_${file_type}" != "_l" ]; echo $?) != 0 ]; then
            __AMBER_ARRAY_221=("${names[${i}]}	${types[${i}]}	${target}");
            entries+=("${__AMBER_ARRAY_221[@]}")
else
            __AMBER_ARRAY_222=("${names[${i}]}	${types[${i}]}");
            entries+=("${__AMBER_ARRAY_222[@]}")
fi
done
    __AF_get_directory_entries1552_v0=("${entries[@]}");
    return 0
}
parse_entry__1553_v0() {
    local entry=$1
    split__3_v0 "${entry}" "	";
    __AF_split3_v0__40_12=("${__AF_split3_v0[@]}");
    __AF_parse_entry1553_v0=("${__AF_split3_v0__40_12[@]}");
    return 0
}
get_cwd__1554_v0() {
    __AMBER_VAL_223=$( pwd );
    __AS=$?;
    __AF_get_cwd1554_v0="${__AMBER_VAL_223}";
    return 0
}
normalize_path__1555_v0() {
    local path=$1
    __AMBER_VAL_224=$( cd "${path}" 2>/dev/null && pwd );
    __AS=$?;
    local normalized="${__AMBER_VAL_224}"
    if [ $([ "_${normalized}" != "_" ]; echo $?) != 0 ]; then
        __AF_normalize_path1555_v0="${path}";
        return 0
fi
    __AF_normalize_path1555_v0="${normalized}";
    return 0
}
path_join__1557_v0() {
    local base=$1
    local child=$2
    if [ $([ "_${base}" != "_/" ]; echo $?) != 0 ]; then
        __AF_path_join1557_v0="/""${child}";
        return 0
fi
    __AF_path_join1557_v0="${base}""/""${child}";
    return 0
}
get_parent_dir__1558_v0() {
    local path=$1
    __AMBER_VAL_225=$( dirname "${path}" );
    __AS=$?;
    local parent="${__AMBER_VAL_225}"
    __AF_get_parent_dir1558_v0="${parent}";
    return 0
}
# Perl Extensions Utilities
__AMBER_VAL_226=$( echo "$XYLITOL_USE_PERL" );
__AS=$?;
__36__perl_disabled=$([ "_${__AMBER_VAL_226}" != "_No" ]; echo $?)
__AMBER_VAL_227=$( command -v perl > /dev/null && echo 0 || echo 1 );
__AS=$?;
__37__perl_available=$(echo $(echo  '!' ${__36__perl_disabled} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '&&' $([ "_${__AMBER_VAL_227}" != "_0" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
# global variables to store terminal size
# (prevent multiple queries in one session)
__38__got_term_size=0
__AMBER_ARRAY_228=(80 24);
__39__term_size=("${__AMBER_ARRAY_228[@]}")
# stty lock/unlock using environment variable for cross-module state
 export XYLITOL_RUNTIME_STTY_COUNT=0 ;
__AS=$?
stty_lock__1575_v0() {
    __AMBER_VAL_229=$( echo "${XYLITOL_RUNTIME_STTY_COUNT:-0}" );
    __AS=$?;
    local count="${__AMBER_VAL_229}"
    parse_number__12_v0 "${count}";
    __AS=$?;
if [ $__AS != 0 ]; then
        echo 0 > /dev/null 2>&1
fi;
    __AF_parse_number12_v0__14_21="$__AF_parse_number12_v0";
    local count_num="$__AF_parse_number12_v0__14_21"
    if [ $(echo ${count_num} '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
         stty -echo < /dev/tty ;
        __AS=$?
fi
    count_num=$(echo ${count_num} '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
     export XYLITOL_RUNTIME_STTY_COUNT=${count_num} ;
    __AS=$?
}
stty_unlock__1576_v0() {
    __AMBER_VAL_230=$( echo "${XYLITOL_RUNTIME_STTY_COUNT:-0}" );
    __AS=$?;
    local count="${__AMBER_VAL_230}"
    parse_number__12_v0 "${count}";
    __AS=$?;
if [ $__AS != 0 ]; then
        echo 0 > /dev/null 2>&1
fi;
    __AF_parse_number12_v0__25_21="$__AF_parse_number12_v0";
    local count_num="$__AF_parse_number12_v0__25_21"
    if [ $(echo ${count_num} '>' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        count_num=$(echo ${count_num} '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
         export XYLITOL_RUNTIME_STTY_COUNT=${count_num} ;
        __AS=$?
        if [ $(echo ${count_num} '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
             stty echo < /dev/tty ;
            __AS=$?
fi
fi
}
get_term_size__1577_v0() {
    # Query terminal size with \x1b[18t, response format: \x1b[8;rows;colst
    __AMBER_VAL_231=$( printf '\x1b[18t' > /dev/tty; IFS=';' read -rsd t _ignore height width < /dev/tty; echo "$height; $width" );
    __AS=$?;
    local result="${__AMBER_VAL_231}"
    split__3_v0 "${result}" ";";
    __AF_split3_v0__39_17=("${__AF_split3_v0[@]}");
    local parts=("${__AF_split3_v0__39_17[@]}")
    if [ $(echo "${#parts[@]}" '!=' 2 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        __AF_get_term_size1577_v0='';
        return 1
fi
    parse_number__12_v0 "${parts[0]}";
    __AS=$?;
if [ $__AS != 0 ]; then
__AF_get_term_size1577_v0=''
return $__AS
fi;
    __AF_parse_number12_v0__43_16="$__AF_parse_number12_v0";
    local rows="$__AF_parse_number12_v0__43_16"
    parse_number__12_v0 "${parts[1]}";
    __AS=$?;
if [ $__AS != 0 ]; then
__AF_get_term_size1577_v0=''
return $__AS
fi;
    __AF_parse_number12_v0__44_16="$__AF_parse_number12_v0";
    local cols="$__AF_parse_number12_v0__44_16"
    __AMBER_ARRAY_232=(${cols} ${rows});
    __39__term_size=("${__AMBER_ARRAY_232[@]}")
    __38__got_term_size=1
}
term_width__1579_v0() {
    if [ $(echo  '!' ${__38__got_term_size} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        get_term_size__1577_v0 ;
        __AS=$?;
        __AF_get_term_size1577_v0__60_15="$__AF_get_term_size1577_v0";
        echo "$__AF_get_term_size1577_v0__60_15" > /dev/null 2>&1
fi
    __AF_term_width1579_v0="${__39__term_size[0]}";
    return 0
}
# A global variable indicating if the terminal supports truecolor.
# "None" or "Yes" or "No"
# 
# This value is only updated by the `get_supports_truecolor` function
# executed by `colored_rgb` on its first call.
__40__supports_truecolor="None"
# A global variable indicating if the Xylitol colors have been loaded from environment variables.
__41__got_xylitol_colors=0
__AMBER_ARRAY_233=(3 207 159 92);
__42__primary_color=("${__AMBER_ARRAY_233[@]}")
__AMBER_ARRAY_234=(3 118 206 94);
__43__secondary_color=("${__AMBER_ARRAY_234[@]}")
__AMBER_ARRAY_235=(234 72 121 95);
__44__accent_color=("${__AMBER_ARRAY_235[@]}")
get_supports_truecolor__1590_v0() {
    env_const_get__89_v0 "XYLITOL_TRUECOLOR";
    __AS=$?;
if [ $__AS != 0 ]; then
        echo "" > /dev/null 2>&1
fi;
    __AF_env_const_get89_v0__20_18="${__AF_env_const_get89_v0}";
    local config="${__AF_env_const_get89_v0__20_18}"
    if [ $([ "_${config}" != "_No" ]; echo $?) != 0 ]; then
        __40__supports_truecolor="No"
        __AF_get_supports_truecolor1590_v0=0;
        return 0
fi
    env_const_get__89_v0 "COLORTERM";
    __AS=$?;
if [ $__AS != 0 ]; then
        __40__supports_truecolor="No"
        __AF_get_supports_truecolor1590_v0=0;
        return 0
fi;
    __AF_env_const_get89_v0__25_21="${__AF_env_const_get89_v0}";
    local colorterm="${__AF_env_const_get89_v0__25_21}"
    __40__supports_truecolor=$(if [ $(echo $([ "_${colorterm}" != "_truecolor" ]; echo $?) '||' $([ "_${colorterm}" != "_24bit" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then echo "Yes"; else echo "No"; fi)
    __AF_get_supports_truecolor1590_v0=$([ "_${__40__supports_truecolor}" != "_Yes" ]; echo $?);
    return 0
}
colored_rgb__1591_v0() {
    local message=$1
    local r=$2
    local g=$3
    local b=$4
    local fallback=$5
    if [ $([ "_${__40__supports_truecolor}" != "_Yes" ]; echo $?) != 0 ]; then
                    __AF_colored_rgb1591_v0="\x1b[38;2;${r};${g};${b}m""${message}""\x1b[0m";
            return 0
elif [ $([ "_${__40__supports_truecolor}" != "_None" ]; echo $?) != 0 ]; then
                    get_supports_truecolor__1590_v0 ;
            __AF_get_supports_truecolor1590_v0__50_17="$__AF_get_supports_truecolor1590_v0";
            if [ "$__AF_get_supports_truecolor1590_v0__50_17" != 0 ]; then
                                    __AF_colored_rgb1591_v0="\x1b[38;2;${r};${g};${b}m""${message}""\x1b[0m";
                    return 0
elif [ $(echo ${fallback} '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                __AF_colored_rgb1591_v0="${message}";
                return 0
else
                __AF_colored_rgb1591_v0="\x1b[${fallback}m""${message}""\x1b[0m";
                return 0
fi
else
        if [ $(echo ${fallback} '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            __AF_colored_rgb1591_v0="${message}";
            return 0
fi
        __AF_colored_rgb1591_v0="\x1b[${fallback}m""${message}""\x1b[0m";
        return 0
fi
}
inner_get_xylitol_colors__1593_v0() {
    if [ $(echo  '!' ${__41__got_xylitol_colors} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        env_const_get__89_v0 "XYLITOL_PRIMARY_COLOR";
        __AS=$?;
if [ $__AS != 0 ]; then
            echo "" > /dev/null 2>&1
fi;
        __AF_env_const_get89_v0__110_27="${__AF_env_const_get89_v0}";
        local primary_env="${__AF_env_const_get89_v0__110_27}"
        if [ $([ "_${primary_env}" == "_" ]; echo $?) != 0 ]; then
            split__3_v0 "${primary_env}" ";";
            __AF_split3_v0__112_25=("${__AF_split3_v0[@]}");
            local parts=("${__AF_split3_v0__112_25[@]}")
            if [ $(echo "${#parts[@]}" '==' 4 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                parse_number__12_v0 "${parts[0]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors1593_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__115_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[1]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors1593_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__116_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[2]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors1593_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__117_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[3]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors1593_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__118_21="$__AF_parse_number12_v0";
                __AMBER_ARRAY_236=("$__AF_parse_number12_v0__115_21" "$__AF_parse_number12_v0__116_21" "$__AF_parse_number12_v0__117_21" "$__AF_parse_number12_v0__118_21");
                __42__primary_color=("${__AMBER_ARRAY_236[@]}")
fi
fi
        env_const_get__89_v0 "XYLITOL_SECONDARY_COLOR";
        __AS=$?;
if [ $__AS != 0 ]; then
            echo "" > /dev/null 2>&1
fi;
        __AF_env_const_get89_v0__123_29="${__AF_env_const_get89_v0}";
        local secondary_env="${__AF_env_const_get89_v0__123_29}"
        if [ $([ "_${secondary_env}" == "_" ]; echo $?) != 0 ]; then
            split__3_v0 "${secondary_env}" ";";
            __AF_split3_v0__125_25=("${__AF_split3_v0[@]}");
            local parts=("${__AF_split3_v0__125_25[@]}")
            if [ $(echo "${#parts[@]}" '==' 4 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                parse_number__12_v0 "${parts[0]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors1593_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__128_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[1]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors1593_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__129_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[2]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors1593_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__130_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[3]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors1593_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__131_21="$__AF_parse_number12_v0";
                __AMBER_ARRAY_237=("$__AF_parse_number12_v0__128_21" "$__AF_parse_number12_v0__129_21" "$__AF_parse_number12_v0__130_21" "$__AF_parse_number12_v0__131_21");
                __43__secondary_color=("${__AMBER_ARRAY_237[@]}")
fi
fi
        env_const_get__89_v0 "XYLITOL_ACCENT_COLOR";
        __AS=$?;
if [ $__AS != 0 ]; then
            echo "" > /dev/null 2>&1
fi;
        __AF_env_const_get89_v0__136_26="${__AF_env_const_get89_v0}";
        local accent_env="${__AF_env_const_get89_v0__136_26}"
        if [ $([ "_${accent_env}" == "_" ]; echo $?) != 0 ]; then
            split__3_v0 "${accent_env}" ";";
            __AF_split3_v0__138_25=("${__AF_split3_v0[@]}");
            local parts=("${__AF_split3_v0__138_25[@]}")
            if [ $(echo "${#parts[@]}" '==' 4 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                parse_number__12_v0 "${parts[0]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors1593_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__141_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[1]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors1593_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__142_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[2]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors1593_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__143_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[3]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors1593_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__144_21="$__AF_parse_number12_v0";
                __AMBER_ARRAY_238=("$__AF_parse_number12_v0__141_21" "$__AF_parse_number12_v0__142_21" "$__AF_parse_number12_v0__143_21" "$__AF_parse_number12_v0__144_21");
                __44__accent_color=("${__AMBER_ARRAY_238[@]}")
fi
fi
        __41__got_xylitol_colors=1
fi
}
get_xylitol_colors__1594_v0() {
    inner_get_xylitol_colors__1593_v0 ;
    __AS=$?;
if [ $__AS != 0 ]; then
        echo_colored__105_v0 "WARN: Failed to parse Xylitol colors from envs." 33;
        __AF_echo_colored105_v0__155_9="$__AF_echo_colored105_v0";
        echo "$__AF_echo_colored105_v0__155_9" > /dev/null 2>&1
fi;
    __AF_inner_get_xylitol_colors1593_v0__154_5="$__AF_inner_get_xylitol_colors1593_v0";
    echo "$__AF_inner_get_xylitol_colors1593_v0__154_5" > /dev/null 2>&1
    __41__got_xylitol_colors=1
}
colored_primary__1595_v0() {
    local message=$1
    if [ $(echo  '!' ${__41__got_xylitol_colors} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        get_xylitol_colors__1594_v0 ;
        __AF_get_xylitol_colors1594_v0__162_9="$__AF_get_xylitol_colors1594_v0";
        echo "$__AF_get_xylitol_colors1594_v0__162_9" > /dev/null 2>&1
fi
    colored_rgb__1591_v0 "${message}" "${__42__primary_color[0]}" "${__42__primary_color[1]}" "${__42__primary_color[2]}" "${__42__primary_color[3]}";
    __AF_colored_rgb1591_v0__164_12="${__AF_colored_rgb1591_v0}";
    __AF_colored_primary1595_v0="${__AF_colored_rgb1591_v0__164_12}";
    return 0
}
colored_secondary__1596_v0() {
    local message=$1
    if [ $(echo  '!' ${__41__got_xylitol_colors} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        get_xylitol_colors__1594_v0 ;
        __AF_get_xylitol_colors1594_v0__169_9="$__AF_get_xylitol_colors1594_v0";
        echo "$__AF_get_xylitol_colors1594_v0__169_9" > /dev/null 2>&1
fi
    colored_rgb__1591_v0 "${message}" "${__43__secondary_color[0]}" "${__43__secondary_color[1]}" "${__43__secondary_color[2]}" "${__43__secondary_color[3]}";
    __AF_colored_rgb1591_v0__171_12="${__AF_colored_rgb1591_v0}";
    __AF_colored_secondary1596_v0="${__AF_colored_rgb1591_v0__171_12}";
    return 0
}
colored_accent__1597_v0() {
    local message=$1
    if [ $(echo  '!' ${__41__got_xylitol_colors} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        get_xylitol_colors__1594_v0 ;
        __AF_get_xylitol_colors1594_v0__176_9="$__AF_get_xylitol_colors1594_v0";
        echo "$__AF_get_xylitol_colors1594_v0__176_9" > /dev/null 2>&1
fi
    colored_rgb__1591_v0 "${message}" "${__44__accent_color[0]}" "${__44__accent_color[1]}" "${__44__accent_color[2]}" "${__44__accent_color[3]}";
    __AF_colored_rgb1591_v0__178_12="${__AF_colored_rgb1591_v0}";
    __AF_colored_accent1597_v0="${__AF_colored_rgb1591_v0__178_12}";
    return 0
}
# // IO Functions /////
eprintf__1613_v0() {
    local format=$1
    local args=("${!2}")
     args=("${format}" "${args[@]}") ;
    __AS=$?
     printf "${args[@]}" >&2 ;
    __AS=$?
}
eprintf_colored__1614_v0() {
    local message=$1
    local color=$2
    # Prints an error message with a specified color.
    __AMBER_ARRAY_239=("${message}");
    eprintf__1613_v0 "\x1b[${color}m%s\x1b[0m" __AMBER_ARRAY_239[@];
    __AF_eprintf1613_v0__42_5="$__AF_eprintf1613_v0";
    echo "$__AF_eprintf1613_v0__42_5" > /dev/null 2>&1
}
remove_current_line__1618_v0() {
    __AMBER_ARRAY_240=("");
    eprintf__1613_v0 "\x1b[2K\x1b[9999D" __AMBER_ARRAY_240[@];
    __AF_eprintf1613_v0__63_5="$__AF_eprintf1613_v0";
    echo "$__AF_eprintf1613_v0__63_5" > /dev/null 2>&1
}
# move the cursor up or down `cnt` lines.
# / Text Utilities /////
# // Application Utilities /////

# Perl Extensions Utilities
__AMBER_VAL_241=$( echo "$XYLITOL_USE_PERL" );
__AS=$?;
__45__perl_disabled=$([ "_${__AMBER_VAL_241}" != "_No" ]; echo $?)
__AMBER_VAL_242=$( command -v perl > /dev/null && echo 0 || echo 1 );
__AS=$?;
__46__perl_available=$(echo $(echo  '!' ${__45__perl_disabled} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '&&' $([ "_${__AMBER_VAL_242}" != "_0" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
perl_get_cjk_width__1761_v0() {
    local text=$1
    if [ $(echo  '!' ${__46__perl_available} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        __AF_perl_get_cjk_width1761_v0='';
        return 1
fi
    __AMBER_VAL_243=$( perl -CSDA -E '$w=0;$w+=/\p{EastAsianWidth=Wide}|\p{EastAsianWidth=Fullwidth}|\p{EastAsianWidth=Ambiguous}/?2:1 for split//,shift; say $w' "${text}" 2>/dev/null );
    __AS=$?;
if [ $__AS != 0 ]; then
__AF_perl_get_cjk_width1761_v0=''
return $__AS
fi;
    local width_str="${__AMBER_VAL_243}"
    parse_number__12_v0 "${width_str}";
    __AS=$?;
if [ $__AS != 0 ]; then
__AF_perl_get_cjk_width1761_v0=''
return $__AS
fi;
    __AF_parse_number12_v0__14_17="$__AF_parse_number12_v0";
    local width="$__AF_parse_number12_v0__14_17"
    __AF_perl_get_cjk_width1761_v0=${width};
    return 0
}
perl_truncate_cjk__1762_v0() {
    local text=$1
    local max_width=$2
    if [ $(echo  '!' ${__46__perl_available} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        __AF_perl_truncate_cjk1762_v0='';
        return 1
fi
    __AMBER_VAL_244=$( perl -CSDA -E '$t=shift;$m=shift;$w=0;$r="";$c=/\p{EastAsianWidth=Wide}|\p{EastAsianWidth=Fullwidth}|\p{EastAsianWidth=Ambiguous}/?2:1,($w+$c<=$m?($w+=$c,$r.=$_):last) for split//,$t; print $r' "${text}" ${max_width} 2>/dev/null );
    __AS=$?;
if [ $__AS != 0 ]; then
__AF_perl_truncate_cjk1762_v0=''
return $__AS
fi;
    local result="${__AMBER_VAL_244}"
    __AF_perl_truncate_cjk1762_v0="${result}";
    return 0
}
# global variables to store terminal size
# (prevent multiple queries in one session)
__47__got_term_size=0
__AMBER_ARRAY_245=(80 24);
__48__term_size=("${__AMBER_ARRAY_245[@]}")
# stty lock/unlock using environment variable for cross-module state
 export XYLITOL_RUNTIME_STTY_COUNT=0 ;
__AS=$?
stty_lock__1769_v0() {
    __AMBER_VAL_246=$( echo "${XYLITOL_RUNTIME_STTY_COUNT:-0}" );
    __AS=$?;
    local count="${__AMBER_VAL_246}"
    parse_number__12_v0 "${count}";
    __AS=$?;
if [ $__AS != 0 ]; then
        echo 0 > /dev/null 2>&1
fi;
    __AF_parse_number12_v0__14_21="$__AF_parse_number12_v0";
    local count_num="$__AF_parse_number12_v0__14_21"
    if [ $(echo ${count_num} '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
         stty -echo < /dev/tty ;
        __AS=$?
fi
    count_num=$(echo ${count_num} '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
     export XYLITOL_RUNTIME_STTY_COUNT=${count_num} ;
    __AS=$?
}
stty_unlock__1770_v0() {
    __AMBER_VAL_247=$( echo "${XYLITOL_RUNTIME_STTY_COUNT:-0}" );
    __AS=$?;
    local count="${__AMBER_VAL_247}"
    parse_number__12_v0 "${count}";
    __AS=$?;
if [ $__AS != 0 ]; then
        echo 0 > /dev/null 2>&1
fi;
    __AF_parse_number12_v0__25_21="$__AF_parse_number12_v0";
    local count_num="$__AF_parse_number12_v0__25_21"
    if [ $(echo ${count_num} '>' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        count_num=$(echo ${count_num} '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
         export XYLITOL_RUNTIME_STTY_COUNT=${count_num} ;
        __AS=$?
        if [ $(echo ${count_num} '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
             stty echo < /dev/tty ;
            __AS=$?
fi
fi
}
get_term_size__1771_v0() {
    # Query terminal size with \x1b[18t, response format: \x1b[8;rows;colst
    __AMBER_VAL_248=$( printf '\x1b[18t' > /dev/tty; IFS=';' read -rsd t _ignore height width < /dev/tty; echo "$height; $width" );
    __AS=$?;
    local result="${__AMBER_VAL_248}"
    split__3_v0 "${result}" ";";
    __AF_split3_v0__39_17=("${__AF_split3_v0[@]}");
    local parts=("${__AF_split3_v0__39_17[@]}")
    if [ $(echo "${#parts[@]}" '!=' 2 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        __AF_get_term_size1771_v0='';
        return 1
fi
    parse_number__12_v0 "${parts[0]}";
    __AS=$?;
if [ $__AS != 0 ]; then
__AF_get_term_size1771_v0=''
return $__AS
fi;
    __AF_parse_number12_v0__43_16="$__AF_parse_number12_v0";
    local rows="$__AF_parse_number12_v0__43_16"
    parse_number__12_v0 "${parts[1]}";
    __AS=$?;
if [ $__AS != 0 ]; then
__AF_get_term_size1771_v0=''
return $__AS
fi;
    __AF_parse_number12_v0__44_16="$__AF_parse_number12_v0";
    local cols="$__AF_parse_number12_v0__44_16"
    __AMBER_ARRAY_249=(${cols} ${rows});
    __48__term_size=("${__AMBER_ARRAY_249[@]}")
    __47__got_term_size=1
}
term_width__1773_v0() {
    if [ $(echo  '!' ${__47__got_term_size} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        get_term_size__1771_v0 ;
        __AS=$?;
        __AF_get_term_size1771_v0__60_15="$__AF_get_term_size1771_v0";
        echo "$__AF_get_term_size1771_v0__60_15" > /dev/null 2>&1
fi
    __AF_term_width1773_v0="${__48__term_size[0]}";
    return 0
}
term_height__1774_v0() {
    if [ $(echo  '!' ${__47__got_term_size} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        get_term_size__1771_v0 ;
        __AS=$?;
        __AF_get_term_size1771_v0__68_15="$__AF_get_term_size1771_v0";
        echo "$__AF_get_term_size1771_v0__68_15" > /dev/null 2>&1
fi
    __AF_term_height1774_v0="${__48__term_size[1]}";
    return 0
}
# A global variable indicating if the terminal supports truecolor.
# "None" or "Yes" or "No"
# 
# This value is only updated by the `get_supports_truecolor` function
# executed by `colored_rgb` on its first call.
__49__supports_truecolor="None"
# A global variable indicating if the Xylitol colors have been loaded from environment variables.
__50__got_xylitol_colors=0
__AMBER_ARRAY_250=(3 207 159 92);
__51__primary_color=("${__AMBER_ARRAY_250[@]}")
__AMBER_ARRAY_251=(3 118 206 94);
__52__secondary_color=("${__AMBER_ARRAY_251[@]}")
__AMBER_ARRAY_252=(234 72 121 95);
__53__accent_color=("${__AMBER_ARRAY_252[@]}")
get_supports_truecolor__1784_v0() {
    env_const_get__89_v0 "XYLITOL_TRUECOLOR";
    __AS=$?;
if [ $__AS != 0 ]; then
        echo "" > /dev/null 2>&1
fi;
    __AF_env_const_get89_v0__20_18="${__AF_env_const_get89_v0}";
    local config="${__AF_env_const_get89_v0__20_18}"
    if [ $([ "_${config}" != "_No" ]; echo $?) != 0 ]; then
        __49__supports_truecolor="No"
        __AF_get_supports_truecolor1784_v0=0;
        return 0
fi
    env_const_get__89_v0 "COLORTERM";
    __AS=$?;
if [ $__AS != 0 ]; then
        __49__supports_truecolor="No"
        __AF_get_supports_truecolor1784_v0=0;
        return 0
fi;
    __AF_env_const_get89_v0__25_21="${__AF_env_const_get89_v0}";
    local colorterm="${__AF_env_const_get89_v0__25_21}"
    __49__supports_truecolor=$(if [ $(echo $([ "_${colorterm}" != "_truecolor" ]; echo $?) '||' $([ "_${colorterm}" != "_24bit" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then echo "Yes"; else echo "No"; fi)
    __AF_get_supports_truecolor1784_v0=$([ "_${__49__supports_truecolor}" != "_Yes" ]; echo $?);
    return 0
}
colored_rgb__1785_v0() {
    local message=$1
    local r=$2
    local g=$3
    local b=$4
    local fallback=$5
    if [ $([ "_${__49__supports_truecolor}" != "_Yes" ]; echo $?) != 0 ]; then
                    __AF_colored_rgb1785_v0="\x1b[38;2;${r};${g};${b}m""${message}""\x1b[0m";
            return 0
elif [ $([ "_${__49__supports_truecolor}" != "_None" ]; echo $?) != 0 ]; then
                    get_supports_truecolor__1784_v0 ;
            __AF_get_supports_truecolor1784_v0__50_17="$__AF_get_supports_truecolor1784_v0";
            if [ "$__AF_get_supports_truecolor1784_v0__50_17" != 0 ]; then
                                    __AF_colored_rgb1785_v0="\x1b[38;2;${r};${g};${b}m""${message}""\x1b[0m";
                    return 0
elif [ $(echo ${fallback} '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                __AF_colored_rgb1785_v0="${message}";
                return 0
else
                __AF_colored_rgb1785_v0="\x1b[${fallback}m""${message}""\x1b[0m";
                return 0
fi
else
        if [ $(echo ${fallback} '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            __AF_colored_rgb1785_v0="${message}";
            return 0
fi
        __AF_colored_rgb1785_v0="\x1b[${fallback}m""${message}""\x1b[0m";
        return 0
fi
}
inner_get_xylitol_colors__1787_v0() {
    if [ $(echo  '!' ${__50__got_xylitol_colors} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        env_const_get__89_v0 "XYLITOL_PRIMARY_COLOR";
        __AS=$?;
if [ $__AS != 0 ]; then
            echo "" > /dev/null 2>&1
fi;
        __AF_env_const_get89_v0__110_27="${__AF_env_const_get89_v0}";
        local primary_env="${__AF_env_const_get89_v0__110_27}"
        if [ $([ "_${primary_env}" == "_" ]; echo $?) != 0 ]; then
            split__3_v0 "${primary_env}" ";";
            __AF_split3_v0__112_25=("${__AF_split3_v0[@]}");
            local parts=("${__AF_split3_v0__112_25[@]}")
            if [ $(echo "${#parts[@]}" '==' 4 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                parse_number__12_v0 "${parts[0]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors1787_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__115_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[1]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors1787_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__116_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[2]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors1787_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__117_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[3]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors1787_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__118_21="$__AF_parse_number12_v0";
                __AMBER_ARRAY_253=("$__AF_parse_number12_v0__115_21" "$__AF_parse_number12_v0__116_21" "$__AF_parse_number12_v0__117_21" "$__AF_parse_number12_v0__118_21");
                __51__primary_color=("${__AMBER_ARRAY_253[@]}")
fi
fi
        env_const_get__89_v0 "XYLITOL_SECONDARY_COLOR";
        __AS=$?;
if [ $__AS != 0 ]; then
            echo "" > /dev/null 2>&1
fi;
        __AF_env_const_get89_v0__123_29="${__AF_env_const_get89_v0}";
        local secondary_env="${__AF_env_const_get89_v0__123_29}"
        if [ $([ "_${secondary_env}" == "_" ]; echo $?) != 0 ]; then
            split__3_v0 "${secondary_env}" ";";
            __AF_split3_v0__125_25=("${__AF_split3_v0[@]}");
            local parts=("${__AF_split3_v0__125_25[@]}")
            if [ $(echo "${#parts[@]}" '==' 4 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                parse_number__12_v0 "${parts[0]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors1787_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__128_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[1]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors1787_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__129_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[2]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors1787_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__130_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[3]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors1787_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__131_21="$__AF_parse_number12_v0";
                __AMBER_ARRAY_254=("$__AF_parse_number12_v0__128_21" "$__AF_parse_number12_v0__129_21" "$__AF_parse_number12_v0__130_21" "$__AF_parse_number12_v0__131_21");
                __52__secondary_color=("${__AMBER_ARRAY_254[@]}")
fi
fi
        env_const_get__89_v0 "XYLITOL_ACCENT_COLOR";
        __AS=$?;
if [ $__AS != 0 ]; then
            echo "" > /dev/null 2>&1
fi;
        __AF_env_const_get89_v0__136_26="${__AF_env_const_get89_v0}";
        local accent_env="${__AF_env_const_get89_v0__136_26}"
        if [ $([ "_${accent_env}" == "_" ]; echo $?) != 0 ]; then
            split__3_v0 "${accent_env}" ";";
            __AF_split3_v0__138_25=("${__AF_split3_v0[@]}");
            local parts=("${__AF_split3_v0__138_25[@]}")
            if [ $(echo "${#parts[@]}" '==' 4 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                parse_number__12_v0 "${parts[0]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors1787_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__141_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[1]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors1787_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__142_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[2]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors1787_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__143_21="$__AF_parse_number12_v0";
                parse_number__12_v0 "${parts[3]}";
                __AS=$?;
if [ $__AS != 0 ]; then
__AF_inner_get_xylitol_colors1787_v0=''
return $__AS
fi;
                __AF_parse_number12_v0__144_21="$__AF_parse_number12_v0";
                __AMBER_ARRAY_255=("$__AF_parse_number12_v0__141_21" "$__AF_parse_number12_v0__142_21" "$__AF_parse_number12_v0__143_21" "$__AF_parse_number12_v0__144_21");
                __53__accent_color=("${__AMBER_ARRAY_255[@]}")
fi
fi
        __50__got_xylitol_colors=1
fi
}
get_xylitol_colors__1788_v0() {
    inner_get_xylitol_colors__1787_v0 ;
    __AS=$?;
if [ $__AS != 0 ]; then
        echo_colored__105_v0 "WARN: Failed to parse Xylitol colors from envs." 33;
        __AF_echo_colored105_v0__155_9="$__AF_echo_colored105_v0";
        echo "$__AF_echo_colored105_v0__155_9" > /dev/null 2>&1
fi;
    __AF_inner_get_xylitol_colors1787_v0__154_5="$__AF_inner_get_xylitol_colors1787_v0";
    echo "$__AF_inner_get_xylitol_colors1787_v0__154_5" > /dev/null 2>&1
    __50__got_xylitol_colors=1
}
colored_secondary__1790_v0() {
    local message=$1
    if [ $(echo  '!' ${__50__got_xylitol_colors} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        get_xylitol_colors__1788_v0 ;
        __AF_get_xylitol_colors1788_v0__169_9="$__AF_get_xylitol_colors1788_v0";
        echo "$__AF_get_xylitol_colors1788_v0__169_9" > /dev/null 2>&1
fi
    colored_rgb__1785_v0 "${message}" "${__52__secondary_color[0]}" "${__52__secondary_color[1]}" "${__52__secondary_color[2]}" "${__52__secondary_color[3]}";
    __AF_colored_rgb1785_v0__171_12="${__AF_colored_rgb1785_v0}";
    __AF_colored_secondary1790_v0="${__AF_colored_rgb1785_v0__171_12}";
    return 0
}
# // IO Functions /////
get_key__1805_v0() {
    __AMBER_VAL_256=$( read -rsn1 k < /dev/tty; if [[ "$k" == $'\e' ]]; then read -rsn2 r < /dev/tty; k+=$r; fi; printf '%q' "$k" );
    __AS=$?;
    local var="${__AMBER_VAL_256}"
    if [ $([ "_${var}" != "_\$'\E[A'" ]; echo $?) != 0 ]; then
        __AF_get_key1805_v0="UP";
        return 0
elif [ $([ "_${var}" != "_\$'\E[B'" ]; echo $?) != 0 ]; then
        __AF_get_key1805_v0="DOWN";
        return 0
elif [ $([ "_${var}" != "_\$'\E[C'" ]; echo $?) != 0 ]; then
        __AF_get_key1805_v0="RIGHT";
        return 0
elif [ $([ "_${var}" != "_\$'\E[D'" ]; echo $?) != 0 ]; then
        __AF_get_key1805_v0="LEFT";
        return 0
elif [ $([ "_${var}" != "_\$'\177'" ]; echo $?) != 0 ]; then
        __AF_get_key1805_v0="BACKSPACE";
        return 0
elif [ $([ "_${var}" != "_''" ]; echo $?) != 0 ]; then
        __AF_get_key1805_v0="INPUT";
        return 0
else
        __AF_get_key1805_v0="${var}";
        return 0
fi
}
eprintf__1807_v0() {
    local format=$1
    local args=("${!2}")
     args=("${format}" "${args[@]}") ;
    __AS=$?
     printf "${args[@]}" >&2 ;
    __AS=$?
}
eprintf_colored__1808_v0() {
    local message=$1
    local color=$2
    # Prints an error message with a specified color.
    __AMBER_ARRAY_257=("${message}");
    eprintf__1807_v0 "\x1b[${color}m%s\x1b[0m" __AMBER_ARRAY_257[@];
    __AF_eprintf1807_v0__42_5="$__AF_eprintf1807_v0";
    echo "$__AF_eprintf1807_v0__42_5" > /dev/null 2>&1
}
colored__1809_v0() {
    local message=$1
    local color=$2
    # Returns a text wrapped in color codes.
    __AF_colored1809_v0="\x1b[${color}m""${message}""\x1b[0m";
    return 0
}
remove_line__1811_v0() {
    local cnt=$1
     printf '\x1b[2K\x1b[1A%.0s' $(seq ${cnt}) >&2 ;
    __AS=$?
    __AMBER_ARRAY_258=("");
    eprintf__1807_v0 "\x1b[9999D" __AMBER_ARRAY_258[@];
    __AF_eprintf1807_v0__58_5="$__AF_eprintf1807_v0";
    echo "$__AF_eprintf1807_v0__58_5" > /dev/null 2>&1
}
remove_current_line__1812_v0() {
    __AMBER_ARRAY_259=("");
    eprintf__1807_v0 "\x1b[2K\x1b[9999D" __AMBER_ARRAY_259[@];
    __AF_eprintf1807_v0__63_5="$__AF_eprintf1807_v0";
    echo "$__AF_eprintf1807_v0__63_5" > /dev/null 2>&1
}
print_blank__1813_v0() {
    local cnt=$1
     printf '%*s' "${cnt}" ' ' >&2 ;
    __AS=$?
}
new_line__1814_v0() {
    local cnt=$1
    for i in $(seq 0 $(echo ${cnt} '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')); do
        __AMBER_ARRAY_260=("");
        eprintf__1807_v0 "
" __AMBER_ARRAY_260[@];
        __AF_eprintf1807_v0__75_9="$__AF_eprintf1807_v0";
        echo "$__AF_eprintf1807_v0__75_9" > /dev/null 2>&1
done
}
go_up__1815_v0() {
    local cnt=$1
    __AMBER_ARRAY_261=("");
    eprintf__1807_v0 "\x1b[${cnt}A" __AMBER_ARRAY_261[@];
    __AF_eprintf1807_v0__81_5="$__AF_eprintf1807_v0";
    echo "$__AF_eprintf1807_v0__81_5" > /dev/null 2>&1
}
go_down__1816_v0() {
    local cnt=$1
    __AMBER_ARRAY_262=("");
    eprintf__1807_v0 "\x1b[${cnt}B" __AMBER_ARRAY_262[@];
    __AF_eprintf1807_v0__86_5="$__AF_eprintf1807_v0";
    echo "$__AF_eprintf1807_v0__86_5" > /dev/null 2>&1
}
# move the cursor up or down `cnt` lines.
go_up_or_down__1817_v0() {
    local cnt=$1
    if [ $(echo ${cnt} '>' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        go_down__1816_v0 ${cnt};
        __AF_go_down1816_v0__92_9="$__AF_go_down1816_v0";
        echo "$__AF_go_down1816_v0__92_9" > /dev/null 2>&1
else
        go_up__1815_v0 $(echo  '-' ${cnt} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
        __AF_go_up1815_v0__94_9="$__AF_go_up1815_v0";
        echo "$__AF_go_up1815_v0__94_9" > /dev/null 2>&1
fi
}
hide_cursor__1818_v0() {
    __AMBER_ARRAY_263=("");
    eprintf__1807_v0 "\x1b[?25l" __AMBER_ARRAY_263[@];
    __AF_eprintf1807_v0__99_5="$__AF_eprintf1807_v0";
    echo "$__AF_eprintf1807_v0__99_5" > /dev/null 2>&1
}
show_cursor__1819_v0() {
    __AMBER_ARRAY_264=("");
    eprintf__1807_v0 "\x1b[?25h" __AMBER_ARRAY_264[@];
    __AF_eprintf1807_v0__103_5="$__AF_eprintf1807_v0";
    echo "$__AF_eprintf1807_v0__103_5" > /dev/null 2>&1
}
# / Text Utilities /////
has_ansi_escape__1820_v0() {
    local text=$1
    # Check for ESC character (0x1B = 27) or literal \x1b[
    __AMBER_VAL_265=$( [[ "${text}" == *$'\x1b'* || "${text}" == *'\x1b['* ]] && echo "1" || echo "0" );
    __AS=$?;
    local has_escape="${__AMBER_VAL_265}"
    __AF_has_ansi_escape1820_v0=$([ "_${has_escape}" != "_1" ]; echo $?);
    return 0
}
strip_ansi__1822_v0() {
    local text=$1
    __AMBER_VAL_266=$( printf "%s" "${text}" | sed $'s/\x1b\[[0-9;]*m//g' | sed 's/\\x1b\[[0-9;]*m//g' );
    __AS=$?;
    __AF_strip_ansi1822_v0="${__AMBER_VAL_266}";
    return 0
}
is_all_ascii__1823_v0() {
    local text=$1
    __AMBER_VAL_267=$( printf "%s" "${text}" | LC_ALL=C grep -q '^[ -~]*$' && echo 0 || echo 1 );
    __AS=$?;
    local result="${__AMBER_VAL_267}"
    __AF_is_all_ascii1823_v0=$([ "_${result}" != "_0" ]; echo $?);
    return 0
}
get_visible_len__1824_v0() {
    local text=$1
    strip_ansi__1822_v0 "${text}";
    __AF_strip_ansi1822_v0__138_20="${__AF_strip_ansi1822_v0}";
    local stripped="${__AF_strip_ansi1822_v0__138_20}"
    # Check if text is all ASCII
    is_all_ascii__1823_v0 "${stripped}";
    __AF_is_all_ascii1823_v0__140_12="$__AF_is_all_ascii1823_v0";
    if [ $(echo  '!' "$__AF_is_all_ascii1823_v0__140_12" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        # Try using perl
        perl_get_cjk_width__1761_v0 "${stripped}";
        __AS=$?;
if [ $__AS != 0 ]; then
            __AMBER_LEN="${stripped}";
            __AF_get_visible_len1824_v0="${#__AMBER_LEN}";
            return 0
fi;
        __AF_perl_get_cjk_width1761_v0__142_16="$__AF_perl_get_cjk_width1761_v0";
        __AF_get_visible_len1824_v0="$__AF_perl_get_cjk_width1761_v0__142_16";
        return 0
else
        __AMBER_LEN="${stripped}";
        __AF_get_visible_len1824_v0="${#__AMBER_LEN}";
        return 0
fi
}
truncate_text__1825_v0() {
    local text=$1
    local max_width=$2
    get_visible_len__1824_v0 "${text}";
    __AF_get_visible_len1824_v0__153_23="$__AF_get_visible_len1824_v0";
    local visible_len="$__AF_get_visible_len1824_v0__153_23"
    if [ $(echo ${visible_len} '<=' ${max_width} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        __AF_truncate_text1825_v0="${text}";
        return 0
fi
    is_all_ascii__1823_v0 "${text}";
    __AF_is_all_ascii1823_v0__157_12="$__AF_is_all_ascii1823_v0";
    if [ $(echo  '!' "$__AF_is_all_ascii1823_v0__157_12" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        perl_truncate_cjk__1762_v0 "${text}" ${max_width};
        __AS=$?;
if [ $__AS != 0 ]; then
             printf "%s" "${text}" | cut -c1-${max_width} ;
            __AS=$?
fi;
        __AF_perl_truncate_cjk1762_v0__158_16="${__AF_perl_truncate_cjk1762_v0}";
        __AF_truncate_text1825_v0="${__AF_perl_truncate_cjk1762_v0__158_16}";
        return 0
fi
    __AMBER_VAL_268=$( printf "%s" "${text}" | cut -c1-${max_width} );
    __AS=$?;
    __AF_truncate_text1825_v0="${__AMBER_VAL_268}";
    return 0
}
truncate_ansi__1826_v0() {
    local text=$1
    local max_width=$2
    has_ansi_escape__1820_v0 "${text}";
    __AF_has_ansi_escape1820_v0__169_12="$__AF_has_ansi_escape1820_v0";
    if [ $(echo  '!' "$__AF_has_ansi_escape1820_v0__169_12" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        truncate_text__1825_v0 "${text}" ${max_width};
        __AF_truncate_text1825_v0__170_16="${__AF_truncate_text1825_v0}";
        __AF_truncate_ansi1826_v0="${__AF_truncate_text1825_v0__170_16}";
        return 0
fi
    # Check if text starts with \x1b[
    __AMBER_VAL_269=$( [[ "${text}" == '\x1b['* ]] && echo "1" || echo "0" );
    __AS=$?;
    local starts_with_ansi="${__AMBER_VAL_269}"
    # Replace \x1b[ with newline, then split
    __AMBER_VAL_270=$( t="${text}"; printf '%s' "${t//\\x1b[/
}" );
    __AS=$?;
    local replaced="${__AMBER_VAL_270}"
    split__3_v0 "${replaced}" "
";
    __AF_split3_v0__179_17=("${__AF_split3_v0[@]}");
    local parts=("${__AF_split3_v0__179_17[@]}")
    local result=""
    local remaining_width=${max_width}
    for idx in $(seq 0 $(echo "${#parts[@]}" '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')); do
        local part="${parts[${idx}]}"
        # If text starts with ANSI, all parts are "ANSIparams m text" format
        # If not, first part is pure text
        if [ $(echo $(echo ${idx} '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '&&' $([ "_${starts_with_ansi}" != "_0" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            # First part is pure text (before any ANSI)
            if [ $(echo $([ "_${part}" == "_" ]; echo $?) '&&' $(echo ${remaining_width} '>' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                truncate_text__1825_v0 "${part}" ${remaining_width};
                __AF_truncate_text1825_v0__191_33="${__AF_truncate_text1825_v0}";
                local truncated="${__AF_truncate_text1825_v0__191_33}"
                result+="${truncated}"
                get_visible_len__1824_v0 "${truncated}";
                __AF_get_visible_len1824_v0__193_36="$__AF_get_visible_len1824_v0";
                remaining_width=$(echo ${remaining_width} '-' "$__AF_get_visible_len1824_v0__193_36" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
fi
else
            # Part is "ANSIparams m text" format - find first 'm'
            __AMBER_VAL_271=$( __p="${part}"; for ((i=0; i<${#__p}; i++)); do [[ "${__p:$i:1}" == "m" ]] && echo $i && break; done );
            __AS=$?;
            local m_idx="${__AMBER_VAL_271}"
            if [ $([ "_${m_idx}" == "_" ]; echo $?) != 0 ]; then
                # Reconstruct ANSI sequence
                __AMBER_VAL_272=$( __p="${part}"; printf "%s" "${__p:0:${m_idx}}" );
                __AS=$?;
                local ansi_params="${__AMBER_VAL_272}"
                result+="\\x1b[""${ansi_params}""m"
                # Rest is text content
                parse_number__12_v0 "${m_idx}";
                __AS=$?;
                __AF_parse_number12_v0__204_39="$__AF_parse_number12_v0";
                local m_idx_num="$__AF_parse_number12_v0__204_39"
                local text_start=$(echo ${m_idx_num} '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
                __AMBER_VAL_273=$( __p="${part}"; printf "%s" "${__p:${text_start}}" );
                __AS=$?;
                local text_part="${__AMBER_VAL_273}"
                if [ $(echo $([ "_${text_part}" == "_" ]; echo $?) '&&' $(echo ${remaining_width} '>' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                    truncate_text__1825_v0 "${text_part}" ${remaining_width};
                    __AF_truncate_text1825_v0__208_37="${__AF_truncate_text1825_v0}";
                    local truncated="${__AF_truncate_text1825_v0__208_37}"
                    result+="${truncated}"
                    get_visible_len__1824_v0 "${truncated}";
                    __AF_get_visible_len1824_v0__210_40="$__AF_get_visible_len1824_v0";
                    remaining_width=$(echo ${remaining_width} '-' "$__AF_get_visible_len1824_v0__210_40" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
fi
else
                # No 'm' found, treat as text
                if [ $(echo $([ "_${part}" == "_" ]; echo $?) '&&' $(echo ${remaining_width} '>' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                    truncate_text__1825_v0 "${part}" ${remaining_width};
                    __AF_truncate_text1825_v0__215_37="${__AF_truncate_text1825_v0}";
                    local truncated="${__AF_truncate_text1825_v0__215_37}"
                    result+="${truncated}"
                    get_visible_len__1824_v0 "${truncated}";
                    __AF_get_visible_len1824_v0__217_40="$__AF_get_visible_len1824_v0";
                    remaining_width=$(echo ${remaining_width} '-' "$__AF_get_visible_len1824_v0__217_40" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
fi
fi
fi
done
    __AF_truncate_ansi1826_v0="${result}";
    return 0
}
cutoff_text__1827_v0() {
    local text=$1
    local max_width=$2
    get_visible_len__1824_v0 "${text}";
    __AF_get_visible_len1824_v0__229_23="$__AF_get_visible_len1824_v0";
    local visible_len="$__AF_get_visible_len1824_v0__229_23"
    if [ $(echo ${visible_len} '<=' ${max_width} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        __AF_cutoff_text1827_v0="${text}";
        return 0
fi
    truncate_ansi__1826_v0 "${text}" $(echo ${max_width} '-' 3 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
    __AF_truncate_ansi1826_v0__233_12="${__AF_truncate_ansi1826_v0}";
    __AF_cutoff_text1827_v0="${__AF_truncate_ansi1826_v0__233_12}""...";
    return 0
}
# // Application Utilities /////
render_tooltip__1828_v0() {
    local items=("${!1}")
    local total_len=$2
    local term_width=$3
    local separator=" • "
    local separator_len=3
    # Fast path: no truncation needed
    if [ $(echo ${total_len} '<=' ${term_width} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        local iter=0
        while :
do
            if [ $(echo ${iter} '>=' "${#items[@]}" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                break
elif [ $(echo ${iter} '>' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                eprintf_colored__1808_v0 "${separator}" 90;
                __AF_eprintf_colored1808_v0__256_27="$__AF_eprintf_colored1808_v0";
                echo "$__AF_eprintf_colored1808_v0__256_27" > /dev/null 2>&1
fi
            colored__1809_v0 "${items[$(echo ${iter} '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')]}" 2;
            __AF_colored1809_v0__258_41="${__AF_colored1809_v0}";
            __AMBER_ARRAY_274=("");
            eprintf__1807_v0 "${items[${iter}]}"" ""${__AF_colored1809_v0__258_41}" __AMBER_ARRAY_274[@];
            __AF_eprintf1807_v0__258_13="$__AF_eprintf1807_v0";
            echo "$__AF_eprintf1807_v0__258_13" > /dev/null 2>&1
            iter=$(echo ${iter} '+' 2 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
done
else
        # Slow path: truncate
        local current_len=0
        local first=1
        local iter=0
        while :
do
            if [ $(echo ${iter} '>=' "${#items[@]}" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                break
fi
            local key="${items[${iter}]}"
            local action="${items[$(echo ${iter} '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')]}"
            __AMBER_LEN="${key}";
            __AMBER_LEN="${action}";
            local part_len=$(echo $(echo "${#__AMBER_LEN}" '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '+' "${#__AMBER_LEN}" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
            local needed=${part_len}
            if [ $(echo  '!' ${first} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                needed=$(echo ${needed} '+' ${separator_len} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
fi
            if [ $(echo $(echo ${current_len} '+' ${needed} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '>' ${term_width} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                break
fi
            if [ $(echo  '!' ${first} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                eprintf_colored__1808_v0 "${separator}" 90;
                __AF_eprintf_colored1808_v0__284_17="$__AF_eprintf_colored1808_v0";
                echo "$__AF_eprintf_colored1808_v0__284_17" > /dev/null 2>&1
fi
            colored__1809_v0 "${action}" 2;
            __AF_colored1809_v0__286_33="${__AF_colored1809_v0}";
            __AMBER_ARRAY_275=("");
            eprintf__1807_v0 "${key}"" ""${__AF_colored1809_v0__286_33}" __AMBER_ARRAY_275[@];
            __AF_eprintf1807_v0__286_13="$__AF_eprintf1807_v0";
            echo "$__AF_eprintf1807_v0__286_13" > /dev/null 2>&1
            current_len=$(echo ${current_len} '+' ${needed} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
            first=0
            iter=$(echo ${iter} '+' 2 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
done
fi
}
get_page_options__1878_v0() {
    local options=("${!1}")
    local page=$2
    local page_size=$3
    local start=$(echo ${page} '*' ${page_size} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
    local end=$(echo ${start} '+' ${page_size} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
    if [ $(echo ${end} '>' "${#options[@]}" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        end="${#options[@]}"
fi
    __AMBER_ARRAY_276=();
    local result=("${__AMBER_ARRAY_276[@]}")
    for i in $(seq ${start} $(echo ${end} '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')); do
        __AMBER_ARRAY_277=("${options[${i}]}");
        result+=("${__AMBER_ARRAY_277[@]}")
done
    __AF_get_page_options1878_v0=("${result[@]}");
    return 0
}
render_choose_page__1880_v0() {
    local page_options=("${!1}")
    local sel=$2
    local cursor=$3
    local display_count=$4
    local term_width=$5
    __AMBER_LEN="${cursor}";
    local cursor_len="${#__AMBER_LEN}"
    local max_option_width=$(echo $(echo ${term_width} '-' ${cursor_len} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
    for i in $(seq 0 $(echo "${#page_options[@]}" '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')); do
        cutoff_text__1827_v0 "${page_options[${i}]}" ${max_option_width};
        __AF_cutoff_text1827_v0__26_32="${__AF_cutoff_text1827_v0}";
        local truncated_option="${__AF_cutoff_text1827_v0__26_32}"
        if [ $(echo ${i} '==' ${sel} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            colored_secondary__1790_v0 "${cursor}""${truncated_option}""
";
            __AF_colored_secondary1790_v0__28_21="${__AF_colored_secondary1790_v0}";
            __AMBER_ARRAY_278=("");
            eprintf__1807_v0 "${__AF_colored_secondary1790_v0__28_21}" __AMBER_ARRAY_278[@];
            __AF_eprintf1807_v0__28_13="$__AF_eprintf1807_v0";
            echo "$__AF_eprintf1807_v0__28_13" > /dev/null 2>&1
else
            print_blank__1813_v0 ${cursor_len};
            __AF_print_blank1813_v0__30_13="$__AF_print_blank1813_v0";
            echo "$__AF_print_blank1813_v0__30_13" > /dev/null 2>&1
            __AMBER_ARRAY_279=("");
            eprintf__1807_v0 "${truncated_option}""
" __AMBER_ARRAY_279[@];
            __AF_eprintf1807_v0__31_13="$__AF_eprintf1807_v0";
            echo "$__AF_eprintf1807_v0__31_13" > /dev/null 2>&1
fi
done
    local remaining_slots=$(echo ${display_count} '-' "${#page_options[@]}" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
    if [ $(echo ${remaining_slots} '>' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        # Amber bug gaurd
        for _ in $(seq 0 $(echo ${remaining_slots} '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')); do
            __AMBER_ARRAY_280=("");
            eprintf__1807_v0 "\x1b[K
" __AMBER_ARRAY_280[@];
            __AF_eprintf1807_v0__37_13="$__AF_eprintf1807_v0";
            echo "$__AF_eprintf1807_v0__37_13" > /dev/null 2>&1
done
fi
}
render_page_indicator__1882_v0() {
    local page=$1
    local total_pages=$2
    if [ $(echo ${total_pages} '>' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        __AMBER_ARRAY_281=("");
        eprintf__1807_v0 "\x1b[9999D\x1b[K" __AMBER_ARRAY_281[@];
        __AF_eprintf1807_v0__72_9="$__AF_eprintf1807_v0";
        echo "$__AF_eprintf1807_v0__72_9" > /dev/null 2>&1
        eprintf_colored__1808_v0 "Page $(echo ${page} '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')/${total_pages}" 90;
        __AF_eprintf_colored1808_v0__73_9="$__AF_eprintf_colored1808_v0";
        echo "$__AF_eprintf_colored1808_v0__73_9" > /dev/null 2>&1
        __AMBER_ARRAY_282=("");
        eprintf__1807_v0 "\x1b[9999D" __AMBER_ARRAY_282[@];
        __AF_eprintf1807_v0__74_9="$__AF_eprintf1807_v0";
        echo "$__AF_eprintf1807_v0__74_9" > /dev/null 2>&1
fi
}
xyl_choose__1883_v0() {
    local options=("${!1}")
    local cursor=$2
    local header=$3
    local page_size=$4
    if [ $(echo "${#options[@]}" '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        eprintf_colored__1808_v0 "ERROR: No options provided.
" 31;
        __AF_eprintf_colored1808_v0__92_9="$__AF_eprintf_colored1808_v0";
        echo "$__AF_eprintf_colored1808_v0__92_9" > /dev/null 2>&1
        exit 1
fi
    stty_lock__1769_v0 ;
    __AF_stty_lock1769_v0__96_5="$__AF_stty_lock1769_v0";
    echo "$__AF_stty_lock1769_v0__96_5" > /dev/null 2>&1
    hide_cursor__1818_v0 ;
    __AF_hide_cursor1818_v0__97_5="$__AF_hide_cursor1818_v0";
    echo "$__AF_hide_cursor1818_v0__97_5" > /dev/null 2>&1
    term_width__1773_v0 ;
    __AF_term_width1773_v0__99_22="$__AF_term_width1773_v0";
    local term_width="$__AF_term_width1773_v0__99_22"
    term_height__1774_v0 ;
    __AF_term_height1774_v0__100_23="$__AF_term_height1774_v0";
    local term_height="$__AF_term_height1774_v0__100_23"
    local max_page_size=$(echo ${term_height} '-' $(if [ $([ "_${header}" != "_" ]; echo $?) != 0 ]; then echo 2; else echo 3; fi) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
    if [ $(echo ${page_size} '>' ${max_page_size} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        page_size=${max_page_size}
fi
    if [ $([ "_${header}" == "_" ]; echo $?) != 0 ]; then
        cutoff_text__1827_v0 "${header}" ${term_width};
        __AF_cutoff_text1827_v0__107_17="${__AF_cutoff_text1827_v0}";
        __AMBER_ARRAY_283=("");
        eprintf__1807_v0 "${__AF_cutoff_text1827_v0__107_17}""
" __AMBER_ARRAY_283[@];
        __AF_eprintf1807_v0__107_9="$__AF_eprintf1807_v0";
        echo "$__AF_eprintf1807_v0__107_9" > /dev/null 2>&1
fi
    math_floor__406_v0 $(echo $(echo $(echo "${#options[@]}" '+' ${page_size} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '/' ${page_size} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
    __AF_math_floor406_v0__110_23="$__AF_math_floor406_v0";
    local total_pages="$__AF_math_floor406_v0__110_23"
    local current_page=0
    local selected=0
    local display_count=${page_size}
    if [ $(echo "${#options[@]}" '<' ${page_size} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        display_count="${#options[@]}"
fi
    new_line__1814_v0 ${display_count};
    __AF_new_line1814_v0__119_5="$__AF_new_line1814_v0";
    echo "$__AF_new_line1814_v0__119_5" > /dev/null 2>&1
    __AMBER_ARRAY_284=("");
    eprintf__1807_v0 "\x1b[9999D" __AMBER_ARRAY_284[@];
    __AF_eprintf1807_v0__120_5="$__AF_eprintf1807_v0";
    echo "$__AF_eprintf1807_v0__120_5" > /dev/null 2>&1
    if [ $(echo ${total_pages} '>' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        eprintf_colored__1808_v0 "Page $(echo ${current_page} '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')/${total_pages}" 90;
        __AF_eprintf_colored1808_v0__122_9="$__AF_eprintf_colored1808_v0";
        echo "$__AF_eprintf_colored1808_v0__122_9" > /dev/null 2>&1
fi
    new_line__1814_v0 1;
    __AF_new_line1814_v0__124_5="$__AF_new_line1814_v0";
    echo "$__AF_new_line1814_v0__124_5" > /dev/null 2>&1
    # "↑↓ select • enter confirm" = 9 + 3 + 13 = 25
    # "↑↓ select • ←→ page • enter confirm" = 9 + 3 + 8 + 3 + 13 = 36
    if [ $(echo ${total_pages} '>' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        __AMBER_ARRAY_285=("↑↓" "select" "←→" "page" "enter" "confirm");
        render_tooltip__1828_v0 __AMBER_ARRAY_285[@] 36 ${term_width};
        __AF_render_tooltip1828_v0__129_9="$__AF_render_tooltip1828_v0";
        echo "$__AF_render_tooltip1828_v0__129_9" > /dev/null 2>&1
else
        __AMBER_ARRAY_286=("↑↓" "select" "enter" "confirm");
        render_tooltip__1828_v0 __AMBER_ARRAY_286[@] 25 ${term_width};
        __AF_render_tooltip1828_v0__131_9="$__AF_render_tooltip1828_v0";
        echo "$__AF_render_tooltip1828_v0__131_9" > /dev/null 2>&1
fi
    go_up__1815_v0 $(echo ${display_count} '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
    __AF_go_up1815_v0__133_5="$__AF_go_up1815_v0";
    echo "$__AF_go_up1815_v0__133_5" > /dev/null 2>&1
    __AMBER_ARRAY_287=("");
    eprintf__1807_v0 "\x1b[9999D" __AMBER_ARRAY_287[@];
    __AF_eprintf1807_v0__134_5="$__AF_eprintf1807_v0";
    echo "$__AF_eprintf1807_v0__134_5" > /dev/null 2>&1
    get_page_options__1878_v0 options[@] ${current_page} ${page_size};
    __AF_get_page_options1878_v0__136_24=("${__AF_get_page_options1878_v0[@]}");
    local page_options=("${__AF_get_page_options1878_v0__136_24[@]}")
    render_choose_page__1880_v0 page_options[@] ${selected} "${cursor}" ${display_count} ${term_width};
    __AF_render_choose_page1880_v0__137_5="$__AF_render_choose_page1880_v0";
    echo "$__AF_render_choose_page1880_v0__137_5" > /dev/null 2>&1
    while :
do
        get_key__1805_v0 ;
        __AF_get_key1805_v0__140_19="${__AF_get_key1805_v0}";
        local key="${__AF_get_key1805_v0__140_19}"
        local prev_selected=${selected}
        local prev_page=${current_page}
        local up_paged=0
        if [ $(echo $([ "_${key}" != "_UP" ]; echo $?) '||' $([ "_${key}" != "_k" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            if [ $(echo $(echo ${selected} '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '&&' $(echo ${total_pages} '>' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                if [ $(echo ${current_page} '>' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                    current_page=$(echo ${current_page} '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
else
                    current_page=$(echo ${total_pages} '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
fi
                up_paged=1
elif [ $(echo ${selected} '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                selected=$(echo "${#page_options[@]}" '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
else
                selected=$(echo ${selected} '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
fi
elif [ $(echo $([ "_${key}" != "_DOWN" ]; echo $?) '||' $([ "_${key}" != "_j" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            if [ $(echo ${selected} '==' $(echo "${#page_options[@]}" '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                if [ $(echo ${current_page} '<' $(echo ${total_pages} '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                    current_page=$(echo ${current_page} '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
                    selected=0
else
                    current_page=0
                    selected=0
fi
else
                selected=$(echo ${selected} '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
fi
elif [ $(echo $([ "_${key}" != "_LEFT" ]; echo $?) '||' $([ "_${key}" != "_h" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            if [ $(echo ${current_page} '>' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                current_page=$(echo ${current_page} '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
                selected=0
else
                selected=0
fi
elif [ $(echo $([ "_${key}" != "_RIGHT" ]; echo $?) '||' $([ "_${key}" != "_l" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            if [ $(echo ${current_page} '<' $(echo ${total_pages} '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                current_page=$(echo ${current_page} '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
                selected=0
else
                selected=$(echo "${#page_options[@]}" '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
fi
elif [ $([ "_${key}" != "_INPUT" ]; echo $?) != 0 ]; then
            break
else
            continue
fi
        __AMBER_LEN="${cursor}";
        local max_option_width=$(echo $(echo ${term_width} '-' "${#__AMBER_LEN}" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
        if [ $(echo ${prev_page} '!=' ${current_page} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            get_page_options__1878_v0 options[@] ${current_page} ${page_size};
            __AF_get_page_options1878_v0__203_32=("${__AF_get_page_options1878_v0[@]}");
            page_options=("${__AF_get_page_options1878_v0__203_32[@]}")
            if [ ${up_paged} != 0 ]; then
                selected=$(echo "${#page_options[@]}" '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
fi
            go_up__1815_v0 1;
            __AF_go_up1815_v0__207_17="$__AF_go_up1815_v0";
            echo "$__AF_go_up1815_v0__207_17" > /dev/null 2>&1
            remove_line__1811_v0 $(echo ${display_count} '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
            __AF_remove_line1811_v0__208_17="$__AF_remove_line1811_v0";
            echo "$__AF_remove_line1811_v0__208_17" > /dev/null 2>&1
            remove_current_line__1812_v0 ;
            __AF_remove_current_line1812_v0__209_17="$__AF_remove_current_line1812_v0";
            echo "$__AF_remove_current_line1812_v0__209_17" > /dev/null 2>&1
            __AMBER_ARRAY_288=("");
            eprintf__1807_v0 "\x1b[9999D" __AMBER_ARRAY_288[@];
            __AF_eprintf1807_v0__210_17="$__AF_eprintf1807_v0";
            echo "$__AF_eprintf1807_v0__210_17" > /dev/null 2>&1
            render_choose_page__1880_v0 page_options[@] ${selected} "${cursor}" ${display_count} ${term_width};
            __AF_render_choose_page1880_v0__211_17="$__AF_render_choose_page1880_v0";
            echo "$__AF_render_choose_page1880_v0__211_17" > /dev/null 2>&1
            render_page_indicator__1882_v0 ${current_page} ${total_pages};
            __AF_render_page_indicator1882_v0__212_17="$__AF_render_page_indicator1882_v0";
            echo "$__AF_render_page_indicator1882_v0__212_17" > /dev/null 2>&1
elif [ $(echo ${prev_selected} '!=' ${selected} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            go_up__1815_v0 $(echo ${display_count} '-' ${prev_selected} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
            __AF_go_up1815_v0__215_17="$__AF_go_up1815_v0";
            echo "$__AF_go_up1815_v0__215_17" > /dev/null 2>&1
            __AMBER_ARRAY_289=("");
            eprintf__1807_v0 "\x1b[K" __AMBER_ARRAY_289[@];
            __AF_eprintf1807_v0__216_17="$__AF_eprintf1807_v0";
            echo "$__AF_eprintf1807_v0__216_17" > /dev/null 2>&1
            __AMBER_LEN="${cursor}";
            print_blank__1813_v0 "${#__AMBER_LEN}";
            __AF_print_blank1813_v0__217_17="$__AF_print_blank1813_v0";
            echo "$__AF_print_blank1813_v0__217_17" > /dev/null 2>&1
            cutoff_text__1827_v0 "${page_options[${prev_selected}]}" ${max_option_width};
            __AF_cutoff_text1827_v0__218_25="${__AF_cutoff_text1827_v0}";
            __AMBER_ARRAY_290=("");
            eprintf__1807_v0 "${__AF_cutoff_text1827_v0__218_25}" __AMBER_ARRAY_290[@];
            __AF_eprintf1807_v0__218_17="$__AF_eprintf1807_v0";
            echo "$__AF_eprintf1807_v0__218_17" > /dev/null 2>&1
            local diff=$(echo ${selected} '-' ${prev_selected} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
            go_up_or_down__1817_v0 ${diff};
            __AF_go_up_or_down1817_v0__221_17="$__AF_go_up_or_down1817_v0";
            echo "$__AF_go_up_or_down1817_v0__221_17" > /dev/null 2>&1
            __AMBER_ARRAY_291=("");
            eprintf__1807_v0 "\x1b[9999D" __AMBER_ARRAY_291[@];
            __AF_eprintf1807_v0__222_17="$__AF_eprintf1807_v0";
            echo "$__AF_eprintf1807_v0__222_17" > /dev/null 2>&1
            __AMBER_ARRAY_292=("");
            eprintf__1807_v0 "\x1b[K" __AMBER_ARRAY_292[@];
            __AF_eprintf1807_v0__223_17="$__AF_eprintf1807_v0";
            echo "$__AF_eprintf1807_v0__223_17" > /dev/null 2>&1
            cutoff_text__1827_v0 "${page_options[${selected}]}" ${max_option_width};
            __AF_cutoff_text1827_v0__224_52="${__AF_cutoff_text1827_v0}";
            colored_secondary__1790_v0 "${cursor}""${__AF_cutoff_text1827_v0__224_52}";
            __AF_colored_secondary1790_v0__224_25="${__AF_colored_secondary1790_v0}";
            __AMBER_ARRAY_293=("");
            eprintf__1807_v0 "${__AF_colored_secondary1790_v0__224_25}" __AMBER_ARRAY_293[@];
            __AF_eprintf1807_v0__224_17="$__AF_eprintf1807_v0";
            echo "$__AF_eprintf1807_v0__224_17" > /dev/null 2>&1
            go_down__1816_v0 $(echo ${display_count} '-' ${selected} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
            __AF_go_down1816_v0__226_17="$__AF_go_down1816_v0";
            echo "$__AF_go_down1816_v0__226_17" > /dev/null 2>&1
            __AMBER_ARRAY_294=("");
            eprintf__1807_v0 "\x1b[9999D" __AMBER_ARRAY_294[@];
            __AF_eprintf1807_v0__227_17="$__AF_eprintf1807_v0";
            echo "$__AF_eprintf1807_v0__227_17" > /dev/null 2>&1
fi
done
    local total_lines=$(echo ${display_count} '+' 2 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
    if [ $([ "_${header}" == "_" ]; echo $?) != 0 ]; then
        total_lines=$(echo ${total_lines} '+' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
fi
    go_down__1816_v0 1;
    __AF_go_down1816_v0__237_5="$__AF_go_down1816_v0";
    echo "$__AF_go_down1816_v0__237_5" > /dev/null 2>&1
    remove_line__1811_v0 $(echo ${total_lines} '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//');
    __AF_remove_line1811_v0__238_5="$__AF_remove_line1811_v0";
    echo "$__AF_remove_line1811_v0__238_5" > /dev/null 2>&1
    remove_current_line__1812_v0 ;
    __AF_remove_current_line1812_v0__239_5="$__AF_remove_current_line1812_v0";
    echo "$__AF_remove_current_line1812_v0__239_5" > /dev/null 2>&1
    stty_unlock__1770_v0 ;
    __AF_stty_unlock1770_v0__241_5="$__AF_stty_unlock1770_v0";
    echo "$__AF_stty_unlock1770_v0__241_5" > /dev/null 2>&1
    show_cursor__1819_v0 ;
    __AF_show_cursor1819_v0__242_5="$__AF_show_cursor1819_v0";
    echo "$__AF_show_cursor1819_v0__242_5" > /dev/null 2>&1
    local global_selected=$(echo $(echo ${current_page} '*' ${page_size} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '+' ${selected} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
    __AF_xyl_choose1883_v0="${options[${global_selected}]}";
    return 0
}
format_entry_display__1887_v0() {
    local entry=("${!1}")
    local name="${entry[0]}"
    local file_type="${entry[1]}"
    if [ $([ "_${file_type}" != "_d" ]; echo $?) != 0 ]; then
        colored_primary__1595_v0 "/";
        __AF_colored_primary1595_v0__13_23="${__AF_colored_primary1595_v0}";
        __AF_format_entry_display1887_v0="${name}""${__AF_colored_primary1595_v0__13_23}";
        return 0
fi
    if [ $([ "_${file_type}" != "_l" ]; echo $?) != 0 ]; then
        colored_accent__1597_v0 " > ";
        __AF_colored_accent1597_v0__16_23="${__AF_colored_accent1597_v0}";
        colored_primary__1595_v0 "${entry[2]}";
        __AF_colored_primary1595_v0__16_47="${__AF_colored_primary1595_v0}";
        __AF_format_entry_display1887_v0="${name}""${__AF_colored_accent1597_v0__16_23}""${__AF_colored_primary1595_v0__16_47}";
        return 0
fi
    __AF_format_entry_display1887_v0="${name}";
    return 0
}
xyl_file__1888_v0() {
    local start_path=$1
    local cursor=$2
    local show_hidden=$3
    local page_size=$4
    stty_lock__1575_v0 ;
    __AF_stty_lock1575_v0__34_5="$__AF_stty_lock1575_v0";
    echo "$__AF_stty_lock1575_v0__34_5" > /dev/null 2>&1
    term_width__1579_v0 ;
    __AF_term_width1579_v0__36_22="$__AF_term_width1579_v0";
    local term_width="$__AF_term_width1579_v0__36_22"
    __AMBER_LEN="${cursor}";
    local max_entry_width=$(echo $(echo ${term_width} '-' "${#__AMBER_LEN}" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
    # Initialize current path
    local current_path="${start_path}"
    if [ $([ "_${current_path}" != "_" ]; echo $?) != 0 ]; then
        get_cwd__1554_v0 ;
        __AF_get_cwd1554_v0__42_24="${__AF_get_cwd1554_v0}";
        current_path="${__AF_get_cwd1554_v0__42_24}"
fi
    normalize_path__1555_v0 "${current_path}";
    __AF_normalize_path1555_v0__44_20="${__AF_normalize_path1555_v0}";
    current_path="${__AF_normalize_path1555_v0__44_20}"
    while :
do
        colored_primary__1595_v0 "Loading files...";
        __AF_colored_primary1595_v0__47_17="${__AF_colored_primary1595_v0}";
        __AMBER_ARRAY_295=("");
        eprintf__1613_v0 "${__AF_colored_primary1595_v0__47_17}" __AMBER_ARRAY_295[@];
        __AF_eprintf1613_v0__47_9="$__AF_eprintf1613_v0";
        echo "$__AF_eprintf1613_v0__47_9" > /dev/null 2>&1
        # Get directory entries
        get_directory_entries__1552_v0 "${current_path}";
        __AF_get_directory_entries1552_v0__50_27=("${__AF_get_directory_entries1552_v0[@]}");
        local raw_entries=("${__AF_get_directory_entries1552_v0__50_27[@]}")
        # Build options list and parallel entries list
        __AMBER_ARRAY_296=();
        local options=("${__AMBER_ARRAY_296[@]}")
        __AMBER_ARRAY_297=();
        local entries=("${__AMBER_ARRAY_297[@]}")
        # Add parent directory entry (..)
        if [ $([ "_${current_path}" == "_/" ]; echo $?) != 0 ]; then
            __AMBER_ARRAY_298=("..");
            options+=("${__AMBER_ARRAY_298[@]}")
            __AMBER_ARRAY_299=("..	d");
            entries+=("${__AMBER_ARRAY_299[@]}")
fi
        for raw_entry in "${raw_entries[@]}"; do
            parse_entry__1553_v0 "${raw_entry}";
            __AF_parse_entry1553_v0__63_25=("${__AF_parse_entry1553_v0[@]}");
            local entry=("${__AF_parse_entry1553_v0__63_25[@]}")
            local name="${entry[0]}"
            # Skip hidden files if not showing them
            __AMBER_VAL_300=$( echo "${name}" | cut -c1 );
            __AS=$?;
            local first_char="${__AMBER_VAL_300}"
            if [ $(echo $(echo  '!' ${show_hidden} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '&&' $([ "_${first_char}" != "_." ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                continue
fi
            format_entry_display__1887_v0 entry[@];
            __AF_format_entry_display1887_v0__70_25="${__AF_format_entry_display1887_v0}";
            __AMBER_ARRAY_301=("${__AF_format_entry_display1887_v0__70_25}");
            options+=("${__AMBER_ARRAY_301[@]}")
            __AMBER_ARRAY_302=("${raw_entry}");
            entries+=("${__AMBER_ARRAY_302[@]}")
done
        if [ $(echo "${#entries[@]}" '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            eprintf_colored__1614_v0 "ERROR: Directory is empty or inaccessible.
" 31;
            __AF_eprintf_colored1614_v0__75_13="$__AF_eprintf_colored1614_v0";
            echo "$__AF_eprintf_colored1614_v0__75_13" > /dev/null 2>&1
            stty_unlock__1576_v0 ;
            __AF_stty_unlock1576_v0__76_13="$__AF_stty_unlock1576_v0";
            echo "$__AF_stty_unlock1576_v0__76_13" > /dev/null 2>&1
            __AF_xyl_file1888_v0="";
            return 0
fi
        # Use xyl_choose with current path as header
        colored_primary__1595_v0 "${current_path}";
        __AF_colored_primary1595_v0__81_22="${__AF_colored_primary1595_v0}";
        local header="${__AF_colored_primary1595_v0__81_22}"
        remove_current_line__1618_v0 ;
        __AF_remove_current_line1618_v0__83_9="$__AF_remove_current_line1618_v0";
        echo "$__AF_remove_current_line1618_v0__83_9" > /dev/null 2>&1
        xyl_choose__1883_v0 options[@] "${cursor}" "${header}" ${page_size};
        __AF_xyl_choose1883_v0__84_31="${__AF_xyl_choose1883_v0}";
        local selected_option="${__AF_xyl_choose1883_v0__84_31}"
        # Find selected entry index
        local selected_idx=$(echo  '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')
        for i in $(seq 0 $(echo "${#options[@]}" '-' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')); do
            if [ $([ "_${options[${i}]}" != "_${selected_option}" ]; echo $?) != 0 ]; then
                selected_idx=${i}
                break
fi
done
        if [ $(echo ${selected_idx} '<' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            __AF_xyl_file1888_v0="";
            return 0
fi
        parse_entry__1553_v0 "${entries[${selected_idx}]}";
        __AF_parse_entry1553_v0__99_21=("${__AF_parse_entry1553_v0[@]}");
        local entry=("${__AF_parse_entry1553_v0__99_21[@]}")
        local name="${entry[0]}"
        local file_type="${entry[1]}"
        if [ $([ "_${name}" != "_.." ]; echo $?) != 0 ]; then
            get_parent_dir__1558_v0 "${current_path}";
            __AF_get_parent_dir1558_v0__105_32="${__AF_get_parent_dir1558_v0}";
            current_path="${__AF_get_parent_dir1558_v0__105_32}"
elif [ $([ "_${file_type}" != "_d" ]; echo $?) != 0 ]; then
            path_join__1557_v0 "${current_path}" "${name}";
            __AF_path_join1557_v0__108_32="${__AF_path_join1557_v0}";
            current_path="${__AF_path_join1557_v0__108_32}"
            normalize_path__1555_v0 "${current_path}";
            __AF_normalize_path1555_v0__109_32="${__AF_normalize_path1555_v0}";
            current_path="${__AF_normalize_path1555_v0__109_32}"
elif [ $([ "_${file_type}" != "_l" ]; echo $?) != 0 ]; then
            # For symlinks, check if they point to a directory
            starts_with__20_v0 "${entry[2]}" "/";
            __AF_starts_with20_v0__113_20="$__AF_starts_with20_v0";
            if [ "$__AF_starts_with20_v0__113_20" != 0 ]; then
                current_path="${entry[2]}"
                normalize_path__1555_v0 "${current_path}";
                __AF_normalize_path1555_v0__115_36="${__AF_normalize_path1555_v0}";
                current_path="${__AF_normalize_path1555_v0__115_36}"
else
                stty_unlock__1576_v0 ;
                __AF_stty_unlock1576_v0__117_21="$__AF_stty_unlock1576_v0";
                echo "$__AF_stty_unlock1576_v0__117_21" > /dev/null 2>&1
                path_join__1557_v0 "${current_path}" "${entry[2]}";
                __AF_path_join1557_v0__118_28="${__AF_path_join1557_v0}";
                __AF_xyl_file1888_v0="${__AF_path_join1557_v0__118_28}";
                return 0
fi
else
                            stty_unlock__1576_v0 ;
                __AF_stty_unlock1576_v0__122_17="$__AF_stty_unlock1576_v0";
                echo "$__AF_stty_unlock1576_v0__122_17" > /dev/null 2>&1
                path_join__1557_v0 "${current_path}" "${name}";
                __AF_path_join1557_v0__123_24="${__AF_path_join1557_v0}";
                __AF_xyl_file1888_v0="${__AF_path_join1557_v0__123_24}";
                return 0
fi
done
    stty_unlock__1576_v0 ;
    __AF_stty_unlock1576_v0__128_5="$__AF_stty_unlock1576_v0";
    echo "$__AF_stty_unlock1576_v0__128_5" > /dev/null 2>&1
    __AF_xyl_file1888_v0="";
    return 0
}
print_file_help__1964_v0() {
    echo "Usage: ./xylitol.sh file [<path>] [flags]"
    echo ""
    colored_primary__1595_v0 "file";
    __AF_colored_primary1595_v0__7_12="${__AF_colored_primary1595_v0}";
    __AMBER_ARRAY_303=("");
    printf__99_v0 "${__AF_colored_primary1595_v0__7_12}" __AMBER_ARRAY_303[@];
    __AF_printf99_v0__7_5="$__AF_printf99_v0";
    echo "$__AF_printf99_v0__7_5" > /dev/null 2>&1
    __AMBER_ARRAY_304=("");
    printf__99_v0 " - Browse filesystem and select a file." __AMBER_ARRAY_304[@];
    __AF_printf99_v0__8_5="$__AF_printf99_v0";
    echo "$__AF_printf99_v0__8_5" > /dev/null 2>&1
    echo ""
    echo ""
    colored_secondary__1596_v0 "Arguments: ";
    __AF_colored_secondary1596_v0__11_12="${__AF_colored_secondary1596_v0}";
    __AMBER_ARRAY_305=("");
    printf__99_v0 "${__AF_colored_secondary1596_v0__11_12}""
" __AMBER_ARRAY_305[@];
    __AF_printf99_v0__11_5="$__AF_printf99_v0";
    echo "$__AF_printf99_v0__11_5" > /dev/null 2>&1
    echo "  [<path>]               Starting directory path (default: current directory)"
    echo ""
    colored_secondary__1596_v0 "Flags: ";
    __AF_colored_secondary1596_v0__14_12="${__AF_colored_secondary1596_v0}";
    __AMBER_ARRAY_306=("");
    printf__99_v0 "${__AF_colored_secondary1596_v0__14_12}""
" __AMBER_ARRAY_306[@];
    __AF_printf99_v0__14_5="$__AF_printf99_v0";
    echo "$__AF_printf99_v0__14_5" > /dev/null 2>&1
    echo "  -h, --help             Show this help message"
    echo "  -a, --all              Show hidden files"
    echo "  --cursor=\"<text>\"      Set the cursor text (default: '> ')"
    echo "  --path=\"<path>\"        Set the starting directory path"
    echo "  --page-size=<number>   Set the number of entries per page (default: 10)"
    echo ""
}
execute_file__2015_v0() {
    local parameters=("${!1}")
    local cursor="> "
    local start_path=""
    local show_hidden=0
    local page_size=10
    for param in "${parameters[@]:2:9997}"; do
        match_regex__17_v0 "${param}" "^-h\$" 0;
        __AF_match_regex17_v0__14_13="$__AF_match_regex17_v0";
        match_regex__17_v0 "${param}" "^--help\$" 0;
        __AF_match_regex17_v0__14_43="$__AF_match_regex17_v0";
        match_regex__17_v0 "${param}" "^--cursor=.*\$" 0;
        __AF_match_regex17_v0__18_13="$__AF_match_regex17_v0";
        match_regex__17_v0 "${param}" "^--path=.*\$" 0;
        __AF_match_regex17_v0__22_13="$__AF_match_regex17_v0";
        match_regex__17_v0 "${param}" "^-a\$" 0;
        __AF_match_regex17_v0__26_13="$__AF_match_regex17_v0";
        match_regex__17_v0 "${param}" "^--all\$" 0;
        __AF_match_regex17_v0__26_43="$__AF_match_regex17_v0";
        match_regex__17_v0 "${param}" "^--page-size=.*\$" 0;
        __AF_match_regex17_v0__29_13="$__AF_match_regex17_v0";
        if [ $(echo "$__AF_match_regex17_v0__14_13" '||' "$__AF_match_regex17_v0__14_43" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            print_file_help__1964_v0 ;
            __AF_print_file_help1964_v0__15_17="$__AF_print_file_help1964_v0";
            echo "$__AF_print_file_help1964_v0__15_17" > /dev/null 2>&1
            exit 0
elif [ "$__AF_match_regex17_v0__18_13" != 0 ]; then
            split__3_v0 "${param}" "=";
            __AF_split3_v0__19_30=("${__AF_split3_v0[@]}");
            local result=("${__AF_split3_v0__19_30[@]}")
            cursor="${result[1]}"
elif [ "$__AF_match_regex17_v0__22_13" != 0 ]; then
            split__3_v0 "${param}" "=";
            __AF_split3_v0__23_30=("${__AF_split3_v0[@]}");
            local result=("${__AF_split3_v0__23_30[@]}")
            start_path="${result[1]}"
elif [ $(echo "$__AF_match_regex17_v0__26_13" '||' "$__AF_match_regex17_v0__26_43" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            show_hidden=1
elif [ "$__AF_match_regex17_v0__29_13" != 0 ]; then
            split__3_v0 "${param}" "=";
            __AF_split3_v0__30_30=("${__AF_split3_v0[@]}");
            local result=("${__AF_split3_v0__30_30[@]}")
            parse_number__12_v0 "${result[1]}";
            __AS=$?;
if [ $__AS != 0 ]; then
                eprintf_colored__1614_v0 "ERROR: Invalid page-size value: ""${result[1]}""
" 31;
                __AF_eprintf_colored1614_v0__32_21="$__AF_eprintf_colored1614_v0";
                echo "$__AF_eprintf_colored1614_v0__32_21" > /dev/null 2>&1
                exit 1
fi;
            __AF_parse_number12_v0__31_29="$__AF_parse_number12_v0";
            page_size="$__AF_parse_number12_v0__31_29"
else
            # Treat as start path if not a flag
            start_path="${param}"
fi
done
    xyl_file__1888_v0 "${start_path}" "${cursor}" ${show_hidden} ${page_size};
    __AF_xyl_file1888_v0__43_12="${__AF_xyl_file1888_v0}";
    __AF_execute_file2015_v0="${__AF_xyl_file1888_v0__43_12}";
    return 0
}
# #!/usr/bin/env amber
__54_VERSION="0.1.0"
__55_AMBER_VERSION="0.4.0"
check_prerequirements__2017_v0() {
     echo "0" | bc -l > /dev/null ;
    __AS=$?;
if [ $__AS != 0 ]; then
        eprintf_colored__204_v0 "Error: " 91;
        __AF_eprintf_colored204_v0__15_9="$__AF_eprintf_colored204_v0";
        echo "$__AF_eprintf_colored204_v0__15_9" > /dev/null 2>&1
        __AMBER_ARRAY_307=("");
        eprintf__203_v0 "bc is not installed. Please install bc to use xylitol.
" __AMBER_ARRAY_307[@];
        __AF_eprintf203_v0__16_9="$__AF_eprintf203_v0";
        echo "$__AF_eprintf203_v0__16_9" > /dev/null 2>&1
        __AMBER_ARRAY_308=("");
        eprintf__203_v0 "  For Debian/Ubuntu: sudo apt install bc
" __AMBER_ARRAY_308[@];
        __AF_eprintf203_v0__17_9="$__AF_eprintf203_v0";
        echo "$__AF_eprintf203_v0__17_9" > /dev/null 2>&1
        __AMBER_ARRAY_309=("");
        eprintf__203_v0 "  For Fedora: sudo dnf install bc
" __AMBER_ARRAY_309[@];
        __AF_eprintf203_v0__18_9="$__AF_eprintf203_v0";
        echo "$__AF_eprintf203_v0__18_9" > /dev/null 2>&1
        __AMBER_ARRAY_310=("");
        eprintf__203_v0 "  For Arch Linux: sudo pacman -S bc
" __AMBER_ARRAY_310[@];
        __AF_eprintf203_v0__19_9="$__AF_eprintf203_v0";
        echo "$__AF_eprintf203_v0__19_9" > /dev/null 2>&1
        __AF_check_prerequirements2017_v0=0;
        return 0
fi
    __AF_check_prerequirements2017_v0=1;
    return 0
}
trap_cleanup__2018_v0() {
     trap 'printf "\x1b[?25h\x1b[0m" >&2; 
            stty echo < /dev/tty' EXIT ;
    __AS=$?
}
declare -r arguments=("$0" "$@")
    trap_cleanup__2018_v0 ;
    __AF_trap_cleanup2018_v0__31_5="$__AF_trap_cleanup2018_v0";
    echo "$__AF_trap_cleanup2018_v0__31_5" > /dev/null 2>&1
    check_prerequirements__2017_v0 ;
    __AF_check_prerequirements2017_v0__32_12="$__AF_check_prerequirements2017_v0";
    if [ $(echo  '!' "$__AF_check_prerequirements2017_v0__32_12" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        exit 1
fi
    get_xylitol_colors__184_v0 ;
    __AF_get_xylitol_colors184_v0__33_5="$__AF_get_xylitol_colors184_v0";
    echo "$__AF_get_xylitol_colors184_v0__33_5" > /dev/null 2>&1
    if [ $(echo $(echo $(echo $(echo "${#arguments[@]}" '<' 2 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '||' $([ "_${arguments[1]}" != "_help" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '||' $([ "_${arguments[1]}" != "_--help" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '||' $([ "_${arguments[1]}" != "_-h" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                    print_help__349_v0 ;
            __AF_print_help349_v0__37_13="$__AF_print_help349_v0";
            echo "$__AF_print_help349_v0__37_13" > /dev/null 2>&1
elif [ $([ "_${arguments[1]}" != "_input" ]; echo $?) != 0 ]; then
                    execute_input__705_v0 arguments[@];
            __AF_execute_input705_v0__40_18="${__AF_execute_input705_v0}";
            echo "${__AF_execute_input705_v0__40_18}"
elif [ $([ "_${arguments[1]}" != "_choose" ]; echo $?) != 0 ]; then
                    execute_choose__1065_v0 arguments[@];
            __AF_execute_choose1065_v0__43_18="${__AF_execute_choose1065_v0}";
            echo "${__AF_execute_choose1065_v0__43_18}"
elif [ $([ "_${arguments[1]}" != "_confirm" ]; echo $?) != 0 ]; then
                    execute_confirm__1437_v0 arguments[@];
            __AF_execute_confirm1437_v0__46_26="${__AF_execute_confirm1437_v0}";
            result="${__AF_execute_confirm1437_v0__46_26}"
            if [ $([ "_${result}" != "_yes" ]; echo $?) != 0 ]; then
                exit 0
else
                exit 1
fi
elif [ $([ "_${arguments[1]}" != "_file" ]; echo $?) != 0 ]; then
                    execute_file__2015_v0 arguments[@];
            __AF_execute_file2015_v0__53_18="${__AF_execute_file2015_v0}";
            echo "${__AF_execute_file2015_v0__53_18}"
elif [ $(echo $(echo $([ "_${arguments[1]}" != "_version" ]; echo $?) '||' $([ "_${arguments[1]}" != "_--version" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') '||' $([ "_${arguments[1]}" != "_-v" ]; echo $?) | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                    colored_primary__185_v0 "xylitol.sh";
            __AF_colored_primary185_v0__56_20="${__AF_colored_primary185_v0}";
            __AMBER_ARRAY_311=("");
            printf__99_v0 "${__AF_colored_primary185_v0__56_20}" __AMBER_ARRAY_311[@];
            __AF_printf99_v0__56_13="$__AF_printf99_v0";
            echo "$__AF_printf99_v0__56_13" > /dev/null 2>&1
            __AMBER_ARRAY_312=("");
            printf__99_v0 " version: " __AMBER_ARRAY_312[@];
            __AF_printf99_v0__57_13="$__AF_printf99_v0";
            echo "$__AF_printf99_v0__57_13" > /dev/null 2>&1
            colored_accent__187_v0 "${__54_VERSION}";
            __AF_colored_accent187_v0__58_20="${__AF_colored_accent187_v0}";
            __AMBER_ARRAY_313=("");
            printf__99_v0 "${__AF_colored_accent187_v0__58_20}" __AMBER_ARRAY_313[@];
            __AF_printf99_v0__58_13="$__AF_printf99_v0";
            echo "$__AF_printf99_v0__58_13" > /dev/null 2>&1
            echo ""
            printf_colored__202_v0 "written in Amber: " 90;
            __AF_printf_colored202_v0__60_13="$__AF_printf_colored202_v0";
            echo "$__AF_printf_colored202_v0__60_13" > /dev/null 2>&1
            printf_colored__202_v0 "  ""${__55_AMBER_VERSION}" 90;
            __AF_printf_colored202_v0__61_13="$__AF_printf_colored202_v0";
            echo "$__AF_printf_colored202_v0__61_13" > /dev/null 2>&1
else
                    print_help__349_v0 ;
            __AF_print_help349_v0__64_13="$__AF_print_help349_v0";
            echo "$__AF_print_help349_v0__64_13" > /dev/null 2>&1
            printf_colored__202_v0 "ERROR: Unknown command '""${arguments[1]}""'" 91;
            __AF_printf_colored202_v0__65_13="$__AF_printf_colored202_v0";
            echo "$__AF_printf_colored202_v0__65_13" > /dev/null 2>&1
fi
