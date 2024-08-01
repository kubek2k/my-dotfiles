command! -nargs=* SStart !soji start <args>
command! -nargs=0 SBreak !soji break
command! -nargs=* SMeeting !soji meeting <args>
command! -nargs=0 SStatus echon system("soji status")
