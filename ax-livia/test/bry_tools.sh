#!/bin/bash

source "${HOME}/ax-livia/yocto/scripts/deploy-image.sh"

function replace_qmm_files() {
    local dry_raster_destination="/etc/domino/content/rasters/*"
    local dry_raster_location_source="${HOME}/ax-livia/test/ath_files/dry_rasters/X30/"

    # Iterate over all qmm files in the provided directory
    for qmm_file in "${dry_raster_location_source}"/*.qmm; do
        # Use the replace_qmm_config function from deploy-image.sh on each file
        replace_qmm_config "${qmm_file}" "${dry_raster_destination}"
    done
}