<h2>ParalymPicker</h2>

<p>Wingle Hotspring Hackathon in 2013 winter</p>

<p>株式会社ウイングルが主催する</p>

<p>プログラミングやUX/UIデザインの経験者向けのハッカソンに参加した際のサービスです.</p>

<p>パラリンピックを応援したいという思いから作成しました.</p>

<p>いくつかの質問を通してユーザが好みそうなパラリンピックの競技を推薦します.</p>

<h2>使い方</h2>

<h3>動作環境</h3>

<p>動作にはnode.jsとnpm、Coffee-Script が必要です.</p>

<p>上記を揃えた後、下記コマンドを入力することで動作環境が整います.</p>

<pre><code>$ git clone https://github.com/seka/ParalymPicker.git
$ npm install
</code></pre>

<p>環境を整えた後、 /config 以下にある sample.json -> test_option.json に変更し、</p>

<p>自分のDBの設定を書き込みます.</p>

<h3>起動確認</h3>

<p>上記の設定が終了後、下記コマンドを入力することで、アプリケーションが動作します.</p>

<pre><code>$ coffee webServer.coffee
</code></pre>
