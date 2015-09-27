# PagingViewController

## 利用方法
1. PagingViewController/PagingViewControllerLibにある3つファイルをコピペ
	- PagingViewController.swift
	- PagingDataController.swift
	- PagingCellViewController.swift
	<br /><br />
	
	
1. PagingCellViewControllerを継承したクラスをつくる
	これが各ページになります。
	最低限、
	
	```swift
	override func setDataObject(dataObject: AnyObject?) {}
	```
	
	をoverrideして、受け取ったdataObjectを適切にキャストしてフィールドとして保存してください
	その他は通常通りで、特殊な処理を書く必要はありません。
	<br />
	
1. PagingDataControllerを継承したクラスをつくる
	これが全てのページを管理するクラスのサポートをします。
	最低限、
	
	```swift
	override func instanciateViewControllerAtIndex(index: Int) -> PagingCellViewController? {}
	```
	
	をoverrideして、indexに対応した、PagingCellViewControllerを継承したクラスのインスタンスを生成してreturnしてください。
	indexは何ページ目かを示します(0〜)
	<br />
	
1. PagingViewControllerを継承したクラスをつくる
	これが全てのページをsubViewとしてもつViewControllerクラスになります。UIViewControllerを継承しています。
	最低限、PagingDataControllerを継承したクラスのインスタンスを作成して、setupWithDataControllerを実行する必要があります。
	<br /><br />
	
1. これで最低限のページング処理を実現できます！
	
