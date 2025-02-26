https://github.com/MSiliunas/US-Lithuanian-Keyboard

```sh
curl -o ~/Library/Keyboard\ Layouts/US-Lithuanian-Alt-Numbers.keylayout https://raw.githubusercontent.com/msiliunas/US-Lithuanian-Keyboard/master/US-Lithuanian-Alt-Numbers.keylayout

cd ~/Library/Keyboard\ Layouts
sed -i '' -e 's/key code="10" output="§"/key code="10" output="`"/g' US-Lithuanian-Alt-Numbers.keylayout
sed -i '' -e 's/key code="10" output="±"/key code="10" output="~"/g' US-Lithuanian-Alt-Numbers.keylayout
```
System Settings > Keyboard layouts > + > renkames Others > Lithuanian (Lithuanian keyboard with numbers) ARBA Lithuanian (US keyboard with Lithuanian letters) > Add
