# source /opt/pwndbg/gdbinit.py
# source /opt/gef/gef.py
# source /opt/peda/peda.py

set disassembly-flavor intel
set disable-randomization off
set follow-fork-mode child

define init-peda
source /opt/peda/peda.py
end
document init-peda
Initializes the PEDA (Python Exploit Development Assistant for GDB) framework
end

define init-pwndbg
source /opt/pwndbg/gdbinit.py
end
document init-pwndbg
Initializes the pwndbg
end

define init-gef
source /opt/gef/gef.py
end
document init-gef
Initializes GEF (GDB Enhanced Features)
end

define clear
shell clear
end