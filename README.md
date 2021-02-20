## 動機

為了加快開發者建置環境的時間，提供一鍵式的初始化安裝腳本；讓所有Mac的用戶無腦地使用。

## 如何使用  

請依序執行以下指令  
```
curl
cd 
bash ./awesome-init.sh  
```  
安裝完成後，請再確認以下設定：

### iTerm2字型設定

進入iTerm2 > Preferences > Profiles > Text  
點 Change Font 選 Hack Nerd Font  

### Powerlevel10k設定theme  

基本上第一次進入就會要求你設定，如果想重新設定請執行：  
```
p10k configure
```  

### Neovim的Plugin

執行nvim進入Neovim，再輸入:PlugInstall即可快速安裝所有Vim的Plugin

## 備註  

安裝virtualbox時，需要去隱私權那邊開啟允許權限。還有，開啟iTerm時會有Warning的話....。最後記得去LaunchPad啟動Stats來監控你的電腦資源。