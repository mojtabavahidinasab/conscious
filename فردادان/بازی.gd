extends Node
# Project > Project Settings > Globals > Autoload
const نام_پرونده_پیکربندی :String = "پیکربندی_بازی_هوشیار"
const بازی‌ها :Dictionary = {
"آسمان خراش": {
		"نشانی": "uid://bs0iulq0ujois",
		"درباره": "روی کوچکترین شماره بزنید",
}, "اشکال": {
	"نشانی": "uid://vvg325p5f6hc",
	"درباره": "آیا شکل کنونی همان شکلی است که پیش‌تر نشان داده شد؟",
}, "باران": {
		"نشانی": "uid://jlkupge2q7lw",
		"درباره": "محاسبه ریاضی روی هر قطره باران را انجام دهید و نگذارید قطرات به آب دریا برسند",
}, "بیشتر": {
		"نشانی": "uid://bygv262qaeox5", 
		"درباره": "روی شماره بزرگتر بزنید. اگر برابرند روی برابر بزنید. پنج بار کار درست انجام دهید تا ۱۰ ثانیه به زمانتان افزوده شود",
}, "توپ": {
		"نشانی": "uid://ddmy8ea3w8cy4",
		"درباره": "مکان چوب‌ها را به یاد بسپارید. مقصد توپ را به درستی بگویید تا امتیاز بگیرید",
}, "تصویری": {
		"نشانی": "uid://d1poxmn22l162",
		"درباره": "خانه‌های روشن شده را به یاد بسپارید."
}, "رنگ و متن": {
		"نشانی": "uid://bxs5u82yt08gx",
		"درباره": "آیا رنگ متن پایینی، همان چیزی است که متن بالایی می‌گویید؟ بلی؟ خیر؟",
}, "رود و برگ": {
		"نشانی": "uid://b3ug64v8tex0u",
		"درباره": "اگر برگ‌ها سبز هستند، در جهتی که برگ‌ها اشاره می‌کنند بکشید. اگر برگ‌ها نارنجی هستند، در جهتی که جریان دارند بکشید.",
}, "زوجواکه": {
		"نشانی": "uid://brogd6ysmgllk",
		"درباره": "آیا شماره متن بالایی زوج است؟ آیا واج متن پایینی واکه (صدادار) است؟",
}, "زوجواکه فردخوان": {
		"نشانی": "uid://brogd6ysmgllk",
		"درباره": "آیا متن نمایش داده شده با قانون همخوانی دارد؟"
}, "شماره": {
		"نشانی": "uid://b75u4y43hgfr6",
		"درباره": "شماره را به یاد بسپارید."
}, "مهاجر": {
		"نشانی": "uid://bgvt0qc8xdwej",
		"درباره": "به سمتی که پرستوی میانی می‌پرد بکشید."
}
}

const سبک_آفتاب :String = "uid://ckmf8v6was3nc"
const سبک_مهتاب :String = "uid://rdtqwffm1wu7"
const فرتورجاتوپی :String = "uid://dwuq2su0ig0vf"
const فرتورجاتوپی_برگزیده :String = "uid://cv8lmh3j776af"
const فرتورسمت_بالا :String = "uid://c6mlp37ettqn8"
const فرتورسمت_پایین :String = "uid://dj413cfcdltbx"
const فرتورسمت_چپ :String = "uid://dismai0e6hc31"
const فرتورسمت_راست :String = "uid://cw5fmao4fqd3n"
const فرتوران :Dictionary = {
"شکل": {
		"دایره": "uid://do4dfusqpxkwi",
		"مربع": "uid://bvxj2qdxqkc6a",
		"مثلث": "uid://c6tptne3efbb7",
		"گل": "uid://ckby8s0hppbsu",
		"ستاره": "uid://bvuflydrsqqrl",
}, "سمت": {
		
},
}
const فرتورطبقه_پایانی :String = "uid://c85iur81xvkiy"
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
static var بازی_درجریان :String = ""
static var سبک_برگزیده :Theme = preload(سبک_آفتاب)
static var امتیاز :int = 0
static var پخش_آوا = true
