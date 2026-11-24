#!/usr/bin/env bash
# Install 30 Claude Code skills (八字 / 紫微 / 奇门 / 风水 / 塔罗 / 姻缘 / 佛学高僧)
# from their original repositories, pinned to the commits that were reviewed.
#
# Usage:
#   bash install.sh                 # installs into ~/.claude/skills
#   bash install.sh path/to/skills  # e.g. a project's .claude/skills
set -euo pipefail

TARGET="${1:-$HOME/.claude/skills}"
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT
mkdir -p "$TARGET"

# repo  reviewed-commit
REPOS=(
  "FANzR-arch/Numerologist_skills 53ab46e7856e8e07a8de8ea96a2d93ed6694bedf"
  "jinchenma94/bazi-skill         112a5d84cd1a001a0038cafca3be68d93e4c0cc9"
  "Ming-H/yinyuan-skills          b091c8861a148b8260dedfbd06fc10daf7f886fc"
  "xr843/Master-skill             263e8caaa6847a92b064b84e64983f7016a665bf"
  "voidforall/fengshui.skill      a17780098a4a6bfb5336d044d79f96f0151e32fc"
  "daman-ovo-0404/tarot-skill     b69652426f5bcfd37a9294a1c962c0c0b23647a9"
)

fetch() { # fetch <owner/repo> <sha> -> $WORK/<owner_repo>
  local dir="$WORK/${1/\//_}"
  git init -q "$dir"
  git -C "$dir" fetch -q --depth 1 "https://github.com/$1.git" "$2"
  git -C "$dir" -c advice.detachedHead=false checkout -q FETCH_HEAD
}

install_skill() { # install_skill <src dir> <skill name>
  rm -rf "$TARGET/$2"
  cp -R "$1" "$TARGET/$2"
  rm -rf "$TARGET/$2/.git"
  echo "  installed $2"
}

for entry in "${REPOS[@]}"; do
  read -r repo sha <<<"$entry"
  echo "fetching $repo@${sha:0:7}"
  fetch "$repo" "$sha"
done

S="$WORK"
install_skill "$S/FANzR-arch_Numerologist_skills/ziwei-doushu" ziwei-doushu
install_skill "$S/FANzR-arch_Numerologist_skills/qimen-dunjia" qimen-dunjia
install_skill "$S/FANzR-arch_Numerologist_skills/bazi"         bazi-numerologist
install_skill "$S/jinchenma94_bazi-skill"                      bazi-paipan
install_skill "$S/Ming-H_yinyuan-skills"                       yinyuan
install_skill "$S/daman-ovo-0404_tarot-skill"                  tarot
for s in bazi-mingli fengshui-master city-wuxing-map; do
  install_skill "$S/voidforall_fengshui.skill/skills/$s" "$s"
done
# ~34MB of example city data, not needed to use the skill
rm -rf "$TARGET/city-wuxing-map/examples"
for d in "$S"/xr843_Master-skill/plugin/skills/*/; do
  install_skill "$d" "$(basename "$d")"
done

# Two upstream skills are both named "bazi"; give each a unique name.
for n in bazi-numerologist bazi-paipan; do
  sed -i.bak "s/^name: bazi\$/name: $n/" "$TARGET/$n/SKILL.md" && rm -f "$TARGET/$n/SKILL.md.bak"
done

echo
echo "Done: skills installed in $TARGET"
echo "Optional Python deps for the charting scripts:"
echo "  pip install 'lunar_python>=1.4.8,<2' opencc-python-reimplemented pypinyin pyyaml requests 'shapely>=2,<3' tzdata"
