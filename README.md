# Claude Code 玄学 & 佛学 Skills

一键安装 30 个 Claude Code skill，来自 6 个开源仓库，每个都固定在审查过的版本（commit）上。

## 安装

```bash
git clone https://github.com/Wesleyben-wan/https-github.com-new.git
bash https-github.com-new/install.sh
```

默认装到 `~/.claude/skills/`。如果只想给某个项目用，可以指定目录：

```bash
bash https-github.com-new/install.sh path/to/project/.claude/skills
```

排盘脚本需要的 Python 依赖（可选）：

```bash
pip install 'lunar_python>=1.4.8,<2' opencc-python-reimplemented pypinyin pyyaml requests 'shapely>=2,<3' tzdata
```

## 包含的 skill

| 来源 | Skill |
|---|---|
| [FANzR-arch/Numerologist_skills](https://github.com/FANzR-arch/Numerologist_skills) | `ziwei-doushu` 紫微斗数、`qimen-dunjia` 奇门遁甲、`bazi-numerologist` 八字 |
| [jinchenma94/bazi-skill](https://github.com/jinchenma94/bazi-skill) | `bazi-paipan` 八字排盘 |
| [Ming-H/yinyuan-skills](https://github.com/Ming-H/yinyuan-skills) | `yinyuan` 姻缘测算 |
| [xr843/Master-skill](https://github.com/xr843/Master-skill) | 18 位高僧角色（`master-huineng`、`master-xuanzang` 等）+ `compare-masters`、`master-debate`、`master-curriculum`、`master-help`、`create-master` |
| [voidforall/fengshui.skill](https://github.com/voidforall/fengshui.skill) | `fengshui-master` 风水、`bazi-mingli` 八字、`city-wuxing-map` 城市五行地图 |
| [daman-ovo-0404/tarot-skill](https://github.com/daman-ovo-0404/tarot-skill) | `tarot` 塔罗 |

## 说明

- 上游有两个 skill 都叫 `bazi`，安装时分别改名为 `bazi-numerologist` 和 `bazi-paipan`。
- `city-wuxing-map` 自带约 34MB 示例数据，安装时去掉了，不影响使用。
- Master-skill 只安装 skill 目录，不安装它的 SessionStart 钩子和桌面程序。
- 版权归各原作者所有，本仓库只保存安装脚本，不转载原代码。要升级到上游新版本，修改 `install.sh` 里的 commit 即可，建议先看一下改动。
