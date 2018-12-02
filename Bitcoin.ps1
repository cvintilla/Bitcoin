<#
	.DESCRIPTION
		Small Script that gives the latest BTC price from Coinbase

	.EXAMPLE
		.\Bitcoin.ps1 -min 1 -sec 10

	.SYNOPSIS
		Returns BTC price every min or sec requested, defaults to 30 min

	.PARAMETER min
		the number of minutes for the script to refresh price (optional)

	.PARAMETER sec
		the number of seconds for the script to refresh price (optional)
#>

param(
	[Parameter(Mandatory=$false)][int]$sec,
	[Parameter(Mandatory=$false)][int]$min
)

#if no sec, default to 0
if (!($sec)) {
	$sec = 0;
} 

#if no min, default to 0
if (!($min)) {
	$min = 0;
} else {
	$minToSec = (60*$min)
	$sec = ($minToSec + $sec)
}

# if both minutes and seconds are empty
if (!($sec) -and !($min)) {
	# defaults to 30min
	$sec = 1800
}

while (1 -eq 1) {
	Clear-Host
	$data = Invoke-WebRequest -Uri https://api.coinbase.com/v2/prices/BTC-USD/sell -Method Get
	$object = $data | ConvertFrom-Json
	Write-Host $object.data.base
	Write-Host $object.data.currency
	Write-Host $object.data.amount
	Start-Sleep -s $sec
}
