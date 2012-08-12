//ImageJ macros for managing renders
//Note there are issues with using these scripts in ImageJ versions later than 1.44 (due to changes in handling of transparency)
//ImageJ version 1.44 is known to work correctly.

//Key resource arrays
//Arrays for LUT/palette
var rs=newArray(0, 238, 239, 240, 241, 242, 243, 244, 245, 246, 168, 184, 200, 216, 232, 252, 52, 68, 88, 108, 132, 156, 176, 204, 48, 64, 80, 96, 120, 148, 176, 204, 100, 116, 104, 124, 152, 184, 212, 244, 132, 88, 112, 136, 160, 188, 204, 220, 236, 252, 252, 252, 252, 76, 96, 116, 136, 156, 176, 196, 68, 96, 128, 156, 184, 212, 232, 252, 252, 252, 32, 64, 84, 108, 128, 148, 168, 184, 196, 212, 8, 16, 32, 48, 64, 84, 104, 128, 64, 44, 60, 80, 104, 128, 152, 180, 16, 32, 56, 76, 96, 120, 152, 184, 32, 56, 80, 88, 104, 124, 140, 160, 76, 96, 116, 136, 164, 184, 204, 212, 224, 236, 80, 100, 120, 140, 160, 184, 36, 48, 64, 80, 100, 132, 172, 212, 48, 64, 88, 104, 120, 140, 160, 188, 0, 0, 0, 0, 0, 24, 56, 88, 128, 188, 16, 24, 40, 52, 80, 116, 156, 204, 172, 212, 252, 252, 252, 252, 252, 252, 72, 92, 112, 140, 168, 200, 208, 232, 60, 92, 128, 160, 196, 224, 252, 252, 252, 252, 252, 252, 252, 252, 204, 228, 252, 252, 252, 252, 8, 12, 20, 28, 40, 56, 72, 100, 92, 108, 124, 144, 224, 200, 180, 132, 88, 16, 32, 32, 36, 40, 44, 48, 72, 100, 216, 96, 68, 76, 108, 144, 176, 210, 252, 252, 252, 252, 252, 252, 252, 64, 255, 48, 64, 80, 255, 148, 247, 248, 249, 250, 251, 252, 253, 254, 255, 255);
var gs=newArray(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 168, 184, 200, 216, 232, 252, 60, 76, 96, 116, 140, 160, 184, 208, 44, 60, 76, 92, 120, 148, 176, 204, 100, 116, 80, 104, 132, 160, 188, 220, 132, 4, 16, 32, 56, 84, 104, 132, 156, 188, 208, 232, 252, 40, 60, 88, 116, 136, 156, 180, 24, 44, 68, 96, 120, 156, 184, 212, 248, 252, 4, 20, 28, 44, 56, 72, 92, 108, 128, 148, 52, 64, 80, 96, 112, 132, 148, 168, 64, 68, 88, 104, 124, 148, 176, 204, 52, 72, 96, 116, 136, 164, 192, 220, 24, 28, 80, 52, 64, 84, 108, 128, 40, 52, 68, 84, 96, 112, 128, 148, 168, 188, 28, 40, 56, 76, 100, 136, 40, 52, 64, 80, 100, 132, 172, 212, 48, 44, 64, 76, 88, 104, 136, 168, 24, 36, 52, 72, 96, 120, 144, 168, 196, 224, 64, 80, 96, 112, 140, 172, 204, 240, 52, 52, 52, 100, 144, 184, 216, 244, 20, 44, 68, 100, 136, 176, 184, 208, 0, 0, 0, 0, 0, 0, 0, 80, 108, 136, 164, 192, 220, 252, 136, 144, 156, 176, 196, 216, 24, 36, 52, 68, 92, 120, 152, 172, 156, 176, 200, 224, 244, 236, 220, 188, 152, 16, 32, 68, 72, 76, 80, 84, 100, 132, 244, 128, 96, 24, 44, 72, 108, 146, 60, 84, 104, 124, 148, 172, 196, 0, 0, 48, 64, 80, 255, 148, 0, 0, 0, 0, 0, 0, 0, 0, 0, 255);
var bs=newArray(255, 238, 239, 240, 241, 242, 243, 244, 245, 246, 168, 184, 200, 216, 232, 252, 72, 92, 112, 132, 152, 172, 196, 220, 4, 12, 20, 28, 64, 100, 132, 168, 100, 116, 44, 72, 92, 120, 148, 176, 132, 16, 32, 52, 76, 108, 124, 144, 164, 192, 0, 60, 128, 0, 8, 28, 56, 80, 108, 136, 0, 4, 8, 16, 24, 32, 16, 0, 128, 192, 0, 8, 16, 28, 40, 56, 76, 88, 108, 128, 0, 0, 4, 4, 12, 20, 28, 44, 64, 32, 48, 60, 76, 92, 108, 124, 24, 44, 72, 88, 108, 136, 168, 200, 0, 0, 80, 12, 24, 44, 64, 88, 16, 24, 40, 56, 64, 80, 96, 112, 128, 148, 4, 20, 40, 64, 96, 136, 68, 84, 100, 116, 136, 164, 192, 224, 48, 144, 172, 196, 224, 252, 252, 252, 108, 132, 160, 184, 212, 220, 232, 240, 252, 252, 96, 108, 120, 132, 160, 192, 220, 252, 52, 52, 52, 88, 124, 160, 200, 236, 112, 140, 168, 196, 224, 248, 255, 252, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 4, 0, 48, 100, 152, 88, 104, 124, 140, 164, 188, 216, 224, 52, 64, 76, 92, 252, 248, 236, 216, 172, 16, 32, 112, 116, 120, 124, 128, 144, 168, 252, 164, 140, 8, 24, 52, 84, 126, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 148, 247, 248, 249, 250, 251, 252, 253, 254, 255, 255);
var r=Array.copy(rs);
var g=Array.copy(gs);
var b=Array.copy(bs);

