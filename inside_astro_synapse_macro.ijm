dir1 = getDir("choose tiff directory");

list1 = getFileList(dir1);
list1 = Array.sort(list1);

dir2 = getDir("choose binary excitatory directory");

list2 = getFileList(dir2);
list2 = Array.sort(list2);

dir4 = dir2 + File.separator + "excitatory_synapses"

File.makeDirectory(dir4);

dir3 = getDir("choose binary inhibitory directory");

list3 = getFileList(dir3);
list3 = Array.sort(list3);

dir5 = dir3 + File.separator + "inhibitory_synapses"

File.makeDirectory(dir5);

for (i = 0; i < list1.length; i++) {
	//setBatchMode(true);
	currentImage = list1[i];
	open(dir1 + File.separator + currentImage);
	setTool("freehand");
	//setBatchMode("exit and display");
	waitForUser("Draw freehand ROI around area to keep then click OK");
	roiManager("add");
	run("Measure");
	saveAs("Results", dir1 + "ROIs_microns.csv");
	close();
}

for (i = 0; i < list1.length; i++) {
	//setBatchMode(true);
	currentImage = list2[i];
	open(dir2 + File.separator + currentImage);
	//setBatchMode("exit and display");
	roiManager("select", i);
	run("Analyze Particles...", "  show=Overlay exclude summarize");
	saveAs("Tiff", dir4 + File.separator + File.getNameWithoutExtension(dir2 + File.separator + currentImage) + "excitatory_synapses_ROI.tif");
}

saveAs("Results", dir1 + "excitatorySynapses_countFinal.csv");
run("Close");

for (i = 0; i < list1.length; i++) {
	//setBatchMode(true);
	currentImage = list3[i];
	open(dir3 + File.separator + currentImage);
	//setBatchMode("exit and display");
	roiManager("select", i);
	run("Analyze Particles...", "  show=Overlay exclude summarize");
	saveAs("Tiff", dir5 + File.separator + File.getNameWithoutExtension(dir3 + File.separator + currentImage) + "inhibitory_synapses_ROI.tif");
}

saveAs("Results", dir1 + "inhibitorySynapses_countFinal.csv");
run("Close");



run("Close All");

