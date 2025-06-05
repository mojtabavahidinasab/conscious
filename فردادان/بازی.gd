extends Node
# Project > Project Settings > Globals > Autoload
const نام_پرونده_پیکربندی :String = "پیکربندی_بازی_هوشیار"
const بازی_آسمان_خراش :String = "uid://bs0iulq0ujois"
const بازی_باران :String = "uid://jlkupge2q7lw"
const بازی_بیشتر :String = "uid://bygv262qaeox5"
const بازی_توپ_و_چوب = "uid://ddmy8ea3w8cy4"
const بازی_تصویری :String = "uid://d1poxmn22l162"
const بازی_رنگومتن :String = "uid://bxs5u82yt08gx"
const بازی_رودوبرگ :String = "uid://b3ug64v8tex0u"
const بازی_زوجواکه :String = "uid://brogd6ysmgllk"
const بازی_شماره :String = "uid://b75u4y43hgfr6"
const سبک_آفتاب :String = "uid://ckmf8v6was3nc"
const سبک_مهتاب :String = "uid://rdtqwffm1wu7"
const فرتورجاتوپی :String = "uid://dwuq2su0ig0vf"
const فرتورجاتوپی_برگزیده :String = "uid://cv8lmh3j776af"
const فرتورسمت_بالا :String = "uid://c6mlp37ettqn8"
const فرتورسمت_پایین :String = "uid://dj413cfcdltbx"
const فرتورسمت_چپ :String = "uid://dismai0e6hc31"
const فرتورسمت_راست :String = "uid://cw5fmao4fqd3n"
const فرتوربرگ_سبز :String = "uid://v6sw0yxtg7ug"
const فرتوربرگ_نارنجی :String = "uid://cduptifdc0d7o"
const آوای_دکمه۱ :String = "uid://dlqcdiun4dqpn"
const آوای_دکمه۲ :String = "uid://dic8q2ydkmqam"
const آوای_درست :String = "uid://cm143e5x6u4bu"
const آوای_نادرست :String = "uid://bgfgbdldffuuj"
const آوای_آغازبازی :String = "uid://d255pginxh1j0"
const آوای_آغازشمارشگر :String = "uid://dxemw7754sbf2"
const آوای_پیروزی :String = "uid://jmva5iwhx0g8"
const آوای_باخت :String = "uid://dad328x6ic8k6"
const درباره_بازی :Dictionary = {
	بازی_آسمان_خراش: "روی کوچکترین شماره بزنید",
	بازی_باران: "ریاضی روی هر قطره باران را انجام دهید و نگذارید قطرات به آب دریا برسند",
	بازی_بیشتر: "روی شماره بزرگتر بزنید. اگر برابرند روی برابر بزنید. پنج بار کار درست انجام دهید تا ۱۰ ثانیه به زمانتان افزوده شود",
	بازی_توپ_و_چوب: "مکان چوب‌ها را به یاد بسپارید. مقصد توپ را به درستی بگویید تا امتیاز بگیرید",
	بازی_تصویری: "خانه‌های روشن شده را به یاد بسپارید.",
	بازی_رنگومتن: "آیا رنگ متن پایینی، همان چیزی است که متن بالایی می‌گویید؟ بلی؟ خیر؟",
	بازی_رودوبرگ: "اگر برگ‌ها سبز هستند، در جهتی که برگ‌ها اشاره می‌کنند بکشید. اگر برگ‌ها نارنجی هستند، در جهتی که جریان دارند بکشید.",
	بازی_زوجواکه: "آیا شماره متن بالایی زوج است؟ آیا واج متن پایینی واکه (مصوت) است؟",
	بازی_شماره: "شماره را به یاد بسپارید."
} 
static var سبک_برگزیده :Theme = preload(سبک_آفتاب)
static var امتیاز :int = 0
static var پخش_آوا = true
