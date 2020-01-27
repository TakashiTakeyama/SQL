### クエリービルダー

DBファサードのtableメソッドを使う  
$users = DB::table('users')->get();  
 ファサード: 正面

return view('user.index', ['users' => $users]);  

クエリビルダーの返り値はstdClassのオブジェクトのインスタンスを配列で返す。

foreach ($users as $user) {
  echo $user->name;
}

テーブルから1カラム/1レコードを取得  

DB::table('users')->('name', 'Jhon')->first();

echo user->name;

### stdClass
- 親クラスがない
- プロパティがない
- メソッドがない
- マジックメソッドがない
- インターフェースがない
メソッドの定義を強制的にすることでクラスの再利用性が高まる。

valueメソッドで一つだけ取得できる
DB::table('users')->('name', 'Jhon')->value('email');

