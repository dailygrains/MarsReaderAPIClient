# MarsReaderAPIClient

A fictional API client Swift Package intended to interact with the imaginary Mars Reader API.

## Overview

At this point in a project like this, a separate package is not really waranted, but I wanted to test out working with
packages locally. This package is not imported through the SPM, but is stored in a folder off the root of this project
and "dragged" into this project. This recognizes the package and functions as if it were imported via SPM, while 
allowing for direct editing of the code.

When local package code is eventually migrated to an actual repo for distribution, you can add it to this project
via SPM without needing to modify the app.

I also experimented with the new DocC tooling in Xcode 13.
