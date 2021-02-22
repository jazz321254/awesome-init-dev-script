## 動機

為了加快開發者建置環境的時間，提供一鍵式的初始化安裝腳本；讓所有Mac的用戶無腦地使用。

## 如何使用  

請依序執行以下指令  
```
curl -L https://github.com/jazz321254/awesome-init-dev-script/archive/master.tar.gz | tar xvz
cd awesome-init-dev-script-master
bash ./awesome-init.sh  
```  
安裝完成後，請再確認以下設定：

### Powerlevel10k設定theme  

基本上第一次進入就會要求你設定，如果想重新設定請執行：  
```
p10k configure
```  

### Neovim的Plugin

執行nvim進入Neovim，再輸入:PlugInstall即可快速安裝所有Vim的Plugin

## 備註  

安裝virtualbox時，需要去隱私權那邊開啟允許權限。還有，開啟iTerm時會有Warning的話，要確認是否有開啟Instant prompt模式，還有zsh權限安全問題。最後記得去LaunchPad啟動Stats來監控你的電腦資源。詳細說明可以參考我的[個人網站][1]。

[1]: https://www.jazz321254.com/2021-happy-bag/
