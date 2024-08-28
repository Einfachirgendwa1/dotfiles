do_find() {
	find /usr/share/icons/Papirus/64x64/apps -iname "$1.svg"
}

out=$(do_find "$1")

if [[ -z "$out" ]]; then
	out=$(do_find "${1%-*}")
fi

printf "%s" "$out"
