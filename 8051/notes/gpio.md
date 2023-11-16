## GPIO in 8051/52

- There are 4 bit addressable Ports in 8051/52 each of which has 8 Pins which
  can be used as bi-directional inputs-outputs.

- All the ports uses inverse logic .i.e, writing logic-0 makes them act like
output ports and writing logic-1 makes them work like inputs.

- Port 1-3 has internall pullup registers while Port 0 does not.

- Memory mapping of the Ports' SFRs is as follows:

    | Port | Address |
    |------|---------|
    | P0   | 080H    |
    | P1   | 090H    |
    | P2   | 0A0H    |
    | P3   | 0B0H    |
