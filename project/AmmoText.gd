extends RichTextLabel

func update_ammo(ammo, max_ammo):
	bbcode_text = "[shake][center]" + String(ammo) + "/" + String(max_ammo)
