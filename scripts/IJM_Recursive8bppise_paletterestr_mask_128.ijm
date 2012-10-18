//ImageJ macros for managing renders
//Note there are issues with using these scripts in ImageJ versions later than 1.44 (due to changes in handling of transparency)
//ImageJ version 1.44 is known to work correctly.

//Key resource arrays
//Arrays for LUT/palette
var r=newArray(0, 238, 239, 240, 241, 242, 243, 244, 245, 246, 168, 184, 200, 216, 232, 252, 52, 68, 88, 108, 132, 156, 176, 204, 48, 64, 80, 96, 120, 148, 176, 204, 100, 116, 104, 124, 152, 184, 212, 244, 132, 88, 112, 136, 160, 188, 204, 220, 236, 252, 252, 252, 252, 76, 96, 116, 136, 156, 176, 196, 68, 96, 128, 156, 184, 212, 232, 252, 252, 252, 32, 64, 84, 108, 128, 148, 168, 184, 196, 212, 8, 16, 32, 48, 64, 84, 104, 128, 64, 44, 60, 80, 104, 128, 152, 180, 16, 32, 56, 76, 96, 120, 152, 184, 32, 56, 80, 88, 104, 124, 140, 160, 76, 96, 116, 136, 164, 184, 204, 212, 224, 236, 80, 100, 120, 140, 160, 184, 36, 48, 64, 80, 100, 132, 172, 212, 48, 64, 88, 104, 120, 140, 160, 188, 0, 0, 0, 0, 0, 24, 56, 88, 128, 188, 16, 24, 40, 52, 80, 116, 156, 204, 172, 212, 252, 252, 252, 252, 252, 252, 72, 92, 112, 140, 168, 200, 208, 232, 60, 92, 128, 160, 196, 224, 252, 252, 252, 252, 252, 252, 252, 252, 204, 228, 252, 252, 252, 252, 8, 12, 20, 28, 40, 56, 72, 100, 92, 108, 124, 144, 224, 200, 180, 132, 88, 16, 32, 32, 36, 40, 44, 48, 72, 100, 216, 96, 68, 76, 108, 144, 176, 210, 252, 252, 252, 252, 252, 252, 252, 64, 255, 48, 64, 80, 255, 148, 247, 248, 249, 250, 251, 252, 253, 254, 255, 255);
var g=newArray(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 168, 184, 200, 216, 232, 252, 60, 76, 96, 116, 140, 160, 184, 208, 44, 60, 76, 92, 120, 148, 176, 204, 100, 116, 80, 104, 132, 160, 188, 220, 132, 4, 16, 32, 56, 84, 104, 132, 156, 188, 208, 232, 252, 40, 60, 88, 116, 136, 156, 180, 24, 44, 68, 96, 120, 156, 184, 212, 248, 252, 4, 20, 28, 44, 56, 72, 92, 108, 128, 148, 52, 64, 80, 96, 112, 132, 148, 168, 64, 68, 88, 104, 124, 148, 176, 204, 52, 72, 96, 116, 136, 164, 192, 220, 24, 28, 80, 52, 64, 84, 108, 128, 40, 52, 68, 84, 96, 112, 128, 148, 168, 188, 28, 40, 56, 76, 100, 136, 40, 52, 64, 80, 100, 132, 172, 212, 48, 44, 64, 76, 88, 104, 136, 168, 24, 36, 52, 72, 96, 120, 144, 168, 196, 224, 64, 80, 96, 112, 140, 172, 204, 240, 52, 52, 52, 100, 144, 184, 216, 244, 20, 44, 68, 100, 136, 176, 184, 208, 0, 0, 0, 0, 0, 0, 0, 80, 108, 136, 164, 192, 220, 252, 136, 144, 156, 176, 196, 216, 24, 36, 52, 68, 92, 120, 152, 172, 156, 176, 200, 224, 244, 236, 220, 188, 152, 16, 32, 68, 72, 76, 80, 84, 100, 132, 244, 128, 96, 24, 44, 72, 108, 146, 60, 84, 104, 124, 148, 172, 196, 0, 0, 48, 64, 80, 255, 148, 0, 0, 0, 0, 0, 0, 0, 0, 0, 255);
var b=newArray(255, 238, 239, 240, 241, 242, 243, 244, 245, 246, 168, 184, 200, 216, 232, 252, 72, 92, 112, 132, 152, 172, 196, 220, 4, 12, 20, 28, 64, 100, 132, 168, 100, 116, 44, 72, 92, 120, 148, 176, 132, 16, 32, 52, 76, 108, 124, 144, 164, 192, 0, 60, 128, 0, 8, 28, 56, 80, 108, 136, 0, 4, 8, 16, 24, 32, 16, 0, 128, 192, 0, 8, 16, 28, 40, 56, 76, 88, 108, 128, 0, 0, 4, 4, 12, 20, 28, 44, 64, 32, 48, 60, 76, 92, 108, 124, 24, 44, 72, 88, 108, 136, 168, 200, 0, 0, 80, 12, 24, 44, 64, 88, 16, 24, 40, 56, 64, 80, 96, 112, 128, 148, 4, 20, 40, 64, 96, 136, 68, 84, 100, 116, 136, 164, 192, 224, 48, 144, 172, 196, 224, 252, 252, 252, 108, 132, 160, 184, 212, 220, 232, 240, 252, 252, 96, 108, 120, 132, 160, 192, 220, 252, 52, 52, 52, 88, 124, 160, 200, 236, 112, 140, 168, 196, 224, 248, 255, 252, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 4, 0, 48, 100, 152, 88, 104, 124, 140, 164, 188, 216, 224, 52, 64, 76, 92, 252, 248, 236, 216, 172, 16, 32, 112, 116, 120, 124, 128, 144, 168, 252, 164, 140, 8, 24, 52, 84, 126, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 148, 247, 248, 249, 250, 251, 252, 253, 254, 255, 255);

