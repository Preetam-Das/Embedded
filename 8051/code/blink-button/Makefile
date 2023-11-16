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

upload: $(TARGET)
	$(UPLD) $(UPLDFLAGS) -U flash:w:$^:i

sim: $(TARGET)
	ucsim_51 $(TARGET)

clean:
	rm -rf $(BUILDIR)

.PHONY: clean upload sim
