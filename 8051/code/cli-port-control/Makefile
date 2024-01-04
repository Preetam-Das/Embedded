# Directories
BUILDIR=build
SRCDIR=src

# Files
SRCFILES=$(wildcard $(SRCDIR)/*.S)
TARGETFILE=main.hex
TARGET=$(BUILDIR)/$(TARGETFILE)

# TOOLCHAIN
AS=asem
ASFLAGS=-v

# UPLOAD
UPLD=avrdude
PRG=usbasp
MACH=89s52
UPLDFLAGS=-F -V -c $(PRG) -p $(MACH) -v


$(TARGET): $(SRCFILES)
	@echo Cretaing directory $(BUILDIR)
	mkdir -p $(BUILDIR)
	$(AS) $(ASFLAGS) $^ $@

dir:
	mkdir -p src
	touch src/main.S
	touch README.md

upload: $(TARGET)
	$(UPLD) $(UPLDFLAGS) -U flash:w:$^:i

clean:
	rm -rf $(BUILDIR)

.PHONY: clean upload dir
