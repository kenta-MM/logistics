# github branches protectetion rule 

Git hub のブランチ保護のルールについて解説します。

## Protect mathing branches
1. Require a pull request before merging
マージをするには必ずプルリクエストが必須にする。
    1. Require approvals
    マージが行われるために必要な承認回数
    2. Dismiss stale pull request approvals when new commits are pushed
    プルリクエストを申請しているブランチに新しくコミットがされた場合、そのプルリクエスト申請を却下する。
    3. Require review from Code Owners
    プルリクエストが影響するコードに所有者が指定されているとき、コード少輔者のレビューを必須にする
    所有者の指定方法については[こちら](https://docs.github.com/ja/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-ownershttps://docs.github.com/ja/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners)
    4. Require approval of the most recent reviewable push
    よくわからん。。。
1. Require status checks to pass before merging
本ブランチにブランチをマージする際に、スタータスを確認し、マージするブランチが指定したステータスになっていればマージを行うようにする。
(例えば、作業ブランチからmainブランチにマージする際にビルドを行うように設定し、そのビルドが成功の場合のみマージするといった具合)
    1. Require branches to be up to date before merging
    マージをする前にブランチを最新状態にする必要がある。
[詳細はこちら](https://docs.github.com/ja/rest/commits/statuses?apiVersion=2022-11-28)

1. Require conversation resolution before merging
プルリクエスト申請されているものにコメントがされた場合、そのコメントがResolveになるまでマージがされないようにする。
1. Require signed commits
コミットに署名を必須とする。
詳細は[こちら](https://docs.github.com/ja/authentication/managing-commit-signature-verification/signing-commits)
1. Require linear history
履歴の分岐を許さない（よくわからん）
1. Require deployments to succeed before merging
特定の環境へのデプロイが成功したときのみマージする。
1. Lock branch
ロックしたブランチにコミットやブランチの削除を行えなくする。
1. Do not allow bypassing the above settings
よくわからん

## Rules applied to everyone including administrators
1. Allow force pushes
1. Allow deletions