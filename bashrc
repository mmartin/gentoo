pre_src_prepare() {
        [[ ${EAPI:-0} == [012345] && " gtick-0.5.0 sooperlooper-1.7.3 zathura-pdf-mupdf-0.3.1 " =~ " ${P} " ]] || return

        ewarn "Injecting epatch_user"

        if ! type epatch_user > /dev/null 2>&1; then
                local names="EPATCH_USER_SOURCE epatch_user epatch evar_push evar_push_set evar_pop estack_push estack_pop"
                source <(awk "/^# @(FUNCTION|VARIABLE): / { p = 0 } /^# @(FUNCTION|VARIABLE): (${names// /|})\$/ { p = 1 } p { print }" ${PORTDIR}/eclass/eutils.eclass)
        fi

        epatch_user

        for name in $names; do
                unset $name
        done
}
