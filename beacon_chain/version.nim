type
  NetworkBackendType* = enum
    libp2pBackend
    rlpxBackend
    # Special testing backend used to avoid networking code without having
    # to change too much of `beacon_node_types`
    # TODO: find a more elegant solution to the import madness
    noneBackend

const
  network_type {.strdefine.} = "libp2p"

  networkBackend* = when network_type == "rlpx": rlpxBackend
                    elif network_type == "libp2p": libp2pBackend
                    elif network_type == "none": noneBackend
                    else: {.fatal: "The 'network_type' should be one of 'libp2p', 'none', or 'rlpx'" .}

const
  versionMajor* = 0
  versionMinor* = 3
  versionBuild* = 0

  semanticVersion* = 2
    # Bump this up every time a breaking change is introduced
    # Clients having different semantic versions won't be able
    # to join the same testnets.

template versionAsStr*: string =
  $versionMajor & "." & $versionMinor & "." & $versionBuild

proc fullVersionStr*: string =
  versionAsStr & "_" & network_type

