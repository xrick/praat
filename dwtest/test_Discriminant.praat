# test_Discriminant.praat
# djmw 20110518, 20141030, 20150128

appendInfoLine: "test_Discriminant"

# old format
appendInfoLine: tab$ + "Read Discriminant format 0 from disk"
discriminant[1] = Read from file: "pols_50males_format0.Discriminant"

tableOfReal = Create TableOfReal (Pols 1973): "no"
Formula: "log10(self)"

discriminant[2] = To Discriminant

appendInfoLine: tab$ + "Query old and new Discriminant"
@query: discriminant[1]
@query: discriminant[2]

appendInfoLine: tab$ + "Assert old and new Discriminant classify the same"
@classify: discriminant[1], tableOfReal, 1
@classify: discriminant[2], tableOfReal, 2
assert classify.fc[1] = classify.fc[2]

procedure classify: .discriminant, .tableOfReal, .index
	selectObject: .discriminant, .tableOfReal
	.classificationTable = To ClassificationTable: "yes", "yes"
	.confusion = To Confusion: "no"
	.fc[.index] = Get fraction correct
	assert .fc[.index] -0.74 < 0.00001
	removeObject: .classificationTable, .confusion
endproc

procedure query: .discriminant
	for .ieigen to 3
		.eigenvalue[.ieigen] = Get eigenvalue: .ieigen
	endfor
	.numberOfEigenvectors = Get number of eigenvectors
	.dimension = Get eigenvector dimension
	assert (.eigenvalue[1] - 21.139) < 0.00001
	assert (.eigenvalue[2] - 4.35530) < 0.00001
	assert (.eigenvalue[3] - 0.68289) < 0.00001
	assert .numberOfEigenvectors = 3
	assert .dimension = 3
endproc

removeObject: discriminant[2], tableOfReal, discriminant[1]

appendInfoLine: "test_Discriminant OK"