var maxd=48;

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

	//Work out which colour to use in the 8bpp image
	if (File.exists(path+"recolours.txt")==true) {
		//load and parse recolour information
		tvals=split(File.openAsString(path+"recolours128.txt"), ",");
		tr0=parseInt(tvals[1]);
	} else {
		//default to company colour recolour
		tr0=201;
	}

	//Setup expected tile sizes (file name prefixes)
	tilews=newArray("64", "128", "256");

	for (i=0; i<lengthOf(files); i++) {
		//For each file check which tilesize it is, based on the format [tilesize]_####.png
		valid=-1;
		for (j=0; j<lengthOf(tilews); j++) {
			if (startsWith(files[i], ""+tilews[j]+"_")==true) {
				valid=j;
			}
		}
		if (File.isDirectory(""+path+files[i])==true) {
			//If the file is a directory recursively process its contents
			recursiveModify(""+path+files[i]);
		} else if (valid!=-1) {
			//Otherwise construct the mask file names, on the format [tilesize]m[version]_####.png
			m1=tilews[valid]+"m_"+substring(files[i], lengthOf(tilews[valid]+1), lengthOf(files[i]));
			m2=tilews[valid]+"m2_"+substring(files[i], lengthOf(tilews[valid]+1), lengthOf(files[i]));
			//Open the m2 mask and process to an 8bpp mask
			open(""+path+m2);
			convertTo8Bit2();

			//Save image, making directory if needed
			if (File.exists(""+path+"8bpp"+File.separator)==false) {
				File.makeDirectory(""+path+"8bpp"+File.separator);
			}
			saveAs("PNG", ""+path+"8bpp"+File.separator+m1);					
			close();
		}
	}
}

//Function for 8bpp conversion if the m2 mask is available
function convertTo8Bit2() {
	run("8-bit");
	//Loop over all pixels
	w=getWidth();
	h=getHeight();
	for (x=0; x<w; x++) {
		showProgress(x/w);
		for (y=0; y<h; y++) {
			v=getPixel(x, y);
			//Set the new pixel value
			if (v<128) {
				index=0;
			} else {
				index=tr0;
			}
			setPixel(x, y, index);
		}
	}
	//Convert to 8bpp
	//Note 8bpp with a look up table (lut) == paletted 8bpp colour image
	setLut(r, g, b);
}
