# $FreeBSD: src/etc/root/dot.cshrc,v 1.30.10.1.6.1 2010/12/21 17:09:25 kensmith Exp $
#
# .cshrc - csh resource script, read at beginning of execution by each shell
#
# see also csh(1), environ(7).
#

set path = ( /sbin /bin /usr/sbin /usr/bin /usr/local/sbin /usr/local/bin $HOME/bin /opt/bin )

alias	h		history 25
alias	more		less
alias 	df		df -h
#alias	dir		ls
#alias	era		rm
#alias	kitty		cat
#alias	process_table	ps

setenv PAGER		less
setenv BLOCKSIZE	K
setenv LS_COLORS 	'di=96:fi=37:ln=1;96'
setenv LSCOLORS		'gxGxFxdxcxDxdxaDcxgxgx'
setenv SYSTEMD_PAGER
setenv SYSTEMD_EDITOR	vi
setenv EDITOR		vi
setenv VISUAL		vi

# if vim is available, use
if ( -e `which vim` ) then
  alias vi 		`which vim`
  setenv EDITOR		`which vim`
  setenv VISUAL		`which vim`
endif
 
set autolist
set color
set colorcat
set nobeep
set filec
set history = 10000
set savehist = (10000 merge)

# Check for mailboxes
if ( -d ~/$USER/Maildir ) then
  set MAIL = ( ~/$USER/Maildir )
endif
if ( -e /var/mail/$USER) then 
  set mail = ( /var/mail/$USER )
endif

unset autologout

# set filemasks
if ( `id -u` == "0" ) then
  umask 22
else
  umask 77
endif

if ($?prompt) then
  # An interactive shell -- set some stuff up
  if ( `id -u` == "0" ) then
    set prompt = "[%{\033[1;31m%}%n%{\033[0m%}@%B%m%b]%B%~%b# "
  else
    set prompt = "[%B%n%b@%B%m%b]%B%~%b# " 
  endif

  if ( $?tcsh ) then
    bindkey "^W" backward-delete-word
    bindkey -k up history-search-backward
    bindkey -k down history-search-forward
  endif

  # For keys that shouldn't be version controlled
  if ( -e ~/.cshrc.private ) then
    source ~/.cshrc.private
  endif

  # Host specific configurations
  if ( -e ~/.`uname -n`.cshrc ) then
    source ~/.`uname -n`.cshrc
  endif

  # OS specific aliases
  switch(`uname`)
    case "Darwin":
      alias top		top -s 1
      alias la		ls -alFG
      alias lf		ls -alFG
      alias ll		ls -alFG
      alias ls		ls -alFG
    breaksw

    case "FreeBSD":
      alias top		top -s 1 -P
      alias la		ls -alFG
      alias lf		ls -alFG
      alias ll		ls -alFG
      alias ls		ls -alFG

      set path = `echo $path /usr/games`
    breaksw

    case "Linux":
      alias top		top -d 1
      alias la		ls -alF --color=auto
      alias lf		ls -alF --color=auto
      alias ll		ls -alF --color=auto
      alias ls		ls -alF --color=auto
      alias grep		grep --color=auto
    breaksw

    case "OpenBSD":
      if ( -e `which colorls`) then
        alias la	`which colorls` -alFG
        alias lf	`which colorls` -alFG
        alias ll	`which colorls` -alFG
        alias ls	`which colorls` -alFG
      else
        alias la          ls -alF
        alias lf          ls -alF
        alias ll          ls -alF
        alias ls          ls -alF
      endif

    setenv PKG_PATH	ftp://ftp.openbsd.org/pub/OpenBSD/`uname -r`/packages/`uname -m`/
    breaksw

    case "SunOS":
      setenv MACHINE_THAT_GOES_PING
      if ( -e `which gls` ) then
        alias la	`which gls` -laF --color=auto
        alias lf	`which gls` -laF --color=auto
        alias ll	`which gls` -laF --color=auto
        alias ls	`which gls` -laF --color=auto
      else
        alias la	ls -lFA
        alias lf	ls -lFA
        alias ll	ls -lFA
        alias la	ls -lFA
      endif

      if ( -e `which ggrep` ) then
        alias grep	`which ggrep` --color=auto
      endif

      if ( -e `which gnutar` ) then
        alias tar		`which gnutar`
      endif
    breaksw

  endsw

  # Host specific settings
  switch(`uname -n`)
    # shell.iglou.com
    case "shell1":
      alias php		/usr/local/php5/bin/php
      alias php4	/usr/local/bin/php
      alias php5	/usr/local/php5/bin/php
      alias mutt	/usr/local/bin/mutt1.5.21
      alias ee		$HOME/bin/ee

      setenv LESS		-P'%f (%pB\%) Press SPACE to continue, Q to Quit'
      setenv MAILREADER	/usr/local/bin/mutt1.5.21
    
      set path = `echo $path /usr/local/php5/bin /usr/ucb`
    breaksw

  endsw

  # prints timestamps, make this the last 
  alias postcmd	date

endif
