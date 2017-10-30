#!/bin/bash
BGREEN='\033[1;32m'
GREEN='\033[0;32m'
BCYAN='\033[1;36m'
RED='\033[0;31m'

NC='\033[0m' # Removes Color

baseOutDir=$1
if [ -n "$baseOutDir" ]; then
        if [ ! -d "$baseOutDir" ]; then
                echo -e "${GREEN}Making base output directory ${BGREEN}$baseOutDir\n"
                mkdir "$baseOutDir"
        fi
fi

build_dir () {
        srcDir=$1
        dstDir=$2
        if [ -n "$baseOutDir" ]; then
                dstDir="$baseOutDir/$dstDir"
        fi
        params=( "$@" )
        rest=( "${params[@]:2}" )

        if [ ! -d "$dstDir" ]; then
                mkdir -p "$dstDir"
        else
                rm "$dstDir"/*.txt
        fi

        for f in "$srcDir"/*.txt
        do
                filename=`basename $f`
                outName="$dstDir/$filename"
                echo -e "\t${GREEN}[PHP] ${NC}Exec $f to $outName with params ${rest[@]}"
                php "$f" "${rest[@]}" > "$outName"

                if [ $? -ne 0 ]; then
                        rm "$outName"
                fi
        done
}

res_360p=( "Performance" 640 360 )
res_480p=( "Performance" 854 480 )
res_540p=( "Performance" 960 540 )
res_576p=( "Performance" 1024 576 )
res_720p=( "Performance" 1280 720 )
res_768p=( "Performance" 1366 768 )
res_900p=( "Quality" 1600 900 )
res_1080p=( "Quality" 1920 1080 )
res_1080p219=( "Quality" 2560 1080 )
res_1152p=( "Quality" 2048 1152 )
res_1440p=( "Quality" 2560 1440 )
res_1440p219=( "Quality" 3440 1440 )
res_1800p=( "Quality" 3200 1800 )
res_2160p=( "Quality" 3840 2160 )
res_2160p219=( "Quality" 5120 2160 )
res_2304p=( "Quality" 4096 2304 )
res_2880p=( "Enthusiast" 5120 2880 )
res_4320p=( "Enthusiast" 7680 4320 )
res_4608p=( "Enthusiast" 8192 4608 )
res_5760p=( "Enthusiast" 10240 5760 )
res_7200p=( "Enthusiast" 12800 7200 )
res_8640p=( "Enthusiast" 15360 8640 )
res_9216p=( "Enthusiast" 16384 9216 )

std_respack () {
	gameName=$1
	params=( "$@" )
	rest=( "${params[@]:1}" )
	
	echo -e "${GREEN}[Building] ${BCYAN}$gameName ${NC}for ${rest[@]}"
	for arrg in "${rest[@]}"
	do
		resvarname="res_${arrg}[@]"
		if [ -v "$resvarname" ]; then
			resdata=( "${!resvarname}" )
			prefix="${resdata[0]}"
			subparams=( "${resdata[@]:1}" )
						
			inFolder="Source/$gameName"
			outFolder="${gameName}_${arrg}"
			if [ -n "$prefix" ]; then
				outFolder="$prefix/$outFolder"
			fi
			
			#width="${subparams[0]}"
			#height="${subparams[1]}"
			#echo "$arrg w: $width h: $height inFolder: $inFolder outFolder: $outFolder"
			build_dir "$inFolder" "$outFolder" "${subparams[@]}"
		elif [ -n "$arrg" ]; then #only if requested resolution name not empty (which happens when you remove array elem naively)
			echo -e "${RED}$arrg resolution not defined, define it in build.sh"
			exit 1
		fi
	done
}

res16by9=( "360p" "480p" "540p" "576p" "720p" "768p" "900p" "1080p" "1152p" "1440p" "1800p" "2160p" "2304p" "2880p" "4320p" "4608p" "5760p" "7200p" "8640p" "9216p" )
res21by9=( "1080p219" "1440p219" "2160p219" )
just720p=( "720p" )
just1080p=( "1080p" )

std_respack "AdventureTimeEtDBIDK" "${res16by9[@]/$just1080p}"
std_respack "AdventureTimeFJI" "${res16by9[@]/$just720p}"
std_respack "AquaTV" "${res16by9[@]/$just720p}"
std_respack "BatmanArkham" "${res16by9[@]/$just720p}"
std_respack "Bayonetta" "${res16by9[@]/$just720p}"
std_respack "Bayonetta2" "${res16by9[@]/$just720p}"
std_respack "Ben10Omniverse" "${res16by9[@]/$just720p}"
std_respack "BreathOfTheWild" "${res16by9[@]/$just720p}" "${res21by9[@]}"
std_respack "Brunswick" "${res16by9[@]/$just720p}"
std_respack "CaptainToad" "${res16by9[@]/$just720p}" "${res21by9[@]}"
std_respack "ChimpuzzlePro" "${res16by9[@]/$just720p}"
std_respack "ChompyChompChompParty" "${res16by9[@]/$just720p}"
std_respack "CitizensOfEarth" "${res16by9[@]/$just720p}"
std_respack "ColorSplash" "${res16by9[@]/$just720p}"
std_respack "DuckTalesRemastered" "${res16by9[@]/$just1080p}"
std_respack "ElectronicSuperJoyGrooveCity" "${res16by9[@]/$just1080p}"
std_respack "FASTRacingNEO" "${res16by9[@]/$just720p}"
std_respack "FamilyTennisSP" "${res16by9[@]/$just720p}"
std_respack "FistoftheNorthStar" "${res16by9[@]/$just720p}"
std_respack "FrenchyBird" "${res16by9[@]/$just720p}"
std_respack "GhostBladeHD" "${res16by9[@]/$just720p}"
std_respack "GhostlyAdventures" "${res16by9[@]/$just720p}"
std_respack "GhostlyAdventures2" "${res16by9[@]/$just720p}"
std_respack "Guacamelee" "${res16by9[@]/$just720p}"
std_respack "HyruleWarriors" "${res16by9[@]/$just720p}"
std_respack "InfinityRunner" "${res16by9[@]/$just720p}"
std_respack "KamenRider" "${res16by9[@]/$just720p}"
std_respack "KickandFennick" "${res16by9[@]/$just720p}"
std_respack "KirbyRainbowCurse" "${res16by9[@]/$just720p}"
std_respack "KungFuPanda" "${res16by9[@]/$just720p}"
std_respack "MarioKart8" "${res16by9[@]/$just720p}" "${res21by9[@]}"
std_respack "MarioSonicRio" "${res16by9[@]/$just720p}"
std_respack "MarioSonicSochi" "${res16by9[@]/$just720p}"
std_respack "MarioTennis" "${res16by9[@]/$just720p}"
std_respack "MightyNumber9" "${res16by9[@]/$just720p}"
std_respack "MonsterHunter3Ultimate" "${res16by9[@]/$just1080p}"
std_respack "NBA2K13" "${res16by9[@]/$just720p}"
std_respack "NewSuperMarioBrosU" "${res16by9[@]/$just720p}"
std_respack "NinjaGaiden3RE" "${res16by9[@]/$just720p}"
std_respack "NintendoLand" "${res16by9[@]/$just720p}"
std_respack "OnePiece" "${res16by9[@]/$just720p}"
std_respack "PaperMonstersRecut" "${res16by9[@]/$just720p}"
std_respack "PhineasFerb" "${res16by9[@]/$just720p}"
std_respack "Pikmin3" "${res16by9[@]/$just720p}"
std_respack "PokkenTournament" "${res16by9[@]/$just720p}"
std_respack "ProjectZero" "${res16by9[@]/$just720p}"
std_respack "SanatoryHallways" "${res16by9[@]/$just720p}"
std_respack "ScribblenautsUnlimited" "${res16by9[@]/$just720p}"
std_respack "ScribblenautsUnmasked" "${res16by9[@]/$just720p}"
std_respack "Severed" "${res16by9[@]/$just720p}"
std_respack "ShovelKnight" "${res16by9[@]/$just1080p}"
std_respack "SonicBoom" "${res16by9[@]/$just720p}"
std_respack "SonicLostWorld" "${res16by9[@]/$just720p}" "${res21by9[@]}"
std_respack "Splatoon" "${res16by9[@]/$just720p}" "${res21by9[@]}"
std_respack "SpongeBob" "${res16by9[@]/$just720p}"
std_respack "StarFoxGuard" "${res16by9[@]/$just720p}"
std_respack "StarFoxZero" "${res16by9[@]/$just720p}"
std_respack "SuperMario3DWorld" "${res16by9[@]/$just720p}" "${res21by9[@]}"
std_respack "SuperSmashBros" "${res16by9[@]/$just1080p}"
std_respack "TNTRacers" "${res16by9[@]/$just1080p}"
std_respack "Tekken" "${res16by9[@]/$just720p}"
std_respack "Tengami" "${res16by9[@]/$just720p}"
std_respack "TokyoMirage" "${res16by9[@]/$just720p}"
std_respack "TropicalFreeze" "${res16by9[@]/$just720p}" "${res21by9[@]}"
std_respack "TurboSuperStuntSquad" "${res16by9[@]/$just720p}"
std_respack "TwilightPrincessHD" "${res16by9[@]/$just1080p}"
std_respack "WarriorsOrochi3" "${res16by9[@]/$just720p}"
std_respack "WindWakerHD" "${res16by9[@]/$just1080p}" "${res21by9[@]}"
std_respack "Wipeout3" "${res16by9[@]/$just720p}"
std_respack "WipeoutCreate" "${res16by9[@]/$just720p}"
std_respack "Wonderful101" "${res16by9[@]/$just720p}"
std_respack "WoollyWorld" "${res16by9[@]/$just720p}" "${res21by9[@]}"
std_respack "XenobladeX" "${res16by9[@]/$just720p}" "${res21by9[@]}"
echo -e "${NC}"