//Minimum and maximum of colour ranges to keep in the final 8bpp image
var rr1=newArray(198, 80, 70);
var rr2=newArray(205, 87, 79);

var maxd=48;

//Loop through palette and set excluded colours to zero
for (i=0; i<lengthOf(r); i++) {
	use=false;
	for (j=0; j<lengthOf(rr1); j++) {
		if (i>=rr1[j] && i<=rr2[j]) {
			use=true;
		}
	}
	if (use==false) {
		r[i]=0;
		g[i]=0;
		b[i]=0;
	}
}

//8bpp-ize renders
//Recursively converts all images in a folder which match a certain naming scheme to 8bpp
//The user specifies the target folder. The resulting images are saved to a parallel folder with the same name but appended with "8bpp"
macro "8bpp-ize Renders [q]" {
	path=getDirectory("");

	recursiveModify(path);
}

//The actual recursive modify function
function recursiveModify(path) {
	files=getFileList(path);
	for (i=0; i<lengthOf(files); i++) {
		if (File.isDirectory(""+path+files[i])==true) {
			recursiveModify(""+path+files[i]);
		} else if (startsWith(files[i], "64m")==true || startsWith(files[i], "256m")==true || startsWith(files[i], "128m")==true) {
			open(""+path+files[i]);
			if (bitDepth()!=8) {
				convertTo8Bit();
				//Replace accepted colour ranges to minimum brightness shade
				for (j=0; j<lengthOf(rr1); j++) {
					changeValues(rr1[j], rr2[j], rr1[j]);
				}
				res=getImageID();
				wr=getWidth();
				hr=getHeight();
				//Save images if it differs from the existing image or there is no pre-existing image
				if (File.exists(""+path+"8bpp"+File.separator)==false) {
					File.makeDirectory(""+path+"8bpp"+File.separator);
				} else {
					if (File.exists(""+path+"8bpp"+File.separator+files[i])==true) {
						open(""+path+"8bpp"+File.separator+files[i]);
						old=getImageID();
						wo=getWidth();
						ho=getHeight();
						if (wo==wr && hr==ho) {
							selectImage(res);
							run("Select All");
							run("Copy");
							setPasteMode("Difference");
							selectImage(old);
							run("Select All");
							run("Paste");
							getRawStatistics(area, mean, min, max);
							close();
							selectImage(res);
							if (max!=0) {
								saveAs("PNG", ""+path+"8bpp"+File.separator+files[i]);
							}
						} else {
							saveAs("PNG", ""+path+"8bpp"+File.separator+files[i]);					
						}
					} else {
						saveAs("PNG", ""+path+"8bpp"+File.separator+files[i]);					
					}
				}
			}
			close();
		}
	}
}

//Function for 8bpp conversion
function convertTo8Bit() {
	//Loop over all pixels
	w=getWidth();
	h=getHeight();
	for (x=0; x<w; x++) {
		showProgress(x/w);
		for (y=0; y<h; y++) {
			v=getPixel(x, y);
			rp=(v>>16)&0xff;
			gp=(v>>8)&0xff;
			bp=(v>>0)&0xff;

			index=0;
			//Select index nearest to the current pixel
			d=256*256;
			if (rp!=255 || gp!=255 || bp!=255) {
				for (i=0; i<255; i++) {
					di=pow(pow(rp-r[i], 2)+pow(gp-g[i], 2)+pow(bp-b[i], 2), 0.5);
					if (di<d) {
						d=di;
						index=i;
					}
				}
			}
			//Set the new pixel value
			if (d>maxd) {
				index=0;
			}
			vn=(index&0xff)<<16+(index&0xff)<<8+(index&0xff)<<0;
			setPixel(x, y, vn);
		}
	}
	//Convert to 8bpp
	//Note 8bpp with a look up table (lut) == paletted 8bpp colour image
	run("8-bit");
	setLut(rs, gs, bs);
}
