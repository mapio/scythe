# current version

export SCYTHE_VERSION=0.6.0

# tool dirs

export CONFS_DIR="$(realpath -eL $SCYTHE_HOME/../confs)"
export EXERCISES_DIR="$(realpath -eL $SCYTHE_HOME/../exercises)"
export HARVESTS_DIR="$(realpath -eL $SCYTHE_HOME/../harvests)"

# user confs

if [ ! -r "$CONFS_DIR/confs.sh" ]; then
	echo "scythe: missing user confs '$CONFS_DIR/confs.sh'" >&2
	exit 1
fi
source "$CONFS_DIR/confs.sh"

# local dirs

export BASE_BUNDLE="$CONFS_DIR/basebundle"
export EXERCISES="$CONFS_DIR/${SCYTHE_SESSION_ID}.txt"
export REGISTERED_UIDS="$CONFS_DIR/${SCYTHE_SESSION_ID}.tsv"
export TM_SETTINGS="$CONFS_DIR/${SCYTHE_SESSION_ID}-tm.py"
export ST_SETTINGS="$CONFS_DIR/${SCYTHE_SESSION_ID}-st.py"

export HARVEST="$HARVESTS_DIR/$SCYTHE_SESSION_ID"
export REWEBDIS_DATA_DIR="$HARVESTS_DIR/rewebdis"

# remote endpoint

export REMOTE_ENDPOINT="http://$SCYTHE_SERVER/tm/$SCYTHE_TESTER_ID/$SCYTHE_SESSION_ID/"

# functions

suite_latest_version() {
	local last_release_url=$(curl -sLo /dev/null -w '%{url_effective}' "https://github.com/scythe-suite/$1/releases/latest")
	echo "${last_release_url##*/}"
}

convert_mds() {
	local src_dir="$1"
	local dst_dir="$2"
	local name

	for doc in "$src_dir"/*.md; do
		name="${doc##*/}"
		name="${name%.md}"
		md2html "$doc" "$name" "$dst_dir/${name}.html"
	done
}
