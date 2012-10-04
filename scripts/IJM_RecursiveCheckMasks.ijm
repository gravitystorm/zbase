path=getDirectory("");
recursiveCheck(path);

var validStarts=newArray("64_", "128_", "256_");

function recursiveCheck(path) {
	files=getFileList(path);
	for (i=0; i<lengthOf(files); i++) {
		if (File.isDirectory(path+files[i])==true) {
			recursiveCheck(""+path+files[i]);
		} else {
			if (File.exists(path+"8bpp")==true) {
				valid=false;
				for (j=0; j<lengthOf(validStarts); j++) {
					if (startsWith(files[i], validStarts[j])==true) {
						valid=true;
					}
				}
				if (valid==true) {
					tiw=substring(files[i], 0, lengthOf(files[i])-lengthOf("_0000.png"));
					tin=substring(files[i], lengthOf(tiw), lengthOf(files[i]));
					if (File.exists(path+"8bpp"+File.separator+tiw+"m"+tin)==false) {
						print(path+"8bpp"+File.separator+tiw+"m"+tin+"\tmissing");
					} else {
						open(path+"8bpp"+File.separator+tiw+"m"+tin);
						if (bitDepth()!=8) {
							print(path+"8bpp"+File.separator+tiw+"m"+tin+"\tbitdepth");
							close();
						} else {
							wm=getWidth();
							hm=getHeight();
							close();
							open(path+tiw+tin);
							wn=getWidth();
							hn=getHeight();
							close();
							if (wn!=wm) {
								print(path+"8bpp"+File.separator+tiw+"m"+tin+"\twidth");
							}
							if (hn!=hm) {
								print(path+"8bpp"+File.separator+tiw+"m"+tin+"\twidth");
							}
						}
					}
				}
			}
		}
	}
}
