# SSI 原稿テンプレート

計測自動制御学会 (SICE) システム・情報部門 学術講演会 (SSI) の原稿を, pLaTeX と VSCode で書くためのテンプレートです.
講義資料 [共通資料 LaTeX による原稿作成](https://yakagika.github.io/lectures/latex.html) で使います. 導入と書き方の詳しい説明は, 講義資料を読んでください.

## 使い方

1. このページの **Use this template** から **Create a new repository** を選び, 自分のアカウントに **private** のリポジトリを作ります.
2. 作った自分のリポジトリを clone します (このテンプレートを直接 clone しないでください).
3. VSCode でリポジトリのディレクトリを開き, `paper.tex` を保存すると `paper.pdf` ができます.

TeX Live と, VSCode の拡張機能 LaTeX Workshop が必要です.

## ファイル

| ファイル | 内容 |
|---|---|
| `paper.tex` | 原稿 (はじめは見本の骨組み) |
| `references.bib` | 参考文献の一覧 |
| `figure/` | 図を置くディレクトリ |
| `SICE-SSI.sty` | SSI の様式 |
| `sice-ssi.bst` | 参考文献を SSI の推奨形式に整える設定 |
| `.latexmkrc` | platex, pbibtex, dvipdfmx でビルドする latexmk の設定 |
| `.vscode/settings.json` | 保存したらビルドする LaTeX Workshop の設定 |
| `.gitignore` | 中間ファイルと原稿の PDF を記録しない設定 |

## SSI の配布版との違い

- 図を PNG でも読み込めるように, `graphicx` の指定を `dvips` から `dvipdfmx` に変えています.
- 参考文献を `references.bib` に書き, `sice-ssi.bst` で SSI の見本が推奨する形式に整えます.
- ビルドの設定 (`.latexmkrc`, `.vscode/settings.json`) と `.gitignore` を加えています.

## 出典

`SICE-SSI.sty` は, SSI の大会のページの発表要領で配布されているものを, 改変せずに収録しています.
様式と投稿の決まりは年度ごとに変わることがあるので, 投稿の前にその年の大会のページを確認してください.
`sice-ssi.bst` は, TeX Live に含まれる `junsrt.bst` を元に作成しました.
