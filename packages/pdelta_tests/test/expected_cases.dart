const expectedTestTransformDeleteDeleteKey = '''
del0* del0 : 1:b 2:c 3:d
del0  del0*: 1:b 2:c 3:d
del0* del1 : 2:c 3:d
del0  del1*: 2:c 3:d
del0* del2 : 1:b 3:d
del0  del2*: 1:b 3:d
del0* del3 : 1:b 2:c
del0  del3*: 1:b 2:c
del1* del0 : 2:c 3:d
del1  del0*: 2:c 3:d
del1* del1 : 0:a 2:c 3:d
del1  del1*: 0:a 2:c 3:d
del1* del2 : 0:a 3:d
del1  del2*: 0:a 3:d
del1* del3 : 0:a 2:c
del1  del3*: 0:a 2:c
del2* del0 : 1:b 3:d
del2  del0*: 1:b 3:d
del2* del1 : 0:a 3:d
del2  del1*: 0:a 3:d
del2* del2 : 0:a 1:b 3:d
del2  del2*: 0:a 1:b 3:d
del2* del3 : 0:a 1:b
del2  del3*: 0:a 1:b
del3* del0 : 1:b 2:c
del3  del0*: 1:b 2:c
del3* del1 : 0:a 2:c
del3  del1*: 0:a 2:c
del3* del2 : 0:a 1:b
del3  del2*: 0:a 1:b
del3* del3 : 0:a 1:b 2:c
del3  del3*: 0:a 1:b 2:c''';

const expectedTestTransformSetDeleteKey = '''
set0* del0 : 0:X 1:b 2:c 3:d
set0  del0*: 1:b 2:c 3:d
del0* set0 : 1:b 2:c 3:d
del0  set0*: 0:X 1:b 2:c 3:d
set0* del1 : 0:X 2:c 3:d
set0  del1*: 0:X 2:c 3:d
del1* set0 : 0:X 2:c 3:d
del1  set0*: 0:X 2:c 3:d
set0* del2 : 0:X 1:b 3:d
set0  del2*: 0:X 1:b 3:d
del2* set0 : 0:X 1:b 3:d
del2  set0*: 0:X 1:b 3:d
set0* del3 : 0:X 1:b 2:c
set0  del3*: 0:X 1:b 2:c
del3* set0 : 0:X 1:b 2:c
del3  set0*: 0:X 1:b 2:c
set1* del0 : 1:X 2:c 3:d
set1  del0*: 1:X 2:c 3:d
del0* set1 : 1:X 2:c 3:d
del0  set1*: 1:X 2:c 3:d
set1* del1 : 0:a 1:X 2:c 3:d
set1  del1*: 0:a 2:c 3:d
del1* set1 : 0:a 2:c 3:d
del1  set1*: 0:a 1:X 2:c 3:d
set1* del2 : 0:a 1:X 3:d
set1  del2*: 0:a 1:X 3:d
del2* set1 : 0:a 1:X 3:d
del2  set1*: 0:a 1:X 3:d
set1* del3 : 0:a 1:X 2:c
set1  del3*: 0:a 1:X 2:c
del3* set1 : 0:a 1:X 2:c
del3  set1*: 0:a 1:X 2:c
set2* del0 : 1:b 2:X 3:d
set2  del0*: 1:b 2:X 3:d
del0* set2 : 1:b 2:X 3:d
del0  set2*: 1:b 2:X 3:d
set2* del1 : 0:a 2:X 3:d
set2  del1*: 0:a 2:X 3:d
del1* set2 : 0:a 2:X 3:d
del1  set2*: 0:a 2:X 3:d
set2* del2 : 0:a 1:b 2:X 3:d
set2  del2*: 0:a 1:b 3:d
del2* set2 : 0:a 1:b 3:d
del2  set2*: 0:a 1:b 2:X 3:d
set2* del3 : 0:a 1:b 2:X
set2  del3*: 0:a 1:b 2:X
del3* set2 : 0:a 1:b 2:X
del3  set2*: 0:a 1:b 2:X
set3* del0 : 1:b 2:c 3:X
set3  del0*: 1:b 2:c 3:X
del0* set3 : 1:b 2:c 3:X
del0  set3*: 1:b 2:c 3:X
set3* del1 : 0:a 2:c 3:X
set3  del1*: 0:a 2:c 3:X
del1* set3 : 0:a 2:c 3:X
del1  set3*: 0:a 2:c 3:X
set3* del2 : 0:a 1:b 3:X
set3  del2*: 0:a 1:b 3:X
del2* set3 : 0:a 1:b 3:X
del2  set3*: 0:a 1:b 3:X
set3* del3 : 0:a 1:b 2:c 3:X
set3  del3*: 0:a 1:b 2:c
del3* set3 : 0:a 1:b 2:c
del3  set3*: 0:a 1:b 2:c 3:X''';

const expectedTestTransformSetSetKey = '''
set0* set0 : 0:X 1:b 2:c 3:d
set0  set0*: 0:Y 1:b 2:c 3:d
set0* set1 : 0:X 1:Y 2:c 3:d
set0  set1*: 0:X 1:Y 2:c 3:d
set0* set2 : 0:X 1:b 2:Y 3:d
set0  set2*: 0:X 1:b 2:Y 3:d
set0* set3 : 0:X 1:b 2:c 3:Y
set0  set3*: 0:X 1:b 2:c 3:Y
set1* set0 : 0:Y 1:X 2:c 3:d
set1  set0*: 0:Y 1:X 2:c 3:d
set1* set1 : 0:a 1:X 2:c 3:d
set1  set1*: 0:a 1:Y 2:c 3:d
set1* set2 : 0:a 1:X 2:Y 3:d
set1  set2*: 0:a 1:X 2:Y 3:d
set1* set3 : 0:a 1:X 2:c 3:Y
set1  set3*: 0:a 1:X 2:c 3:Y
set2* set0 : 0:Y 1:b 2:X 3:d
set2  set0*: 0:Y 1:b 2:X 3:d
set2* set1 : 0:a 1:Y 2:X 3:d
set2  set1*: 0:a 1:Y 2:X 3:d
set2* set2 : 0:a 1:b 2:X 3:d
set2  set2*: 0:a 1:b 2:Y 3:d
set2* set3 : 0:a 1:b 2:X 3:Y
set2  set3*: 0:a 1:b 2:X 3:Y
set3* set0 : 0:Y 1:b 2:c 3:X
set3  set0*: 0:Y 1:b 2:c 3:X
set3* set1 : 0:a 1:Y 2:c 3:X
set3  set1*: 0:a 1:Y 2:c 3:X
set3* set2 : 0:a 1:b 2:Y 3:X
set3  set2*: 0:a 1:b 2:Y 3:X
set3* set3 : 0:a 1:b 2:c 3:X
set3  set3*: 0:a 1:b 2:c 3:Y''';

const expectedTestTransformRenameDelete = '''
del0* 0->0 : 1:b 2:c 3:d
del0  0->0*: 1:b 2:c 3:d
0->0* del0 : 1:b 2:c 3:d
0->0  del0*: 1:b 2:c 3:d
del0* 0->1 : 2:c 3:d
del0  0->1*: 2:c 3:d
0->1* del0 : 2:c 3:d
0->1  del0*: 2:c 3:d
del0* 0->2 : 1:b 3:d
del0  0->2*: 1:b 3:d
0->2* del0 : 1:b 3:d
0->2  del0*: 1:b 3:d
del0* 0->3 : 1:b 2:c
del0  0->3*: 1:b 2:c
0->3* del0 : 1:b 2:c
0->3  del0*: 1:b 2:c
del0* 0->4 : 1:b 2:c 3:d
del0  0->4*: 1:b 2:c 3:d
0->4* del0 : 1:b 2:c 3:d
0->4  del0*: 1:b 2:c 3:d
del0* 0->5 : 1:b 2:c 3:d
del0  0->5*: 1:b 2:c 3:d
0->5* del0 : 1:b 2:c 3:d
0->5  del0*: 1:b 2:c 3:d
del0* 1->0 : 0:b 2:c 3:d
del0  1->0*: 0:b 2:c 3:d
1->0* del0 : 0:b 2:c 3:d
1->0  del0*: 0:b 2:c 3:d
del0* 1->1 : 1:b 2:c 3:d
del0  1->1*: 1:b 2:c 3:d
1->1* del0 : 1:b 2:c 3:d
1->1  del0*: 1:b 2:c 3:d
del0* 1->2 : 2:b 3:d
del0  1->2*: 2:b 3:d
1->2* del0 : 2:b 3:d
1->2  del0*: 2:b 3:d
del0* 1->3 : 2:c 3:b
del0  1->3*: 2:c 3:b
1->3* del0 : 2:c 3:b
1->3  del0*: 2:c 3:b
del0* 1->4 : 2:c 3:d 4:b
del0  1->4*: 2:c 3:d 4:b
1->4* del0 : 2:c 3:d 4:b
1->4  del0*: 2:c 3:d 4:b
del0* 1->5 : 2:c 3:d 5:b
del0  1->5*: 2:c 3:d 5:b
1->5* del0 : 2:c 3:d 5:b
1->5  del0*: 2:c 3:d 5:b
del0* 2->0 : 0:c 1:b 3:d
del0  2->0*: 0:c 1:b 3:d
2->0* del0 : 0:c 1:b 3:d
2->0  del0*: 0:c 1:b 3:d
del0* 2->1 : 1:c 3:d
del0  2->1*: 1:c 3:d
2->1* del0 : 1:c 3:d
2->1  del0*: 1:c 3:d
del0* 2->2 : 1:b 2:c 3:d
del0  2->2*: 1:b 2:c 3:d
2->2* del0 : 1:b 2:c 3:d
2->2  del0*: 1:b 2:c 3:d
del0* 2->3 : 1:b 3:c
del0  2->3*: 1:b 3:c
2->3* del0 : 1:b 3:c
2->3  del0*: 1:b 3:c
del0* 2->4 : 1:b 3:d 4:c
del0  2->4*: 1:b 3:d 4:c
2->4* del0 : 1:b 3:d 4:c
2->4  del0*: 1:b 3:d 4:c
del0* 2->5 : 1:b 3:d 5:c
del0  2->5*: 1:b 3:d 5:c
2->5* del0 : 1:b 3:d 5:c
2->5  del0*: 1:b 3:d 5:c
del0* 3->0 : 0:d 1:b 2:c
del0  3->0*: 0:d 1:b 2:c
3->0* del0 : 0:d 1:b 2:c
3->0  del0*: 0:d 1:b 2:c
del0* 3->1 : 1:d 2:c
del0  3->1*: 1:d 2:c
3->1* del0 : 1:d 2:c
3->1  del0*: 1:d 2:c
del0* 3->2 : 1:b 2:d
del0  3->2*: 1:b 2:d
3->2* del0 : 1:b 2:d
3->2  del0*: 1:b 2:d
del0* 3->3 : 1:b 2:c 3:d
del0  3->3*: 1:b 2:c 3:d
3->3* del0 : 1:b 2:c 3:d
3->3  del0*: 1:b 2:c 3:d
del0* 3->4 : 1:b 2:c 4:d
del0  3->4*: 1:b 2:c 4:d
3->4* del0 : 1:b 2:c 4:d
3->4  del0*: 1:b 2:c 4:d
del0* 3->5 : 1:b 2:c 5:d
del0  3->5*: 1:b 2:c 5:d
3->5* del0 : 1:b 2:c 5:d
3->5  del0*: 1:b 2:c 5:d
del1* 0->0 : 0:a 2:c 3:d
del1  0->0*: 0:a 2:c 3:d
0->0* del1 : 0:a 2:c 3:d
0->0  del1*: 0:a 2:c 3:d
del1* 0->1 : 1:a 2:c 3:d
del1  0->1*: 1:a 2:c 3:d
0->1* del1 : 1:a 2:c 3:d
0->1  del1*: 1:a 2:c 3:d
del1* 0->2 : 2:a 3:d
del1  0->2*: 2:a 3:d
0->2* del1 : 2:a 3:d
0->2  del1*: 2:a 3:d
del1* 0->3 : 2:c 3:a
del1  0->3*: 2:c 3:a
0->3* del1 : 2:c 3:a
0->3  del1*: 2:c 3:a
del1* 0->4 : 2:c 3:d 4:a
del1  0->4*: 2:c 3:d 4:a
0->4* del1 : 2:c 3:d 4:a
0->4  del1*: 2:c 3:d 4:a
del1* 0->5 : 2:c 3:d 5:a
del1  0->5*: 2:c 3:d 5:a
0->5* del1 : 2:c 3:d 5:a
0->5  del1*: 2:c 3:d 5:a
del1* 1->0 : 2:c 3:d
del1  1->0*: 2:c 3:d
1->0* del1 : 2:c 3:d
1->0  del1*: 2:c 3:d
del1* 1->1 : 0:a 2:c 3:d
del1  1->1*: 0:a 2:c 3:d
1->1* del1 : 0:a 2:c 3:d
1->1  del1*: 0:a 2:c 3:d
del1* 1->2 : 0:a 3:d
del1  1->2*: 0:a 3:d
1->2* del1 : 0:a 3:d
1->2  del1*: 0:a 3:d
del1* 1->3 : 0:a 2:c
del1  1->3*: 0:a 2:c
1->3* del1 : 0:a 2:c
1->3  del1*: 0:a 2:c
del1* 1->4 : 0:a 2:c 3:d
del1  1->4*: 0:a 2:c 3:d
1->4* del1 : 0:a 2:c 3:d
1->4  del1*: 0:a 2:c 3:d
del1* 1->5 : 0:a 2:c 3:d
del1  1->5*: 0:a 2:c 3:d
1->5* del1 : 0:a 2:c 3:d
1->5  del1*: 0:a 2:c 3:d
del1* 2->0 : 0:c 3:d
del1  2->0*: 0:c 3:d
2->0* del1 : 0:c 3:d
2->0  del1*: 0:c 3:d
del1* 2->1 : 0:a 1:c 3:d
del1  2->1*: 0:a 1:c 3:d
2->1* del1 : 0:a 1:c 3:d
2->1  del1*: 0:a 1:c 3:d
del1* 2->2 : 0:a 2:c 3:d
del1  2->2*: 0:a 2:c 3:d
2->2* del1 : 0:a 2:c 3:d
2->2  del1*: 0:a 2:c 3:d
del1* 2->3 : 0:a 3:c
del1  2->3*: 0:a 3:c
2->3* del1 : 0:a 3:c
2->3  del1*: 0:a 3:c
del1* 2->4 : 0:a 3:d 4:c
del1  2->4*: 0:a 3:d 4:c
2->4* del1 : 0:a 3:d 4:c
2->4  del1*: 0:a 3:d 4:c
del1* 2->5 : 0:a 3:d 5:c
del1  2->5*: 0:a 3:d 5:c
2->5* del1 : 0:a 3:d 5:c
2->5  del1*: 0:a 3:d 5:c
del1* 3->0 : 0:d 2:c
del1  3->0*: 0:d 2:c
3->0* del1 : 0:d 2:c
3->0  del1*: 0:d 2:c
del1* 3->1 : 0:a 1:d 2:c
del1  3->1*: 0:a 1:d 2:c
3->1* del1 : 0:a 1:d 2:c
3->1  del1*: 0:a 1:d 2:c
del1* 3->2 : 0:a 2:d
del1  3->2*: 0:a 2:d
3->2* del1 : 0:a 2:d
3->2  del1*: 0:a 2:d
del1* 3->3 : 0:a 2:c 3:d
del1  3->3*: 0:a 2:c 3:d
3->3* del1 : 0:a 2:c 3:d
3->3  del1*: 0:a 2:c 3:d
del1* 3->4 : 0:a 2:c 4:d
del1  3->4*: 0:a 2:c 4:d
3->4* del1 : 0:a 2:c 4:d
3->4  del1*: 0:a 2:c 4:d
del1* 3->5 : 0:a 2:c 5:d
del1  3->5*: 0:a 2:c 5:d
3->5* del1 : 0:a 2:c 5:d
3->5  del1*: 0:a 2:c 5:d
del2* 0->0 : 0:a 1:b 3:d
del2  0->0*: 0:a 1:b 3:d
0->0* del2 : 0:a 1:b 3:d
0->0  del2*: 0:a 1:b 3:d
del2* 0->1 : 1:a 3:d
del2  0->1*: 1:a 3:d
0->1* del2 : 1:a 3:d
0->1  del2*: 1:a 3:d
del2* 0->2 : 1:b 2:a 3:d
del2  0->2*: 1:b 2:a 3:d
0->2* del2 : 1:b 2:a 3:d
0->2  del2*: 1:b 2:a 3:d
del2* 0->3 : 1:b 3:a
del2  0->3*: 1:b 3:a
0->3* del2 : 1:b 3:a
0->3  del2*: 1:b 3:a
del2* 0->4 : 1:b 3:d 4:a
del2  0->4*: 1:b 3:d 4:a
0->4* del2 : 1:b 3:d 4:a
0->4  del2*: 1:b 3:d 4:a
del2* 0->5 : 1:b 3:d 5:a
del2  0->5*: 1:b 3:d 5:a
0->5* del2 : 1:b 3:d 5:a
0->5  del2*: 1:b 3:d 5:a
del2* 1->0 : 0:b 3:d
del2  1->0*: 0:b 3:d
1->0* del2 : 0:b 3:d
1->0  del2*: 0:b 3:d
del2* 1->1 : 0:a 1:b 3:d
del2  1->1*: 0:a 1:b 3:d
1->1* del2 : 0:a 1:b 3:d
1->1  del2*: 0:a 1:b 3:d
del2* 1->2 : 0:a 2:b 3:d
del2  1->2*: 0:a 2:b 3:d
1->2* del2 : 0:a 2:b 3:d
1->2  del2*: 0:a 2:b 3:d
del2* 1->3 : 0:a 3:b
del2  1->3*: 0:a 3:b
1->3* del2 : 0:a 3:b
1->3  del2*: 0:a 3:b
del2* 1->4 : 0:a 3:d 4:b
del2  1->4*: 0:a 3:d 4:b
1->4* del2 : 0:a 3:d 4:b
1->4  del2*: 0:a 3:d 4:b
del2* 1->5 : 0:a 3:d 5:b
del2  1->5*: 0:a 3:d 5:b
1->5* del2 : 0:a 3:d 5:b
1->5  del2*: 0:a 3:d 5:b
del2* 2->0 : 1:b 3:d
del2  2->0*: 1:b 3:d
2->0* del2 : 1:b 3:d
2->0  del2*: 1:b 3:d
del2* 2->1 : 0:a 3:d
del2  2->1*: 0:a 3:d
2->1* del2 : 0:a 3:d
2->1  del2*: 0:a 3:d
del2* 2->2 : 0:a 1:b 3:d
del2  2->2*: 0:a 1:b 3:d
2->2* del2 : 0:a 1:b 3:d
2->2  del2*: 0:a 1:b 3:d
del2* 2->3 : 0:a 1:b
del2  2->3*: 0:a 1:b
2->3* del2 : 0:a 1:b
2->3  del2*: 0:a 1:b
del2* 2->4 : 0:a 1:b 3:d
del2  2->4*: 0:a 1:b 3:d
2->4* del2 : 0:a 1:b 3:d
2->4  del2*: 0:a 1:b 3:d
del2* 2->5 : 0:a 1:b 3:d
del2  2->5*: 0:a 1:b 3:d
2->5* del2 : 0:a 1:b 3:d
2->5  del2*: 0:a 1:b 3:d
del2* 3->0 : 0:d 1:b
del2  3->0*: 0:d 1:b
3->0* del2 : 0:d 1:b
3->0  del2*: 0:d 1:b
del2* 3->1 : 0:a 1:d
del2  3->1*: 0:a 1:d
3->1* del2 : 0:a 1:d
3->1  del2*: 0:a 1:d
del2* 3->2 : 0:a 1:b 2:d
del2  3->2*: 0:a 1:b 2:d
3->2* del2 : 0:a 1:b 2:d
3->2  del2*: 0:a 1:b 2:d
del2* 3->3 : 0:a 1:b 3:d
del2  3->3*: 0:a 1:b 3:d
3->3* del2 : 0:a 1:b 3:d
3->3  del2*: 0:a 1:b 3:d
del2* 3->4 : 0:a 1:b 4:d
del2  3->4*: 0:a 1:b 4:d
3->4* del2 : 0:a 1:b 4:d
3->4  del2*: 0:a 1:b 4:d
del2* 3->5 : 0:a 1:b 5:d
del2  3->5*: 0:a 1:b 5:d
3->5* del2 : 0:a 1:b 5:d
3->5  del2*: 0:a 1:b 5:d
del3* 0->0 : 0:a 1:b 2:c
del3  0->0*: 0:a 1:b 2:c
0->0* del3 : 0:a 1:b 2:c
0->0  del3*: 0:a 1:b 2:c
del3* 0->1 : 1:a 2:c
del3  0->1*: 1:a 2:c
0->1* del3 : 1:a 2:c
0->1  del3*: 1:a 2:c
del3* 0->2 : 1:b 2:a
del3  0->2*: 1:b 2:a
0->2* del3 : 1:b 2:a
0->2  del3*: 1:b 2:a
del3* 0->3 : 1:b 2:c 3:a
del3  0->3*: 1:b 2:c 3:a
0->3* del3 : 1:b 2:c 3:a
0->3  del3*: 1:b 2:c 3:a
del3* 0->4 : 1:b 2:c 4:a
del3  0->4*: 1:b 2:c 4:a
0->4* del3 : 1:b 2:c 4:a
0->4  del3*: 1:b 2:c 4:a
del3* 0->5 : 1:b 2:c 5:a
del3  0->5*: 1:b 2:c 5:a
0->5* del3 : 1:b 2:c 5:a
0->5  del3*: 1:b 2:c 5:a
del3* 1->0 : 0:b 2:c
del3  1->0*: 0:b 2:c
1->0* del3 : 0:b 2:c
1->0  del3*: 0:b 2:c
del3* 1->1 : 0:a 1:b 2:c
del3  1->1*: 0:a 1:b 2:c
1->1* del3 : 0:a 1:b 2:c
1->1  del3*: 0:a 1:b 2:c
del3* 1->2 : 0:a 2:b
del3  1->2*: 0:a 2:b
1->2* del3 : 0:a 2:b
1->2  del3*: 0:a 2:b
del3* 1->3 : 0:a 2:c 3:b
del3  1->3*: 0:a 2:c 3:b
1->3* del3 : 0:a 2:c 3:b
1->3  del3*: 0:a 2:c 3:b
del3* 1->4 : 0:a 2:c 4:b
del3  1->4*: 0:a 2:c 4:b
1->4* del3 : 0:a 2:c 4:b
1->4  del3*: 0:a 2:c 4:b
del3* 1->5 : 0:a 2:c 5:b
del3  1->5*: 0:a 2:c 5:b
1->5* del3 : 0:a 2:c 5:b
1->5  del3*: 0:a 2:c 5:b
del3* 2->0 : 0:c 1:b
del3  2->0*: 0:c 1:b
2->0* del3 : 0:c 1:b
2->0  del3*: 0:c 1:b
del3* 2->1 : 0:a 1:c
del3  2->1*: 0:a 1:c
2->1* del3 : 0:a 1:c
2->1  del3*: 0:a 1:c
del3* 2->2 : 0:a 1:b 2:c
del3  2->2*: 0:a 1:b 2:c
2->2* del3 : 0:a 1:b 2:c
2->2  del3*: 0:a 1:b 2:c
del3* 2->3 : 0:a 1:b 3:c
del3  2->3*: 0:a 1:b 3:c
2->3* del3 : 0:a 1:b 3:c
2->3  del3*: 0:a 1:b 3:c
del3* 2->4 : 0:a 1:b 4:c
del3  2->4*: 0:a 1:b 4:c
2->4* del3 : 0:a 1:b 4:c
2->4  del3*: 0:a 1:b 4:c
del3* 2->5 : 0:a 1:b 5:c
del3  2->5*: 0:a 1:b 5:c
2->5* del3 : 0:a 1:b 5:c
2->5  del3*: 0:a 1:b 5:c
del3* 3->0 : 1:b 2:c
del3  3->0*: 1:b 2:c
3->0* del3 : 1:b 2:c
3->0  del3*: 1:b 2:c
del3* 3->1 : 0:a 2:c
del3  3->1*: 0:a 2:c
3->1* del3 : 0:a 2:c
3->1  del3*: 0:a 2:c
del3* 3->2 : 0:a 1:b
del3  3->2*: 0:a 1:b
3->2* del3 : 0:a 1:b
3->2  del3*: 0:a 1:b
del3* 3->3 : 0:a 1:b 2:c
del3  3->3*: 0:a 1:b 2:c
3->3* del3 : 0:a 1:b 2:c
3->3  del3*: 0:a 1:b 2:c
del3* 3->4 : 0:a 1:b 2:c
del3  3->4*: 0:a 1:b 2:c
3->4* del3 : 0:a 1:b 2:c
3->4  del3*: 0:a 1:b 2:c
del3* 3->5 : 0:a 1:b 2:c
del3  3->5*: 0:a 1:b 2:c
3->5* del3 : 0:a 1:b 2:c
3->5  del3*: 0:a 1:b 2:c''';

const expectedTestTransformSetRenameKey = '''
set0* 0->0 : 0:X 1:b 2:c 3:d
set0  0->0*: 0:X 1:b 2:c 3:d
0->0* set0 : 0:X 1:b 2:c 3:d
0->0  set0*: 0:X 1:b 2:c 3:d
set0* 0->1 : 1:X 2:c 3:d
set0  0->1*: 1:X 2:c 3:d
0->1* set0 : 1:X 2:c 3:d
0->1  set0*: 1:X 2:c 3:d
set0* 0->2 : 1:b 2:X 3:d
set0  0->2*: 1:b 2:X 3:d
0->2* set0 : 1:b 2:X 3:d
0->2  set0*: 1:b 2:X 3:d
set0* 0->3 : 1:b 2:c 3:X
set0  0->3*: 1:b 2:c 3:X
0->3* set0 : 1:b 2:c 3:X
0->3  set0*: 1:b 2:c 3:X
set0* 0->4 : 1:b 2:c 3:d 4:X
set0  0->4*: 1:b 2:c 3:d 4:X
0->4* set0 : 1:b 2:c 3:d 4:X
0->4  set0*: 1:b 2:c 3:d 4:X
set0* 0->5 : 1:b 2:c 3:d 5:X
set0  0->5*: 1:b 2:c 3:d 5:X
0->5* set0 : 1:b 2:c 3:d 5:X
0->5  set0*: 1:b 2:c 3:d 5:X
set0* 1->0 : 0:X 2:c 3:d
set0  1->0*: 0:b 2:c 3:d
1->0* set0 : 0:b 2:c 3:d
1->0  set0*: 0:X 2:c 3:d
set0* 1->1 : 0:X 1:b 2:c 3:d
set0  1->1*: 0:X 1:b 2:c 3:d
1->1* set0 : 0:X 1:b 2:c 3:d
1->1  set0*: 0:X 1:b 2:c 3:d
set0* 1->2 : 0:X 2:b 3:d
set0  1->2*: 0:X 2:b 3:d
1->2* set0 : 0:X 2:b 3:d
1->2  set0*: 0:X 2:b 3:d
set0* 1->3 : 0:X 2:c 3:b
set0  1->3*: 0:X 2:c 3:b
1->3* set0 : 0:X 2:c 3:b
1->3  set0*: 0:X 2:c 3:b
set0* 1->4 : 0:X 2:c 3:d 4:b
set0  1->4*: 0:X 2:c 3:d 4:b
1->4* set0 : 0:X 2:c 3:d 4:b
1->4  set0*: 0:X 2:c 3:d 4:b
set0* 1->5 : 0:X 2:c 3:d 5:b
set0  1->5*: 0:X 2:c 3:d 5:b
1->5* set0 : 0:X 2:c 3:d 5:b
1->5  set0*: 0:X 2:c 3:d 5:b
set0* 2->0 : 0:X 1:b 3:d
set0  2->0*: 0:c 1:b 3:d
2->0* set0 : 0:c 1:b 3:d
2->0  set0*: 0:X 1:b 3:d
set0* 2->1 : 0:X 1:c 3:d
set0  2->1*: 0:X 1:c 3:d
2->1* set0 : 0:X 1:c 3:d
2->1  set0*: 0:X 1:c 3:d
set0* 2->2 : 0:X 1:b 2:c 3:d
set0  2->2*: 0:X 1:b 2:c 3:d
2->2* set0 : 0:X 1:b 2:c 3:d
2->2  set0*: 0:X 1:b 2:c 3:d
set0* 2->3 : 0:X 1:b 3:c
set0  2->3*: 0:X 1:b 3:c
2->3* set0 : 0:X 1:b 3:c
2->3  set0*: 0:X 1:b 3:c
set0* 2->4 : 0:X 1:b 3:d 4:c
set0  2->4*: 0:X 1:b 3:d 4:c
2->4* set0 : 0:X 1:b 3:d 4:c
2->4  set0*: 0:X 1:b 3:d 4:c
set0* 2->5 : 0:X 1:b 3:d 5:c
set0  2->5*: 0:X 1:b 3:d 5:c
2->5* set0 : 0:X 1:b 3:d 5:c
2->5  set0*: 0:X 1:b 3:d 5:c
set0* 3->0 : 0:X 1:b 2:c
set0  3->0*: 0:d 1:b 2:c
3->0* set0 : 0:d 1:b 2:c
3->0  set0*: 0:X 1:b 2:c
set0* 3->1 : 0:X 1:d 2:c
set0  3->1*: 0:X 1:d 2:c
3->1* set0 : 0:X 1:d 2:c
3->1  set0*: 0:X 1:d 2:c
set0* 3->2 : 0:X 1:b 2:d
set0  3->2*: 0:X 1:b 2:d
3->2* set0 : 0:X 1:b 2:d
3->2  set0*: 0:X 1:b 2:d
set0* 3->3 : 0:X 1:b 2:c 3:d
set0  3->3*: 0:X 1:b 2:c 3:d
3->3* set0 : 0:X 1:b 2:c 3:d
3->3  set0*: 0:X 1:b 2:c 3:d
set0* 3->4 : 0:X 1:b 2:c 4:d
set0  3->4*: 0:X 1:b 2:c 4:d
3->4* set0 : 0:X 1:b 2:c 4:d
3->4  set0*: 0:X 1:b 2:c 4:d
set0* 3->5 : 0:X 1:b 2:c 5:d
set0  3->5*: 0:X 1:b 2:c 5:d
3->5* set0 : 0:X 1:b 2:c 5:d
3->5  set0*: 0:X 1:b 2:c 5:d
set1* 0->0 : 0:a 1:X 2:c 3:d
set1  0->0*: 0:a 1:X 2:c 3:d
0->0* set1 : 0:a 1:X 2:c 3:d
0->0  set1*: 0:a 1:X 2:c 3:d
set1* 0->1 : 1:X 2:c 3:d
set1  0->1*: 1:a 2:c 3:d
0->1* set1 : 1:a 2:c 3:d
0->1  set1*: 1:X 2:c 3:d
set1* 0->2 : 1:X 2:a 3:d
set1  0->2*: 1:X 2:a 3:d
0->2* set1 : 1:X 2:a 3:d
0->2  set1*: 1:X 2:a 3:d
set1* 0->3 : 1:X 2:c 3:a
set1  0->3*: 1:X 2:c 3:a
0->3* set1 : 1:X 2:c 3:a
0->3  set1*: 1:X 2:c 3:a
set1* 0->4 : 1:X 2:c 3:d 4:a
set1  0->4*: 1:X 2:c 3:d 4:a
0->4* set1 : 1:X 2:c 3:d 4:a
0->4  set1*: 1:X 2:c 3:d 4:a
set1* 0->5 : 1:X 2:c 3:d 5:a
set1  0->5*: 1:X 2:c 3:d 5:a
0->5* set1 : 1:X 2:c 3:d 5:a
0->5  set1*: 1:X 2:c 3:d 5:a
set1* 1->0 : 0:X 2:c 3:d
set1  1->0*: 0:X 2:c 3:d
1->0* set1 : 0:X 2:c 3:d
1->0  set1*: 0:X 2:c 3:d
set1* 1->1 : 0:a 1:X 2:c 3:d
set1  1->1*: 0:a 1:X 2:c 3:d
1->1* set1 : 0:a 1:X 2:c 3:d
1->1  set1*: 0:a 1:X 2:c 3:d
set1* 1->2 : 0:a 2:X 3:d
set1  1->2*: 0:a 2:X 3:d
1->2* set1 : 0:a 2:X 3:d
1->2  set1*: 0:a 2:X 3:d
set1* 1->3 : 0:a 2:c 3:X
set1  1->3*: 0:a 2:c 3:X
1->3* set1 : 0:a 2:c 3:X
1->3  set1*: 0:a 2:c 3:X
set1* 1->4 : 0:a 2:c 3:d 4:X
set1  1->4*: 0:a 2:c 3:d 4:X
1->4* set1 : 0:a 2:c 3:d 4:X
1->4  set1*: 0:a 2:c 3:d 4:X
set1* 1->5 : 0:a 2:c 3:d 5:X
set1  1->5*: 0:a 2:c 3:d 5:X
1->5* set1 : 0:a 2:c 3:d 5:X
1->5  set1*: 0:a 2:c 3:d 5:X
set1* 2->0 : 0:c 1:X 3:d
set1  2->0*: 0:c 1:X 3:d
2->0* set1 : 0:c 1:X 3:d
2->0  set1*: 0:c 1:X 3:d
set1* 2->1 : 0:a 1:X 3:d
set1  2->1*: 0:a 1:c 3:d
2->1* set1 : 0:a 1:c 3:d
2->1  set1*: 0:a 1:X 3:d
set1* 2->2 : 0:a 1:X 2:c 3:d
set1  2->2*: 0:a 1:X 2:c 3:d
2->2* set1 : 0:a 1:X 2:c 3:d
2->2  set1*: 0:a 1:X 2:c 3:d
set1* 2->3 : 0:a 1:X 3:c
set1  2->3*: 0:a 1:X 3:c
2->3* set1 : 0:a 1:X 3:c
2->3  set1*: 0:a 1:X 3:c
set1* 2->4 : 0:a 1:X 3:d 4:c
set1  2->4*: 0:a 1:X 3:d 4:c
2->4* set1 : 0:a 1:X 3:d 4:c
2->4  set1*: 0:a 1:X 3:d 4:c
set1* 2->5 : 0:a 1:X 3:d 5:c
set1  2->5*: 0:a 1:X 3:d 5:c
2->5* set1 : 0:a 1:X 3:d 5:c
2->5  set1*: 0:a 1:X 3:d 5:c
set1* 3->0 : 0:d 1:X 2:c
set1  3->0*: 0:d 1:X 2:c
3->0* set1 : 0:d 1:X 2:c
3->0  set1*: 0:d 1:X 2:c
set1* 3->1 : 0:a 1:X 2:c
set1  3->1*: 0:a 1:d 2:c
3->1* set1 : 0:a 1:d 2:c
3->1  set1*: 0:a 1:X 2:c
set1* 3->2 : 0:a 1:X 2:d
set1  3->2*: 0:a 1:X 2:d
3->2* set1 : 0:a 1:X 2:d
3->2  set1*: 0:a 1:X 2:d
set1* 3->3 : 0:a 1:X 2:c 3:d
set1  3->3*: 0:a 1:X 2:c 3:d
3->3* set1 : 0:a 1:X 2:c 3:d
3->3  set1*: 0:a 1:X 2:c 3:d
set1* 3->4 : 0:a 1:X 2:c 4:d
set1  3->4*: 0:a 1:X 2:c 4:d
3->4* set1 : 0:a 1:X 2:c 4:d
3->4  set1*: 0:a 1:X 2:c 4:d
set1* 3->5 : 0:a 1:X 2:c 5:d
set1  3->5*: 0:a 1:X 2:c 5:d
3->5* set1 : 0:a 1:X 2:c 5:d
3->5  set1*: 0:a 1:X 2:c 5:d
set2* 0->0 : 0:a 1:b 2:X 3:d
set2  0->0*: 0:a 1:b 2:X 3:d
0->0* set2 : 0:a 1:b 2:X 3:d
0->0  set2*: 0:a 1:b 2:X 3:d
set2* 0->1 : 1:a 2:X 3:d
set2  0->1*: 1:a 2:X 3:d
0->1* set2 : 1:a 2:X 3:d
0->1  set2*: 1:a 2:X 3:d
set2* 0->2 : 1:b 2:X 3:d
set2  0->2*: 1:b 2:a 3:d
0->2* set2 : 1:b 2:a 3:d
0->2  set2*: 1:b 2:X 3:d
set2* 0->3 : 1:b 2:X 3:a
set2  0->3*: 1:b 2:X 3:a
0->3* set2 : 1:b 2:X 3:a
0->3  set2*: 1:b 2:X 3:a
set2* 0->4 : 1:b 2:X 3:d 4:a
set2  0->4*: 1:b 2:X 3:d 4:a
0->4* set2 : 1:b 2:X 3:d 4:a
0->4  set2*: 1:b 2:X 3:d 4:a
set2* 0->5 : 1:b 2:X 3:d 5:a
set2  0->5*: 1:b 2:X 3:d 5:a
0->5* set2 : 1:b 2:X 3:d 5:a
0->5  set2*: 1:b 2:X 3:d 5:a
set2* 1->0 : 0:b 2:X 3:d
set2  1->0*: 0:b 2:X 3:d
1->0* set2 : 0:b 2:X 3:d
1->0  set2*: 0:b 2:X 3:d
set2* 1->1 : 0:a 1:b 2:X 3:d
set2  1->1*: 0:a 1:b 2:X 3:d
1->1* set2 : 0:a 1:b 2:X 3:d
1->1  set2*: 0:a 1:b 2:X 3:d
set2* 1->2 : 0:a 2:X 3:d
set2  1->2*: 0:a 2:b 3:d
1->2* set2 : 0:a 2:b 3:d
1->2  set2*: 0:a 2:X 3:d
set2* 1->3 : 0:a 2:X 3:b
set2  1->3*: 0:a 2:X 3:b
1->3* set2 : 0:a 2:X 3:b
1->3  set2*: 0:a 2:X 3:b
set2* 1->4 : 0:a 2:X 3:d 4:b
set2  1->4*: 0:a 2:X 3:d 4:b
1->4* set2 : 0:a 2:X 3:d 4:b
1->4  set2*: 0:a 2:X 3:d 4:b
set2* 1->5 : 0:a 2:X 3:d 5:b
set2  1->5*: 0:a 2:X 3:d 5:b
1->5* set2 : 0:a 2:X 3:d 5:b
1->5  set2*: 0:a 2:X 3:d 5:b
set2* 2->0 : 0:X 1:b 3:d
set2  2->0*: 0:X 1:b 3:d
2->0* set2 : 0:X 1:b 3:d
2->0  set2*: 0:X 1:b 3:d
set2* 2->1 : 0:a 1:X 3:d
set2  2->1*: 0:a 1:X 3:d
2->1* set2 : 0:a 1:X 3:d
2->1  set2*: 0:a 1:X 3:d
set2* 2->2 : 0:a 1:b 2:X 3:d
set2  2->2*: 0:a 1:b 2:X 3:d
2->2* set2 : 0:a 1:b 2:X 3:d
2->2  set2*: 0:a 1:b 2:X 3:d
set2* 2->3 : 0:a 1:b 3:X
set2  2->3*: 0:a 1:b 3:X
2->3* set2 : 0:a 1:b 3:X
2->3  set2*: 0:a 1:b 3:X
set2* 2->4 : 0:a 1:b 3:d 4:X
set2  2->4*: 0:a 1:b 3:d 4:X
2->4* set2 : 0:a 1:b 3:d 4:X
2->4  set2*: 0:a 1:b 3:d 4:X
set2* 2->5 : 0:a 1:b 3:d 5:X
set2  2->5*: 0:a 1:b 3:d 5:X
2->5* set2 : 0:a 1:b 3:d 5:X
2->5  set2*: 0:a 1:b 3:d 5:X
set2* 3->0 : 0:d 1:b 2:X
set2  3->0*: 0:d 1:b 2:X
3->0* set2 : 0:d 1:b 2:X
3->0  set2*: 0:d 1:b 2:X
set2* 3->1 : 0:a 1:d 2:X
set2  3->1*: 0:a 1:d 2:X
3->1* set2 : 0:a 1:d 2:X
3->1  set2*: 0:a 1:d 2:X
set2* 3->2 : 0:a 1:b 2:X
set2  3->2*: 0:a 1:b 2:d
3->2* set2 : 0:a 1:b 2:d
3->2  set2*: 0:a 1:b 2:X
set2* 3->3 : 0:a 1:b 2:X 3:d
set2  3->3*: 0:a 1:b 2:X 3:d
3->3* set2 : 0:a 1:b 2:X 3:d
3->3  set2*: 0:a 1:b 2:X 3:d
set2* 3->4 : 0:a 1:b 2:X 4:d
set2  3->4*: 0:a 1:b 2:X 4:d
3->4* set2 : 0:a 1:b 2:X 4:d
3->4  set2*: 0:a 1:b 2:X 4:d
set2* 3->5 : 0:a 1:b 2:X 5:d
set2  3->5*: 0:a 1:b 2:X 5:d
3->5* set2 : 0:a 1:b 2:X 5:d
3->5  set2*: 0:a 1:b 2:X 5:d
set3* 0->0 : 0:a 1:b 2:c 3:X
set3  0->0*: 0:a 1:b 2:c 3:X
0->0* set3 : 0:a 1:b 2:c 3:X
0->0  set3*: 0:a 1:b 2:c 3:X
set3* 0->1 : 1:a 2:c 3:X
set3  0->1*: 1:a 2:c 3:X
0->1* set3 : 1:a 2:c 3:X
0->1  set3*: 1:a 2:c 3:X
set3* 0->2 : 1:b 2:a 3:X
set3  0->2*: 1:b 2:a 3:X
0->2* set3 : 1:b 2:a 3:X
0->2  set3*: 1:b 2:a 3:X
set3* 0->3 : 1:b 2:c 3:X
set3  0->3*: 1:b 2:c 3:a
0->3* set3 : 1:b 2:c 3:a
0->3  set3*: 1:b 2:c 3:X
set3* 0->4 : 1:b 2:c 3:X 4:a
set3  0->4*: 1:b 2:c 3:X 4:a
0->4* set3 : 1:b 2:c 3:X 4:a
0->4  set3*: 1:b 2:c 3:X 4:a
set3* 0->5 : 1:b 2:c 3:X 5:a
set3  0->5*: 1:b 2:c 3:X 5:a
0->5* set3 : 1:b 2:c 3:X 5:a
0->5  set3*: 1:b 2:c 3:X 5:a
set3* 1->0 : 0:b 2:c 3:X
set3  1->0*: 0:b 2:c 3:X
1->0* set3 : 0:b 2:c 3:X
1->0  set3*: 0:b 2:c 3:X
set3* 1->1 : 0:a 1:b 2:c 3:X
set3  1->1*: 0:a 1:b 2:c 3:X
1->1* set3 : 0:a 1:b 2:c 3:X
1->1  set3*: 0:a 1:b 2:c 3:X
set3* 1->2 : 0:a 2:b 3:X
set3  1->2*: 0:a 2:b 3:X
1->2* set3 : 0:a 2:b 3:X
1->2  set3*: 0:a 2:b 3:X
set3* 1->3 : 0:a 2:c 3:X
set3  1->3*: 0:a 2:c 3:b
1->3* set3 : 0:a 2:c 3:b
1->3  set3*: 0:a 2:c 3:X
set3* 1->4 : 0:a 2:c 3:X 4:b
set3  1->4*: 0:a 2:c 3:X 4:b
1->4* set3 : 0:a 2:c 3:X 4:b
1->4  set3*: 0:a 2:c 3:X 4:b
set3* 1->5 : 0:a 2:c 3:X 5:b
set3  1->5*: 0:a 2:c 3:X 5:b
1->5* set3 : 0:a 2:c 3:X 5:b
1->5  set3*: 0:a 2:c 3:X 5:b
set3* 2->0 : 0:c 1:b 3:X
set3  2->0*: 0:c 1:b 3:X
2->0* set3 : 0:c 1:b 3:X
2->0  set3*: 0:c 1:b 3:X
set3* 2->1 : 0:a 1:c 3:X
set3  2->1*: 0:a 1:c 3:X
2->1* set3 : 0:a 1:c 3:X
2->1  set3*: 0:a 1:c 3:X
set3* 2->2 : 0:a 1:b 2:c 3:X
set3  2->2*: 0:a 1:b 2:c 3:X
2->2* set3 : 0:a 1:b 2:c 3:X
2->2  set3*: 0:a 1:b 2:c 3:X
set3* 2->3 : 0:a 1:b 3:X
set3  2->3*: 0:a 1:b 3:c
2->3* set3 : 0:a 1:b 3:c
2->3  set3*: 0:a 1:b 3:X
set3* 2->4 : 0:a 1:b 3:X 4:c
set3  2->4*: 0:a 1:b 3:X 4:c
2->4* set3 : 0:a 1:b 3:X 4:c
2->4  set3*: 0:a 1:b 3:X 4:c
set3* 2->5 : 0:a 1:b 3:X 5:c
set3  2->5*: 0:a 1:b 3:X 5:c
2->5* set3 : 0:a 1:b 3:X 5:c
2->5  set3*: 0:a 1:b 3:X 5:c
set3* 3->0 : 0:X 1:b 2:c
set3  3->0*: 0:X 1:b 2:c
3->0* set3 : 0:X 1:b 2:c
3->0  set3*: 0:X 1:b 2:c
set3* 3->1 : 0:a 1:X 2:c
set3  3->1*: 0:a 1:X 2:c
3->1* set3 : 0:a 1:X 2:c
3->1  set3*: 0:a 1:X 2:c
set3* 3->2 : 0:a 1:b 2:X
set3  3->2*: 0:a 1:b 2:X
3->2* set3 : 0:a 1:b 2:X
3->2  set3*: 0:a 1:b 2:X
set3* 3->3 : 0:a 1:b 2:c 3:X
set3  3->3*: 0:a 1:b 2:c 3:X
3->3* set3 : 0:a 1:b 2:c 3:X
3->3  set3*: 0:a 1:b 2:c 3:X
set3* 3->4 : 0:a 1:b 2:c 4:X
set3  3->4*: 0:a 1:b 2:c 4:X
3->4* set3 : 0:a 1:b 2:c 4:X
3->4  set3*: 0:a 1:b 2:c 4:X
set3* 3->5 : 0:a 1:b 2:c 5:X
set3  3->5*: 0:a 1:b 2:c 5:X
3->5* set3 : 0:a 1:b 2:c 5:X
3->5  set3*: 0:a 1:b 2:c 5:X''';

const expectedTestTransformEditRenameKey = '''
edit0* 0->0 : 0:X 1:b 2:c 3:d
edit0  0->0*: 0:X 1:b 2:c 3:d
0->0* edit0 : 0:X 1:b 2:c 3:d
0->0  edit0*: 0:X 1:b 2:c 3:d
edit0* 0->1 : 1:X 2:c 3:d
edit0  0->1*: 1:X 2:c 3:d
0->1* edit0 : 1:X 2:c 3:d
0->1  edit0*: 1:X 2:c 3:d
edit0* 0->2 : 1:b 2:X 3:d
edit0  0->2*: 1:b 2:X 3:d
0->2* edit0 : 1:b 2:X 3:d
0->2  edit0*: 1:b 2:X 3:d
edit0* 0->3 : 1:b 2:c 3:X
edit0  0->3*: 1:b 2:c 3:X
0->3* edit0 : 1:b 2:c 3:X
0->3  edit0*: 1:b 2:c 3:X
edit0* 0->4 : 1:b 2:c 3:d 4:X
edit0  0->4*: 1:b 2:c 3:d 4:X
0->4* edit0 : 1:b 2:c 3:d 4:X
0->4  edit0*: 1:b 2:c 3:d 4:X
edit0* 0->5 : 1:b 2:c 3:d 5:X
edit0  0->5*: 1:b 2:c 3:d 5:X
0->5* edit0 : 1:b 2:c 3:d 5:X
0->5  edit0*: 1:b 2:c 3:d 5:X
edit0* 1->0 : 0:b 2:c 3:d
edit0  1->0*: 0:b 2:c 3:d
1->0* edit0 : 0:b 2:c 3:d
1->0  edit0*: 0:b 2:c 3:d
edit0* 1->1 : 0:X 1:b 2:c 3:d
edit0  1->1*: 0:X 1:b 2:c 3:d
1->1* edit0 : 0:X 1:b 2:c 3:d
1->1  edit0*: 0:X 1:b 2:c 3:d
edit0* 1->2 : 0:X 2:b 3:d
edit0  1->2*: 0:X 2:b 3:d
1->2* edit0 : 0:X 2:b 3:d
1->2  edit0*: 0:X 2:b 3:d
edit0* 1->3 : 0:X 2:c 3:b
edit0  1->3*: 0:X 2:c 3:b
1->3* edit0 : 0:X 2:c 3:b
1->3  edit0*: 0:X 2:c 3:b
edit0* 1->4 : 0:X 2:c 3:d 4:b
edit0  1->4*: 0:X 2:c 3:d 4:b
1->4* edit0 : 0:X 2:c 3:d 4:b
1->4  edit0*: 0:X 2:c 3:d 4:b
edit0* 1->5 : 0:X 2:c 3:d 5:b
edit0  1->5*: 0:X 2:c 3:d 5:b
1->5* edit0 : 0:X 2:c 3:d 5:b
1->5  edit0*: 0:X 2:c 3:d 5:b
edit0* 2->0 : 0:c 1:b 3:d
edit0  2->0*: 0:c 1:b 3:d
2->0* edit0 : 0:c 1:b 3:d
2->0  edit0*: 0:c 1:b 3:d
edit0* 2->1 : 0:X 1:c 3:d
edit0  2->1*: 0:X 1:c 3:d
2->1* edit0 : 0:X 1:c 3:d
2->1  edit0*: 0:X 1:c 3:d
edit0* 2->2 : 0:X 1:b 2:c 3:d
edit0  2->2*: 0:X 1:b 2:c 3:d
2->2* edit0 : 0:X 1:b 2:c 3:d
2->2  edit0*: 0:X 1:b 2:c 3:d
edit0* 2->3 : 0:X 1:b 3:c
edit0  2->3*: 0:X 1:b 3:c
2->3* edit0 : 0:X 1:b 3:c
2->3  edit0*: 0:X 1:b 3:c
edit0* 2->4 : 0:X 1:b 3:d 4:c
edit0  2->4*: 0:X 1:b 3:d 4:c
2->4* edit0 : 0:X 1:b 3:d 4:c
2->4  edit0*: 0:X 1:b 3:d 4:c
edit0* 2->5 : 0:X 1:b 3:d 5:c
edit0  2->5*: 0:X 1:b 3:d 5:c
2->5* edit0 : 0:X 1:b 3:d 5:c
2->5  edit0*: 0:X 1:b 3:d 5:c
edit0* 3->0 : 0:d 1:b 2:c
edit0  3->0*: 0:d 1:b 2:c
3->0* edit0 : 0:d 1:b 2:c
3->0  edit0*: 0:d 1:b 2:c
edit0* 3->1 : 0:X 1:d 2:c
edit0  3->1*: 0:X 1:d 2:c
3->1* edit0 : 0:X 1:d 2:c
3->1  edit0*: 0:X 1:d 2:c
edit0* 3->2 : 0:X 1:b 2:d
edit0  3->2*: 0:X 1:b 2:d
3->2* edit0 : 0:X 1:b 2:d
3->2  edit0*: 0:X 1:b 2:d
edit0* 3->3 : 0:X 1:b 2:c 3:d
edit0  3->3*: 0:X 1:b 2:c 3:d
3->3* edit0 : 0:X 1:b 2:c 3:d
3->3  edit0*: 0:X 1:b 2:c 3:d
edit0* 3->4 : 0:X 1:b 2:c 4:d
edit0  3->4*: 0:X 1:b 2:c 4:d
3->4* edit0 : 0:X 1:b 2:c 4:d
3->4  edit0*: 0:X 1:b 2:c 4:d
edit0* 3->5 : 0:X 1:b 2:c 5:d
edit0  3->5*: 0:X 1:b 2:c 5:d
3->5* edit0 : 0:X 1:b 2:c 5:d
3->5  edit0*: 0:X 1:b 2:c 5:d
edit1* 0->0 : 0:a 1:X 2:c 3:d
edit1  0->0*: 0:a 1:X 2:c 3:d
0->0* edit1 : 0:a 1:X 2:c 3:d
0->0  edit1*: 0:a 1:X 2:c 3:d
edit1* 0->1 : 1:a 2:c 3:d
edit1  0->1*: 1:a 2:c 3:d
0->1* edit1 : 1:a 2:c 3:d
0->1  edit1*: 1:a 2:c 3:d
edit1* 0->2 : 1:X 2:a 3:d
edit1  0->2*: 1:X 2:a 3:d
0->2* edit1 : 1:X 2:a 3:d
0->2  edit1*: 1:X 2:a 3:d
edit1* 0->3 : 1:X 2:c 3:a
edit1  0->3*: 1:X 2:c 3:a
0->3* edit1 : 1:X 2:c 3:a
0->3  edit1*: 1:X 2:c 3:a
edit1* 0->4 : 1:X 2:c 3:d 4:a
edit1  0->4*: 1:X 2:c 3:d 4:a
0->4* edit1 : 1:X 2:c 3:d 4:a
0->4  edit1*: 1:X 2:c 3:d 4:a
edit1* 0->5 : 1:X 2:c 3:d 5:a
edit1  0->5*: 1:X 2:c 3:d 5:a
0->5* edit1 : 1:X 2:c 3:d 5:a
0->5  edit1*: 1:X 2:c 3:d 5:a
edit1* 1->0 : 0:X 2:c 3:d
edit1  1->0*: 0:X 2:c 3:d
1->0* edit1 : 0:X 2:c 3:d
1->0  edit1*: 0:X 2:c 3:d
edit1* 1->1 : 0:a 1:X 2:c 3:d
edit1  1->1*: 0:a 1:X 2:c 3:d
1->1* edit1 : 0:a 1:X 2:c 3:d
1->1  edit1*: 0:a 1:X 2:c 3:d
edit1* 1->2 : 0:a 2:X 3:d
edit1  1->2*: 0:a 2:X 3:d
1->2* edit1 : 0:a 2:X 3:d
1->2  edit1*: 0:a 2:X 3:d
edit1* 1->3 : 0:a 2:c 3:X
edit1  1->3*: 0:a 2:c 3:X
1->3* edit1 : 0:a 2:c 3:X
1->3  edit1*: 0:a 2:c 3:X
edit1* 1->4 : 0:a 2:c 3:d 4:X
edit1  1->4*: 0:a 2:c 3:d 4:X
1->4* edit1 : 0:a 2:c 3:d 4:X
1->4  edit1*: 0:a 2:c 3:d 4:X
edit1* 1->5 : 0:a 2:c 3:d 5:X
edit1  1->5*: 0:a 2:c 3:d 5:X
1->5* edit1 : 0:a 2:c 3:d 5:X
1->5  edit1*: 0:a 2:c 3:d 5:X
edit1* 2->0 : 0:c 1:X 3:d
edit1  2->0*: 0:c 1:X 3:d
2->0* edit1 : 0:c 1:X 3:d
2->0  edit1*: 0:c 1:X 3:d
edit1* 2->1 : 0:a 1:c 3:d
edit1  2->1*: 0:a 1:c 3:d
2->1* edit1 : 0:a 1:c 3:d
2->1  edit1*: 0:a 1:c 3:d
edit1* 2->2 : 0:a 1:X 2:c 3:d
edit1  2->2*: 0:a 1:X 2:c 3:d
2->2* edit1 : 0:a 1:X 2:c 3:d
2->2  edit1*: 0:a 1:X 2:c 3:d
edit1* 2->3 : 0:a 1:X 3:c
edit1  2->3*: 0:a 1:X 3:c
2->3* edit1 : 0:a 1:X 3:c
2->3  edit1*: 0:a 1:X 3:c
edit1* 2->4 : 0:a 1:X 3:d 4:c
edit1  2->4*: 0:a 1:X 3:d 4:c
2->4* edit1 : 0:a 1:X 3:d 4:c
2->4  edit1*: 0:a 1:X 3:d 4:c
edit1* 2->5 : 0:a 1:X 3:d 5:c
edit1  2->5*: 0:a 1:X 3:d 5:c
2->5* edit1 : 0:a 1:X 3:d 5:c
2->5  edit1*: 0:a 1:X 3:d 5:c
edit1* 3->0 : 0:d 1:X 2:c
edit1  3->0*: 0:d 1:X 2:c
3->0* edit1 : 0:d 1:X 2:c
3->0  edit1*: 0:d 1:X 2:c
edit1* 3->1 : 0:a 1:d 2:c
edit1  3->1*: 0:a 1:d 2:c
3->1* edit1 : 0:a 1:d 2:c
3->1  edit1*: 0:a 1:d 2:c
edit1* 3->2 : 0:a 1:X 2:d
edit1  3->2*: 0:a 1:X 2:d
3->2* edit1 : 0:a 1:X 2:d
3->2  edit1*: 0:a 1:X 2:d
edit1* 3->3 : 0:a 1:X 2:c 3:d
edit1  3->3*: 0:a 1:X 2:c 3:d
3->3* edit1 : 0:a 1:X 2:c 3:d
3->3  edit1*: 0:a 1:X 2:c 3:d
edit1* 3->4 : 0:a 1:X 2:c 4:d
edit1  3->4*: 0:a 1:X 2:c 4:d
3->4* edit1 : 0:a 1:X 2:c 4:d
3->4  edit1*: 0:a 1:X 2:c 4:d
edit1* 3->5 : 0:a 1:X 2:c 5:d
edit1  3->5*: 0:a 1:X 2:c 5:d
3->5* edit1 : 0:a 1:X 2:c 5:d
3->5  edit1*: 0:a 1:X 2:c 5:d
edit2* 0->0 : 0:a 1:b 2:X 3:d
edit2  0->0*: 0:a 1:b 2:X 3:d
0->0* edit2 : 0:a 1:b 2:X 3:d
0->0  edit2*: 0:a 1:b 2:X 3:d
edit2* 0->1 : 1:a 2:X 3:d
edit2  0->1*: 1:a 2:X 3:d
0->1* edit2 : 1:a 2:X 3:d
0->1  edit2*: 1:a 2:X 3:d
edit2* 0->2 : 1:b 2:a 3:d
edit2  0->2*: 1:b 2:a 3:d
0->2* edit2 : 1:b 2:a 3:d
0->2  edit2*: 1:b 2:a 3:d
edit2* 0->3 : 1:b 2:X 3:a
edit2  0->3*: 1:b 2:X 3:a
0->3* edit2 : 1:b 2:X 3:a
0->3  edit2*: 1:b 2:X 3:a
edit2* 0->4 : 1:b 2:X 3:d 4:a
edit2  0->4*: 1:b 2:X 3:d 4:a
0->4* edit2 : 1:b 2:X 3:d 4:a
0->4  edit2*: 1:b 2:X 3:d 4:a
edit2* 0->5 : 1:b 2:X 3:d 5:a
edit2  0->5*: 1:b 2:X 3:d 5:a
0->5* edit2 : 1:b 2:X 3:d 5:a
0->5  edit2*: 1:b 2:X 3:d 5:a
edit2* 1->0 : 0:b 2:X 3:d
edit2  1->0*: 0:b 2:X 3:d
1->0* edit2 : 0:b 2:X 3:d
1->0  edit2*: 0:b 2:X 3:d
edit2* 1->1 : 0:a 1:b 2:X 3:d
edit2  1->1*: 0:a 1:b 2:X 3:d
1->1* edit2 : 0:a 1:b 2:X 3:d
1->1  edit2*: 0:a 1:b 2:X 3:d
edit2* 1->2 : 0:a 2:b 3:d
edit2  1->2*: 0:a 2:b 3:d
1->2* edit2 : 0:a 2:b 3:d
1->2  edit2*: 0:a 2:b 3:d
edit2* 1->3 : 0:a 2:X 3:b
edit2  1->3*: 0:a 2:X 3:b
1->3* edit2 : 0:a 2:X 3:b
1->3  edit2*: 0:a 2:X 3:b
edit2* 1->4 : 0:a 2:X 3:d 4:b
edit2  1->4*: 0:a 2:X 3:d 4:b
1->4* edit2 : 0:a 2:X 3:d 4:b
1->4  edit2*: 0:a 2:X 3:d 4:b
edit2* 1->5 : 0:a 2:X 3:d 5:b
edit2  1->5*: 0:a 2:X 3:d 5:b
1->5* edit2 : 0:a 2:X 3:d 5:b
1->5  edit2*: 0:a 2:X 3:d 5:b
edit2* 2->0 : 0:X 1:b 3:d
edit2  2->0*: 0:X 1:b 3:d
2->0* edit2 : 0:X 1:b 3:d
2->0  edit2*: 0:X 1:b 3:d
edit2* 2->1 : 0:a 1:X 3:d
edit2  2->1*: 0:a 1:X 3:d
2->1* edit2 : 0:a 1:X 3:d
2->1  edit2*: 0:a 1:X 3:d
edit2* 2->2 : 0:a 1:b 2:X 3:d
edit2  2->2*: 0:a 1:b 2:X 3:d
2->2* edit2 : 0:a 1:b 2:X 3:d
2->2  edit2*: 0:a 1:b 2:X 3:d
edit2* 2->3 : 0:a 1:b 3:X
edit2  2->3*: 0:a 1:b 3:X
2->3* edit2 : 0:a 1:b 3:X
2->3  edit2*: 0:a 1:b 3:X
edit2* 2->4 : 0:a 1:b 3:d 4:X
edit2  2->4*: 0:a 1:b 3:d 4:X
2->4* edit2 : 0:a 1:b 3:d 4:X
2->4  edit2*: 0:a 1:b 3:d 4:X
edit2* 2->5 : 0:a 1:b 3:d 5:X
edit2  2->5*: 0:a 1:b 3:d 5:X
2->5* edit2 : 0:a 1:b 3:d 5:X
2->5  edit2*: 0:a 1:b 3:d 5:X
edit2* 3->0 : 0:d 1:b 2:X
edit2  3->0*: 0:d 1:b 2:X
3->0* edit2 : 0:d 1:b 2:X
3->0  edit2*: 0:d 1:b 2:X
edit2* 3->1 : 0:a 1:d 2:X
edit2  3->1*: 0:a 1:d 2:X
3->1* edit2 : 0:a 1:d 2:X
3->1  edit2*: 0:a 1:d 2:X
edit2* 3->2 : 0:a 1:b 2:d
edit2  3->2*: 0:a 1:b 2:d
3->2* edit2 : 0:a 1:b 2:d
3->2  edit2*: 0:a 1:b 2:d
edit2* 3->3 : 0:a 1:b 2:X 3:d
edit2  3->3*: 0:a 1:b 2:X 3:d
3->3* edit2 : 0:a 1:b 2:X 3:d
3->3  edit2*: 0:a 1:b 2:X 3:d
edit2* 3->4 : 0:a 1:b 2:X 4:d
edit2  3->4*: 0:a 1:b 2:X 4:d
3->4* edit2 : 0:a 1:b 2:X 4:d
3->4  edit2*: 0:a 1:b 2:X 4:d
edit2* 3->5 : 0:a 1:b 2:X 5:d
edit2  3->5*: 0:a 1:b 2:X 5:d
3->5* edit2 : 0:a 1:b 2:X 5:d
3->5  edit2*: 0:a 1:b 2:X 5:d
edit3* 0->0 : 0:a 1:b 2:c 3:X
edit3  0->0*: 0:a 1:b 2:c 3:X
0->0* edit3 : 0:a 1:b 2:c 3:X
0->0  edit3*: 0:a 1:b 2:c 3:X
edit3* 0->1 : 1:a 2:c 3:X
edit3  0->1*: 1:a 2:c 3:X
0->1* edit3 : 1:a 2:c 3:X
0->1  edit3*: 1:a 2:c 3:X
edit3* 0->2 : 1:b 2:a 3:X
edit3  0->2*: 1:b 2:a 3:X
0->2* edit3 : 1:b 2:a 3:X
0->2  edit3*: 1:b 2:a 3:X
edit3* 0->3 : 1:b 2:c 3:a
edit3  0->3*: 1:b 2:c 3:a
0->3* edit3 : 1:b 2:c 3:a
0->3  edit3*: 1:b 2:c 3:a
edit3* 0->4 : 1:b 2:c 3:X 4:a
edit3  0->4*: 1:b 2:c 3:X 4:a
0->4* edit3 : 1:b 2:c 3:X 4:a
0->4  edit3*: 1:b 2:c 3:X 4:a
edit3* 0->5 : 1:b 2:c 3:X 5:a
edit3  0->5*: 1:b 2:c 3:X 5:a
0->5* edit3 : 1:b 2:c 3:X 5:a
0->5  edit3*: 1:b 2:c 3:X 5:a
edit3* 1->0 : 0:b 2:c 3:X
edit3  1->0*: 0:b 2:c 3:X
1->0* edit3 : 0:b 2:c 3:X
1->0  edit3*: 0:b 2:c 3:X
edit3* 1->1 : 0:a 1:b 2:c 3:X
edit3  1->1*: 0:a 1:b 2:c 3:X
1->1* edit3 : 0:a 1:b 2:c 3:X
1->1  edit3*: 0:a 1:b 2:c 3:X
edit3* 1->2 : 0:a 2:b 3:X
edit3  1->2*: 0:a 2:b 3:X
1->2* edit3 : 0:a 2:b 3:X
1->2  edit3*: 0:a 2:b 3:X
edit3* 1->3 : 0:a 2:c 3:b
edit3  1->3*: 0:a 2:c 3:b
1->3* edit3 : 0:a 2:c 3:b
1->3  edit3*: 0:a 2:c 3:b
edit3* 1->4 : 0:a 2:c 3:X 4:b
edit3  1->4*: 0:a 2:c 3:X 4:b
1->4* edit3 : 0:a 2:c 3:X 4:b
1->4  edit3*: 0:a 2:c 3:X 4:b
edit3* 1->5 : 0:a 2:c 3:X 5:b
edit3  1->5*: 0:a 2:c 3:X 5:b
1->5* edit3 : 0:a 2:c 3:X 5:b
1->5  edit3*: 0:a 2:c 3:X 5:b
edit3* 2->0 : 0:c 1:b 3:X
edit3  2->0*: 0:c 1:b 3:X
2->0* edit3 : 0:c 1:b 3:X
2->0  edit3*: 0:c 1:b 3:X
edit3* 2->1 : 0:a 1:c 3:X
edit3  2->1*: 0:a 1:c 3:X
2->1* edit3 : 0:a 1:c 3:X
2->1  edit3*: 0:a 1:c 3:X
edit3* 2->2 : 0:a 1:b 2:c 3:X
edit3  2->2*: 0:a 1:b 2:c 3:X
2->2* edit3 : 0:a 1:b 2:c 3:X
2->2  edit3*: 0:a 1:b 2:c 3:X
edit3* 2->3 : 0:a 1:b 3:c
edit3  2->3*: 0:a 1:b 3:c
2->3* edit3 : 0:a 1:b 3:c
2->3  edit3*: 0:a 1:b 3:c
edit3* 2->4 : 0:a 1:b 3:X 4:c
edit3  2->4*: 0:a 1:b 3:X 4:c
2->4* edit3 : 0:a 1:b 3:X 4:c
2->4  edit3*: 0:a 1:b 3:X 4:c
edit3* 2->5 : 0:a 1:b 3:X 5:c
edit3  2->5*: 0:a 1:b 3:X 5:c
2->5* edit3 : 0:a 1:b 3:X 5:c
2->5  edit3*: 0:a 1:b 3:X 5:c
edit3* 3->0 : 0:X 1:b 2:c
edit3  3->0*: 0:X 1:b 2:c
3->0* edit3 : 0:X 1:b 2:c
3->0  edit3*: 0:X 1:b 2:c
edit3* 3->1 : 0:a 1:X 2:c
edit3  3->1*: 0:a 1:X 2:c
3->1* edit3 : 0:a 1:X 2:c
3->1  edit3*: 0:a 1:X 2:c
edit3* 3->2 : 0:a 1:b 2:X
edit3  3->2*: 0:a 1:b 2:X
3->2* edit3 : 0:a 1:b 2:X
3->2  edit3*: 0:a 1:b 2:X
edit3* 3->3 : 0:a 1:b 2:c 3:X
edit3  3->3*: 0:a 1:b 2:c 3:X
3->3* edit3 : 0:a 1:b 2:c 3:X
3->3  edit3*: 0:a 1:b 2:c 3:X
edit3* 3->4 : 0:a 1:b 2:c 4:X
edit3  3->4*: 0:a 1:b 2:c 4:X
3->4* edit3 : 0:a 1:b 2:c 4:X
3->4  edit3*: 0:a 1:b 2:c 4:X
edit3* 3->5 : 0:a 1:b 2:c 5:X
edit3  3->5*: 0:a 1:b 2:c 5:X
3->5* edit3 : 0:a 1:b 2:c 5:X
3->5  edit3*: 0:a 1:b 2:c 5:X''';

const expectedTestTransformEditDeleteKey = '''
edit0* del0 : 1:b 2:c 3:d
edit0  del0*: 1:b 2:c 3:d
del0* edit0 : 1:b 2:c 3:d
del0  edit0*: 1:b 2:c 3:d
edit0* del1 : 0:X 2:c 3:d
edit0  del1*: 0:X 2:c 3:d
del1* edit0 : 0:X 2:c 3:d
del1  edit0*: 0:X 2:c 3:d
edit0* del2 : 0:X 1:b 3:d
edit0  del2*: 0:X 1:b 3:d
del2* edit0 : 0:X 1:b 3:d
del2  edit0*: 0:X 1:b 3:d
edit0* del3 : 0:X 1:b 2:c
edit0  del3*: 0:X 1:b 2:c
del3* edit0 : 0:X 1:b 2:c
del3  edit0*: 0:X 1:b 2:c
edit1* del0 : 1:X 2:c 3:d
edit1  del0*: 1:X 2:c 3:d
del0* edit1 : 1:X 2:c 3:d
del0  edit1*: 1:X 2:c 3:d
edit1* del1 : 0:a 2:c 3:d
edit1  del1*: 0:a 2:c 3:d
del1* edit1 : 0:a 2:c 3:d
del1  edit1*: 0:a 2:c 3:d
edit1* del2 : 0:a 1:X 3:d
edit1  del2*: 0:a 1:X 3:d
del2* edit1 : 0:a 1:X 3:d
del2  edit1*: 0:a 1:X 3:d
edit1* del3 : 0:a 1:X 2:c
edit1  del3*: 0:a 1:X 2:c
del3* edit1 : 0:a 1:X 2:c
del3  edit1*: 0:a 1:X 2:c
edit2* del0 : 1:b 2:X 3:d
edit2  del0*: 1:b 2:X 3:d
del0* edit2 : 1:b 2:X 3:d
del0  edit2*: 1:b 2:X 3:d
edit2* del1 : 0:a 2:X 3:d
edit2  del1*: 0:a 2:X 3:d
del1* edit2 : 0:a 2:X 3:d
del1  edit2*: 0:a 2:X 3:d
edit2* del2 : 0:a 1:b 3:d
edit2  del2*: 0:a 1:b 3:d
del2* edit2 : 0:a 1:b 3:d
del2  edit2*: 0:a 1:b 3:d
edit2* del3 : 0:a 1:b 2:X
edit2  del3*: 0:a 1:b 2:X
del3* edit2 : 0:a 1:b 2:X
del3  edit2*: 0:a 1:b 2:X
edit3* del0 : 1:b 2:c 3:X
edit3  del0*: 1:b 2:c 3:X
del0* edit3 : 1:b 2:c 3:X
del0  edit3*: 1:b 2:c 3:X
edit3* del1 : 0:a 2:c 3:X
edit3  del1*: 0:a 2:c 3:X
del1* edit3 : 0:a 2:c 3:X
del1  edit3*: 0:a 2:c 3:X
edit3* del2 : 0:a 1:b 3:X
edit3  del2*: 0:a 1:b 3:X
del2* edit3 : 0:a 1:b 3:X
del2  edit3*: 0:a 1:b 3:X
edit3* del3 : 0:a 1:b 2:c
edit3  del3*: 0:a 1:b 2:c
del3* edit3 : 0:a 1:b 2:c
del3  edit3*: 0:a 1:b 2:c''';

const expectedTestTransformEditSetKey = '''
edit0* set0 : 0:Y 1:b 2:c 3:d
edit0  set0*: 0:Y 1:b 2:c 3:d
set0* edit0 : 0:Y 1:b 2:c 3:d
set0  edit0*: 0:Y 1:b 2:c 3:d
edit0* set1 : 0:X 1:Y 2:c 3:d
edit0  set1*: 0:X 1:Y 2:c 3:d
set1* edit0 : 0:X 1:Y 2:c 3:d
set1  edit0*: 0:X 1:Y 2:c 3:d
edit0* set2 : 0:X 1:b 2:Y 3:d
edit0  set2*: 0:X 1:b 2:Y 3:d
set2* edit0 : 0:X 1:b 2:Y 3:d
set2  edit0*: 0:X 1:b 2:Y 3:d
edit0* set3 : 0:X 1:b 2:c 3:Y
edit0  set3*: 0:X 1:b 2:c 3:Y
set3* edit0 : 0:X 1:b 2:c 3:Y
set3  edit0*: 0:X 1:b 2:c 3:Y
edit1* set0 : 0:Y 1:X 2:c 3:d
edit1  set0*: 0:Y 1:X 2:c 3:d
set0* edit1 : 0:Y 1:X 2:c 3:d
set0  edit1*: 0:Y 1:X 2:c 3:d
edit1* set1 : 0:a 1:Y 2:c 3:d
edit1  set1*: 0:a 1:Y 2:c 3:d
set1* edit1 : 0:a 1:Y 2:c 3:d
set1  edit1*: 0:a 1:Y 2:c 3:d
edit1* set2 : 0:a 1:X 2:Y 3:d
edit1  set2*: 0:a 1:X 2:Y 3:d
set2* edit1 : 0:a 1:X 2:Y 3:d
set2  edit1*: 0:a 1:X 2:Y 3:d
edit1* set3 : 0:a 1:X 2:c 3:Y
edit1  set3*: 0:a 1:X 2:c 3:Y
set3* edit1 : 0:a 1:X 2:c 3:Y
set3  edit1*: 0:a 1:X 2:c 3:Y
edit2* set0 : 0:Y 1:b 2:X 3:d
edit2  set0*: 0:Y 1:b 2:X 3:d
set0* edit2 : 0:Y 1:b 2:X 3:d
set0  edit2*: 0:Y 1:b 2:X 3:d
edit2* set1 : 0:a 1:Y 2:X 3:d
edit2  set1*: 0:a 1:Y 2:X 3:d
set1* edit2 : 0:a 1:Y 2:X 3:d
set1  edit2*: 0:a 1:Y 2:X 3:d
edit2* set2 : 0:a 1:b 2:Y 3:d
edit2  set2*: 0:a 1:b 2:Y 3:d
set2* edit2 : 0:a 1:b 2:Y 3:d
set2  edit2*: 0:a 1:b 2:Y 3:d
edit2* set3 : 0:a 1:b 2:X 3:Y
edit2  set3*: 0:a 1:b 2:X 3:Y
set3* edit2 : 0:a 1:b 2:X 3:Y
set3  edit2*: 0:a 1:b 2:X 3:Y
edit3* set0 : 0:Y 1:b 2:c 3:X
edit3  set0*: 0:Y 1:b 2:c 3:X
set0* edit3 : 0:Y 1:b 2:c 3:X
set0  edit3*: 0:Y 1:b 2:c 3:X
edit3* set1 : 0:a 1:Y 2:c 3:X
edit3  set1*: 0:a 1:Y 2:c 3:X
set1* edit3 : 0:a 1:Y 2:c 3:X
set1  edit3*: 0:a 1:Y 2:c 3:X
edit3* set2 : 0:a 1:b 2:Y 3:X
edit3  set2*: 0:a 1:b 2:Y 3:X
set2* edit3 : 0:a 1:b 2:Y 3:X
set2  edit3*: 0:a 1:b 2:Y 3:X
edit3* set3 : 0:a 1:b 2:c 3:Y
edit3  set3*: 0:a 1:b 2:c 3:Y
set3* edit3 : 0:a 1:b 2:c 3:Y
set3  edit3*: 0:a 1:b 2:c 3:Y''';

const expectedTestTransformEditEditKey = '''
edit0* edit0 : 0:XY 1:b 2:c 3:d
edit0  edit0*: 0:YX 1:b 2:c 3:d
edit0* edit1 : 0:X 1:Y 2:c 3:d
edit0  edit1*: 0:X 1:Y 2:c 3:d
edit0* edit2 : 0:X 1:b 2:Y 3:d
edit0  edit2*: 0:X 1:b 2:Y 3:d
edit0* edit3 : 0:X 1:b 2:c 3:Y
edit0  edit3*: 0:X 1:b 2:c 3:Y
edit1* edit0 : 0:Y 1:X 2:c 3:d
edit1  edit0*: 0:Y 1:X 2:c 3:d
edit1* edit1 : 0:a 1:XY 2:c 3:d
edit1  edit1*: 0:a 1:YX 2:c 3:d
edit1* edit2 : 0:a 1:X 2:Y 3:d
edit1  edit2*: 0:a 1:X 2:Y 3:d
edit1* edit3 : 0:a 1:X 2:c 3:Y
edit1  edit3*: 0:a 1:X 2:c 3:Y
edit2* edit0 : 0:Y 1:b 2:X 3:d
edit2  edit0*: 0:Y 1:b 2:X 3:d
edit2* edit1 : 0:a 1:Y 2:X 3:d
edit2  edit1*: 0:a 1:Y 2:X 3:d
edit2* edit2 : 0:a 1:b 2:XY 3:d
edit2  edit2*: 0:a 1:b 2:YX 3:d
edit2* edit3 : 0:a 1:b 2:X 3:Y
edit2  edit3*: 0:a 1:b 2:X 3:Y
edit3* edit0 : 0:Y 1:b 2:c 3:X
edit3  edit0*: 0:Y 1:b 2:c 3:X
edit3* edit1 : 0:a 1:Y 2:c 3:X
edit3  edit1*: 0:a 1:Y 2:c 3:X
edit3* edit2 : 0:a 1:b 2:Y 3:X
edit3  edit2*: 0:a 1:b 2:Y 3:X
edit3* edit3 : 0:a 1:b 2:c 3:XY
edit3  edit3*: 0:a 1:b 2:c 3:YX''';

const expectedTestTransformRenameRename = '''
0->0* 0->0 : 0:a 1:b 2:c 3:d 4:e 5:f
0->0  0->0*: 0:a 1:b 2:c 3:d 4:e 5:f
0->0* 0->1 : 1:a 2:c 3:d 4:e 5:f
0->0  0->1*: 1:a 2:c 3:d 4:e 5:f
0->0* 0->2 : 1:b 2:a 3:d 4:e 5:f
0->0  0->2*: 1:b 2:a 3:d 4:e 5:f
0->0* 0->3 : 1:b 2:c 3:a 4:e 5:f
0->0  0->3*: 1:b 2:c 3:a 4:e 5:f
0->0* 0->4 : 1:b 2:c 3:d 4:a 5:f
0->0  0->4*: 1:b 2:c 3:d 4:a 5:f
0->0* 0->5 : 1:b 2:c 3:d 4:e 5:a
0->0  0->5*: 1:b 2:c 3:d 4:e 5:a
0->0* 1->0 : 0:b 2:c 3:d 4:e 5:f
0->0  1->0*: 0:b 2:c 3:d 4:e 5:f
0->0* 1->1 : 0:a 1:b 2:c 3:d 4:e 5:f
0->0  1->1*: 0:a 1:b 2:c 3:d 4:e 5:f
0->0* 1->2 : 0:a 2:b 3:d 4:e 5:f
0->0  1->2*: 0:a 2:b 3:d 4:e 5:f
0->0* 1->3 : 0:a 2:c 3:b 4:e 5:f
0->0  1->3*: 0:a 2:c 3:b 4:e 5:f
0->0* 1->4 : 0:a 2:c 3:d 4:b 5:f
0->0  1->4*: 0:a 2:c 3:d 4:b 5:f
0->0* 1->5 : 0:a 2:c 3:d 4:e 5:b
0->0  1->5*: 0:a 2:c 3:d 4:e 5:b
0->0* 2->0 : 0:c 1:b 3:d 4:e 5:f
0->0  2->0*: 0:c 1:b 3:d 4:e 5:f
0->0* 2->1 : 0:a 1:c 3:d 4:e 5:f
0->0  2->1*: 0:a 1:c 3:d 4:e 5:f
0->0* 2->2 : 0:a 1:b 2:c 3:d 4:e 5:f
0->0  2->2*: 0:a 1:b 2:c 3:d 4:e 5:f
0->0* 2->3 : 0:a 1:b 3:c 4:e 5:f
0->0  2->3*: 0:a 1:b 3:c 4:e 5:f
0->0* 2->4 : 0:a 1:b 3:d 4:c 5:f
0->0  2->4*: 0:a 1:b 3:d 4:c 5:f
0->0* 2->5 : 0:a 1:b 3:d 4:e 5:c
0->0  2->5*: 0:a 1:b 3:d 4:e 5:c
0->0* 3->0 : 0:d 1:b 2:c 4:e 5:f
0->0  3->0*: 0:d 1:b 2:c 4:e 5:f
0->0* 3->1 : 0:a 1:d 2:c 4:e 5:f
0->0  3->1*: 0:a 1:d 2:c 4:e 5:f
0->0* 3->2 : 0:a 1:b 2:d 4:e 5:f
0->0  3->2*: 0:a 1:b 2:d 4:e 5:f
0->0* 3->3 : 0:a 1:b 2:c 3:d 4:e 5:f
0->0  3->3*: 0:a 1:b 2:c 3:d 4:e 5:f
0->0* 3->4 : 0:a 1:b 2:c 4:d 5:f
0->0  3->4*: 0:a 1:b 2:c 4:d 5:f
0->0* 3->5 : 0:a 1:b 2:c 4:e 5:d
0->0  3->5*: 0:a 1:b 2:c 4:e 5:d
0->0* 4->0 : 0:e 1:b 2:c 3:d 5:f
0->0  4->0*: 0:e 1:b 2:c 3:d 5:f
0->0* 4->1 : 0:a 1:e 2:c 3:d 5:f
0->0  4->1*: 0:a 1:e 2:c 3:d 5:f
0->0* 4->2 : 0:a 1:b 2:e 3:d 5:f
0->0  4->2*: 0:a 1:b 2:e 3:d 5:f
0->0* 4->3 : 0:a 1:b 2:c 3:e 5:f
0->0  4->3*: 0:a 1:b 2:c 3:e 5:f
0->0* 4->4 : 0:a 1:b 2:c 3:d 4:e 5:f
0->0  4->4*: 0:a 1:b 2:c 3:d 4:e 5:f
0->0* 4->5 : 0:a 1:b 2:c 3:d 5:e
0->0  4->5*: 0:a 1:b 2:c 3:d 5:e
0->0* 5->0 : 0:f 1:b 2:c 3:d 4:e
0->0  5->0*: 0:f 1:b 2:c 3:d 4:e
0->0* 5->1 : 0:a 1:f 2:c 3:d 4:e
0->0  5->1*: 0:a 1:f 2:c 3:d 4:e
0->0* 5->2 : 0:a 1:b 2:f 3:d 4:e
0->0  5->2*: 0:a 1:b 2:f 3:d 4:e
0->0* 5->3 : 0:a 1:b 2:c 3:f 4:e
0->0  5->3*: 0:a 1:b 2:c 3:f 4:e
0->0* 5->4 : 0:a 1:b 2:c 3:d 4:f
0->0  5->4*: 0:a 1:b 2:c 3:d 4:f
0->0* 5->5 : 0:a 1:b 2:c 3:d 4:e 5:f
0->0  5->5*: 0:a 1:b 2:c 3:d 4:e 5:f
0->1* 0->0 : 1:a 2:c 3:d 4:e 5:f
0->1  0->0*: 1:a 2:c 3:d 4:e 5:f
0->1* 0->1 : 1:a 2:c 3:d 4:e 5:f
0->1  0->1*: 1:a 2:c 3:d 4:e 5:f
0->1* 0->2 : 1:a 3:d 4:e 5:f
0->1  0->2*: 2:a 3:d 4:e 5:f
0->1* 0->3 : 1:a 2:c 4:e 5:f
0->1  0->3*: 2:c 3:a 4:e 5:f
0->1* 0->4 : 1:a 2:c 3:d 5:f
0->1  0->4*: 2:c 3:d 4:a 5:f
0->1* 0->5 : 1:a 2:c 3:d 4:e
0->1  0->5*: 2:c 3:d 4:e 5:a
0->1* 1->0 : 2:c 3:d 4:e 5:f
0->1  1->0*: 2:c 3:d 4:e 5:f
0->1* 1->1 : 1:a 2:c 3:d 4:e 5:f
0->1  1->1*: 1:a 2:c 3:d 4:e 5:f
0->1* 1->2 : 2:a 3:d 4:e 5:f
0->1  1->2*: 2:a 3:d 4:e 5:f
0->1* 1->3 : 2:c 3:a 4:e 5:f
0->1  1->3*: 2:c 3:a 4:e 5:f
0->1* 1->4 : 2:c 3:d 4:a 5:f
0->1  1->4*: 2:c 3:d 4:a 5:f
0->1* 1->5 : 2:c 3:d 4:e 5:a
0->1  1->5*: 2:c 3:d 4:e 5:a
0->1* 2->0 : 1:c 3:d 4:e 5:f
0->1  2->0*: 1:c 3:d 4:e 5:f
0->1* 2->1 : 1:a 3:d 4:e 5:f
0->1  2->1*: 1:c 3:d 4:e 5:f
0->1* 2->2 : 1:a 2:c 3:d 4:e 5:f
0->1  2->2*: 1:a 2:c 3:d 4:e 5:f
0->1* 2->3 : 1:a 3:c 4:e 5:f
0->1  2->3*: 1:a 3:c 4:e 5:f
0->1* 2->4 : 1:a 3:d 4:c 5:f
0->1  2->4*: 1:a 3:d 4:c 5:f
0->1* 2->5 : 1:a 3:d 4:e 5:c
0->1  2->5*: 1:a 3:d 4:e 5:c
0->1* 3->0 : 1:d 2:c 4:e 5:f
0->1  3->0*: 1:d 2:c 4:e 5:f
0->1* 3->1 : 1:a 2:c 4:e 5:f
0->1  3->1*: 1:d 2:c 4:e 5:f
0->1* 3->2 : 1:a 2:d 4:e 5:f
0->1  3->2*: 1:a 2:d 4:e 5:f
0->1* 3->3 : 1:a 2:c 3:d 4:e 5:f
0->1  3->3*: 1:a 2:c 3:d 4:e 5:f
0->1* 3->4 : 1:a 2:c 4:d 5:f
0->1  3->4*: 1:a 2:c 4:d 5:f
0->1* 3->5 : 1:a 2:c 4:e 5:d
0->1  3->5*: 1:a 2:c 4:e 5:d
0->1* 4->0 : 1:e 2:c 3:d 5:f
0->1  4->0*: 1:e 2:c 3:d 5:f
0->1* 4->1 : 1:a 2:c 3:d 5:f
0->1  4->1*: 1:e 2:c 3:d 5:f
0->1* 4->2 : 1:a 2:e 3:d 5:f
0->1  4->2*: 1:a 2:e 3:d 5:f
0->1* 4->3 : 1:a 2:c 3:e 5:f
0->1  4->3*: 1:a 2:c 3:e 5:f
0->1* 4->4 : 1:a 2:c 3:d 4:e 5:f
0->1  4->4*: 1:a 2:c 3:d 4:e 5:f
0->1* 4->5 : 1:a 2:c 3:d 5:e
0->1  4->5*: 1:a 2:c 3:d 5:e
0->1* 5->0 : 1:f 2:c 3:d 4:e
0->1  5->0*: 1:f 2:c 3:d 4:e
0->1* 5->1 : 1:a 2:c 3:d 4:e
0->1  5->1*: 1:f 2:c 3:d 4:e
0->1* 5->2 : 1:a 2:f 3:d 4:e
0->1  5->2*: 1:a 2:f 3:d 4:e
0->1* 5->3 : 1:a 2:c 3:f 4:e
0->1  5->3*: 1:a 2:c 3:f 4:e
0->1* 5->4 : 1:a 2:c 3:d 4:f
0->1  5->4*: 1:a 2:c 3:d 4:f
0->1* 5->5 : 1:a 2:c 3:d 4:e 5:f
0->1  5->5*: 1:a 2:c 3:d 4:e 5:f
0->2* 0->0 : 1:b 2:a 3:d 4:e 5:f
0->2  0->0*: 1:b 2:a 3:d 4:e 5:f
0->2* 0->1 : 2:a 3:d 4:e 5:f
0->2  0->1*: 1:a 3:d 4:e 5:f
0->2* 0->2 : 1:b 2:a 3:d 4:e 5:f
0->2  0->2*: 1:b 2:a 3:d 4:e 5:f
0->2* 0->3 : 1:b 2:a 4:e 5:f
0->2  0->3*: 1:b 3:a 4:e 5:f
0->2* 0->4 : 1:b 2:a 3:d 5:f
0->2  0->4*: 1:b 3:d 4:a 5:f
0->2* 0->5 : 1:b 2:a 3:d 4:e
0->2  0->5*: 1:b 3:d 4:e 5:a
0->2* 1->0 : 2:b 3:d 4:e 5:f
0->2  1->0*: 2:b 3:d 4:e 5:f
0->2* 1->1 : 1:b 2:a 3:d 4:e 5:f
0->2  1->1*: 1:b 2:a 3:d 4:e 5:f
0->2* 1->2 : 2:a 3:d 4:e 5:f
0->2  1->2*: 2:b 3:d 4:e 5:f
0->2* 1->3 : 2:a 3:b 4:e 5:f
0->2  1->3*: 2:a 3:b 4:e 5:f
0->2* 1->4 : 2:a 3:d 4:b 5:f
0->2  1->4*: 2:a 3:d 4:b 5:f
0->2* 1->5 : 2:a 3:d 4:e 5:b
0->2  1->5*: 2:a 3:d 4:e 5:b
0->2* 2->0 : 1:b 3:d 4:e 5:f
0->2  2->0*: 1:b 3:d 4:e 5:f
0->2* 2->1 : 1:a 3:d 4:e 5:f
0->2  2->1*: 1:a 3:d 4:e 5:f
0->2* 2->2 : 1:b 2:a 3:d 4:e 5:f
0->2  2->2*: 1:b 2:a 3:d 4:e 5:f
0->2* 2->3 : 1:b 3:a 4:e 5:f
0->2  2->3*: 1:b 3:a 4:e 5:f
0->2* 2->4 : 1:b 3:d 4:a 5:f
0->2  2->4*: 1:b 3:d 4:a 5:f
0->2* 2->5 : 1:b 3:d 4:e 5:a
0->2  2->5*: 1:b 3:d 4:e 5:a
0->2* 3->0 : 1:b 2:d 4:e 5:f
0->2  3->0*: 1:b 2:d 4:e 5:f
0->2* 3->1 : 1:d 2:a 4:e 5:f
0->2  3->1*: 1:d 2:a 4:e 5:f
0->2* 3->2 : 1:b 2:a 4:e 5:f
0->2  3->2*: 1:b 2:d 4:e 5:f
0->2* 3->3 : 1:b 2:a 3:d 4:e 5:f
0->2  3->3*: 1:b 2:a 3:d 4:e 5:f
0->2* 3->4 : 1:b 2:a 4:d 5:f
0->2  3->4*: 1:b 2:a 4:d 5:f
0->2* 3->5 : 1:b 2:a 4:e 5:d
0->2  3->5*: 1:b 2:a 4:e 5:d
0->2* 4->0 : 1:b 2:e 3:d 5:f
0->2  4->0*: 1:b 2:e 3:d 5:f
0->2* 4->1 : 1:e 2:a 3:d 5:f
0->2  4->1*: 1:e 2:a 3:d 5:f
0->2* 4->2 : 1:b 2:a 3:d 5:f
0->2  4->2*: 1:b 2:e 3:d 5:f
0->2* 4->3 : 1:b 2:a 3:e 5:f
0->2  4->3*: 1:b 2:a 3:e 5:f
0->2* 4->4 : 1:b 2:a 3:d 4:e 5:f
0->2  4->4*: 1:b 2:a 3:d 4:e 5:f
0->2* 4->5 : 1:b 2:a 3:d 5:e
0->2  4->5*: 1:b 2:a 3:d 5:e
0->2* 5->0 : 1:b 2:f 3:d 4:e
0->2  5->0*: 1:b 2:f 3:d 4:e
0->2* 5->1 : 1:f 2:a 3:d 4:e
0->2  5->1*: 1:f 2:a 3:d 4:e
0->2* 5->2 : 1:b 2:a 3:d 4:e
0->2  5->2*: 1:b 2:f 3:d 4:e
0->2* 5->3 : 1:b 2:a 3:f 4:e
0->2  5->3*: 1:b 2:a 3:f 4:e
0->2* 5->4 : 1:b 2:a 3:d 4:f
0->2  5->4*: 1:b 2:a 3:d 4:f
0->2* 5->5 : 1:b 2:a 3:d 4:e 5:f
0->2  5->5*: 1:b 2:a 3:d 4:e 5:f
0->3* 0->0 : 1:b 2:c 3:a 4:e 5:f
0->3  0->0*: 1:b 2:c 3:a 4:e 5:f
0->3* 0->1 : 2:c 3:a 4:e 5:f
0->3  0->1*: 1:a 2:c 4:e 5:f
0->3* 0->2 : 1:b 3:a 4:e 5:f
0->3  0->2*: 1:b 2:a 4:e 5:f
0->3* 0->3 : 1:b 2:c 3:a 4:e 5:f
0->3  0->3*: 1:b 2:c 3:a 4:e 5:f
0->3* 0->4 : 1:b 2:c 3:a 5:f
0->3  0->4*: 1:b 2:c 4:a 5:f
0->3* 0->5 : 1:b 2:c 3:a 4:e
0->3  0->5*: 1:b 2:c 4:e 5:a
0->3* 1->0 : 2:c 3:b 4:e 5:f
0->3  1->0*: 2:c 3:b 4:e 5:f
0->3* 1->1 : 1:b 2:c 3:a 4:e 5:f
0->3  1->1*: 1:b 2:c 3:a 4:e 5:f
0->3* 1->2 : 2:b 3:a 4:e 5:f
0->3  1->2*: 2:b 3:a 4:e 5:f
0->3* 1->3 : 2:c 3:a 4:e 5:f
0->3  1->3*: 2:c 3:b 4:e 5:f
0->3* 1->4 : 2:c 3:a 4:b 5:f
0->3  1->4*: 2:c 3:a 4:b 5:f
0->3* 1->5 : 2:c 3:a 4:e 5:b
0->3  1->5*: 2:c 3:a 4:e 5:b
0->3* 2->0 : 1:b 3:c 4:e 5:f
0->3  2->0*: 1:b 3:c 4:e 5:f
0->3* 2->1 : 1:c 3:a 4:e 5:f
0->3  2->1*: 1:c 3:a 4:e 5:f
0->3* 2->2 : 1:b 2:c 3:a 4:e 5:f
0->3  2->2*: 1:b 2:c 3:a 4:e 5:f
0->3* 2->3 : 1:b 3:a 4:e 5:f
0->3  2->3*: 1:b 3:c 4:e 5:f
0->3* 2->4 : 1:b 3:a 4:c 5:f
0->3  2->4*: 1:b 3:a 4:c 5:f
0->3* 2->5 : 1:b 3:a 4:e 5:c
0->3  2->5*: 1:b 3:a 4:e 5:c
0->3* 3->0 : 1:b 2:c 4:e 5:f
0->3  3->0*: 1:b 2:c 4:e 5:f
0->3* 3->1 : 1:a 2:c 4:e 5:f
0->3  3->1*: 1:a 2:c 4:e 5:f
0->3* 3->2 : 1:b 2:a 4:e 5:f
0->3  3->2*: 1:b 2:a 4:e 5:f
0->3* 3->3 : 1:b 2:c 3:a 4:e 5:f
0->3  3->3*: 1:b 2:c 3:a 4:e 5:f
0->3* 3->4 : 1:b 2:c 4:a 5:f
0->3  3->4*: 1:b 2:c 4:a 5:f
0->3* 3->5 : 1:b 2:c 4:e 5:a
0->3  3->5*: 1:b 2:c 4:e 5:a
0->3* 4->0 : 1:b 2:c 3:e 5:f
0->3  4->0*: 1:b 2:c 3:e 5:f
0->3* 4->1 : 1:e 2:c 3:a 5:f
0->3  4->1*: 1:e 2:c 3:a 5:f
0->3* 4->2 : 1:b 2:e 3:a 5:f
0->3  4->2*: 1:b 2:e 3:a 5:f
0->3* 4->3 : 1:b 2:c 3:a 5:f
0->3  4->3*: 1:b 2:c 3:e 5:f
0->3* 4->4 : 1:b 2:c 3:a 4:e 5:f
0->3  4->4*: 1:b 2:c 3:a 4:e 5:f
0->3* 4->5 : 1:b 2:c 3:a 5:e
0->3  4->5*: 1:b 2:c 3:a 5:e
0->3* 5->0 : 1:b 2:c 3:f 4:e
0->3  5->0*: 1:b 2:c 3:f 4:e
0->3* 5->1 : 1:f 2:c 3:a 4:e
0->3  5->1*: 1:f 2:c 3:a 4:e
0->3* 5->2 : 1:b 2:f 3:a 4:e
0->3  5->2*: 1:b 2:f 3:a 4:e
0->3* 5->3 : 1:b 2:c 3:a 4:e
0->3  5->3*: 1:b 2:c 3:f 4:e
0->3* 5->4 : 1:b 2:c 3:a 4:f
0->3  5->4*: 1:b 2:c 3:a 4:f
0->3* 5->5 : 1:b 2:c 3:a 4:e 5:f
0->3  5->5*: 1:b 2:c 3:a 4:e 5:f
0->4* 0->0 : 1:b 2:c 3:d 4:a 5:f
0->4  0->0*: 1:b 2:c 3:d 4:a 5:f
0->4* 0->1 : 2:c 3:d 4:a 5:f
0->4  0->1*: 1:a 2:c 3:d 5:f
0->4* 0->2 : 1:b 3:d 4:a 5:f
0->4  0->2*: 1:b 2:a 3:d 5:f
0->4* 0->3 : 1:b 2:c 4:a 5:f
0->4  0->3*: 1:b 2:c 3:a 5:f
0->4* 0->4 : 1:b 2:c 3:d 4:a 5:f
0->4  0->4*: 1:b 2:c 3:d 4:a 5:f
0->4* 0->5 : 1:b 2:c 3:d 4:a
0->4  0->5*: 1:b 2:c 3:d 5:a
0->4* 1->0 : 2:c 3:d 4:b 5:f
0->4  1->0*: 2:c 3:d 4:b 5:f
0->4* 1->1 : 1:b 2:c 3:d 4:a 5:f
0->4  1->1*: 1:b 2:c 3:d 4:a 5:f
0->4* 1->2 : 2:b 3:d 4:a 5:f
0->4  1->2*: 2:b 3:d 4:a 5:f
0->4* 1->3 : 2:c 3:b 4:a 5:f
0->4  1->3*: 2:c 3:b 4:a 5:f
0->4* 1->4 : 2:c 3:d 4:a 5:f
0->4  1->4*: 2:c 3:d 4:b 5:f
0->4* 1->5 : 2:c 3:d 4:a 5:b
0->4  1->5*: 2:c 3:d 4:a 5:b
0->4* 2->0 : 1:b 3:d 4:c 5:f
0->4  2->0*: 1:b 3:d 4:c 5:f
0->4* 2->1 : 1:c 3:d 4:a 5:f
0->4  2->1*: 1:c 3:d 4:a 5:f
0->4* 2->2 : 1:b 2:c 3:d 4:a 5:f
0->4  2->2*: 1:b 2:c 3:d 4:a 5:f
0->4* 2->3 : 1:b 3:c 4:a 5:f
0->4  2->3*: 1:b 3:c 4:a 5:f
0->4* 2->4 : 1:b 3:d 4:a 5:f
0->4  2->4*: 1:b 3:d 4:c 5:f
0->4* 2->5 : 1:b 3:d 4:a 5:c
0->4  2->5*: 1:b 3:d 4:a 5:c
0->4* 3->0 : 1:b 2:c 4:d 5:f
0->4  3->0*: 1:b 2:c 4:d 5:f
0->4* 3->1 : 1:d 2:c 4:a 5:f
0->4  3->1*: 1:d 2:c 4:a 5:f
0->4* 3->2 : 1:b 2:d 4:a 5:f
0->4  3->2*: 1:b 2:d 4:a 5:f
0->4* 3->3 : 1:b 2:c 3:d 4:a 5:f
0->4  3->3*: 1:b 2:c 3:d 4:a 5:f
0->4* 3->4 : 1:b 2:c 4:a 5:f
0->4  3->4*: 1:b 2:c 4:d 5:f
0->4* 3->5 : 1:b 2:c 4:a 5:d
0->4  3->5*: 1:b 2:c 4:a 5:d
0->4* 4->0 : 1:b 2:c 3:d 5:f
0->4  4->0*: 1:b 2:c 3:d 5:f
0->4* 4->1 : 1:a 2:c 3:d 5:f
0->4  4->1*: 1:a 2:c 3:d 5:f
0->4* 4->2 : 1:b 2:a 3:d 5:f
0->4  4->2*: 1:b 2:a 3:d 5:f
0->4* 4->3 : 1:b 2:c 3:a 5:f
0->4  4->3*: 1:b 2:c 3:a 5:f
0->4* 4->4 : 1:b 2:c 3:d 4:a 5:f
0->4  4->4*: 1:b 2:c 3:d 4:a 5:f
0->4* 4->5 : 1:b 2:c 3:d 5:a
0->4  4->5*: 1:b 2:c 3:d 5:a
0->4* 5->0 : 1:b 2:c 3:d 4:f
0->4  5->0*: 1:b 2:c 3:d 4:f
0->4* 5->1 : 1:f 2:c 3:d 4:a
0->4  5->1*: 1:f 2:c 3:d 4:a
0->4* 5->2 : 1:b 2:f 3:d 4:a
0->4  5->2*: 1:b 2:f 3:d 4:a
0->4* 5->3 : 1:b 2:c 3:f 4:a
0->4  5->3*: 1:b 2:c 3:f 4:a
0->4* 5->4 : 1:b 2:c 3:d 4:a
0->4  5->4*: 1:b 2:c 3:d 4:f
0->4* 5->5 : 1:b 2:c 3:d 4:a 5:f
0->4  5->5*: 1:b 2:c 3:d 4:a 5:f
0->5* 0->0 : 1:b 2:c 3:d 4:e 5:a
0->5  0->0*: 1:b 2:c 3:d 4:e 5:a
0->5* 0->1 : 2:c 3:d 4:e 5:a
0->5  0->1*: 1:a 2:c 3:d 4:e
0->5* 0->2 : 1:b 3:d 4:e 5:a
0->5  0->2*: 1:b 2:a 3:d 4:e
0->5* 0->3 : 1:b 2:c 4:e 5:a
0->5  0->3*: 1:b 2:c 3:a 4:e
0->5* 0->4 : 1:b 2:c 3:d 5:a
0->5  0->4*: 1:b 2:c 3:d 4:a
0->5* 0->5 : 1:b 2:c 3:d 4:e 5:a
0->5  0->5*: 1:b 2:c 3:d 4:e 5:a
0->5* 1->0 : 2:c 3:d 4:e 5:b
0->5  1->0*: 2:c 3:d 4:e 5:b
0->5* 1->1 : 1:b 2:c 3:d 4:e 5:a
0->5  1->1*: 1:b 2:c 3:d 4:e 5:a
0->5* 1->2 : 2:b 3:d 4:e 5:a
0->5  1->2*: 2:b 3:d 4:e 5:a
0->5* 1->3 : 2:c 3:b 4:e 5:a
0->5  1->3*: 2:c 3:b 4:e 5:a
0->5* 1->4 : 2:c 3:d 4:b 5:a
0->5  1->4*: 2:c 3:d 4:b 5:a
0->5* 1->5 : 2:c 3:d 4:e 5:a
0->5  1->5*: 2:c 3:d 4:e 5:b
0->5* 2->0 : 1:b 3:d 4:e 5:c
0->5  2->0*: 1:b 3:d 4:e 5:c
0->5* 2->1 : 1:c 3:d 4:e 5:a
0->5  2->1*: 1:c 3:d 4:e 5:a
0->5* 2->2 : 1:b 2:c 3:d 4:e 5:a
0->5  2->2*: 1:b 2:c 3:d 4:e 5:a
0->5* 2->3 : 1:b 3:c 4:e 5:a
0->5  2->3*: 1:b 3:c 4:e 5:a
0->5* 2->4 : 1:b 3:d 4:c 5:a
0->5  2->4*: 1:b 3:d 4:c 5:a
0->5* 2->5 : 1:b 3:d 4:e 5:a
0->5  2->5*: 1:b 3:d 4:e 5:c
0->5* 3->0 : 1:b 2:c 4:e 5:d
0->5  3->0*: 1:b 2:c 4:e 5:d
0->5* 3->1 : 1:d 2:c 4:e 5:a
0->5  3->1*: 1:d 2:c 4:e 5:a
0->5* 3->2 : 1:b 2:d 4:e 5:a
0->5  3->2*: 1:b 2:d 4:e 5:a
0->5* 3->3 : 1:b 2:c 3:d 4:e 5:a
0->5  3->3*: 1:b 2:c 3:d 4:e 5:a
0->5* 3->4 : 1:b 2:c 4:d 5:a
0->5  3->4*: 1:b 2:c 4:d 5:a
0->5* 3->5 : 1:b 2:c 4:e 5:a
0->5  3->5*: 1:b 2:c 4:e 5:d
0->5* 4->0 : 1:b 2:c 3:d 5:e
0->5  4->0*: 1:b 2:c 3:d 5:e
0->5* 4->1 : 1:e 2:c 3:d 5:a
0->5  4->1*: 1:e 2:c 3:d 5:a
0->5* 4->2 : 1:b 2:e 3:d 5:a
0->5  4->2*: 1:b 2:e 3:d 5:a
0->5* 4->3 : 1:b 2:c 3:e 5:a
0->5  4->3*: 1:b 2:c 3:e 5:a
0->5* 4->4 : 1:b 2:c 3:d 4:e 5:a
0->5  4->4*: 1:b 2:c 3:d 4:e 5:a
0->5* 4->5 : 1:b 2:c 3:d 5:a
0->5  4->5*: 1:b 2:c 3:d 5:e
0->5* 5->0 : 1:b 2:c 3:d 4:e
0->5  5->0*: 1:b 2:c 3:d 4:e
0->5* 5->1 : 1:a 2:c 3:d 4:e
0->5  5->1*: 1:a 2:c 3:d 4:e
0->5* 5->2 : 1:b 2:a 3:d 4:e
0->5  5->2*: 1:b 2:a 3:d 4:e
0->5* 5->3 : 1:b 2:c 3:a 4:e
0->5  5->3*: 1:b 2:c 3:a 4:e
0->5* 5->4 : 1:b 2:c 3:d 4:a
0->5  5->4*: 1:b 2:c 3:d 4:a
0->5* 5->5 : 1:b 2:c 3:d 4:e 5:a
0->5  5->5*: 1:b 2:c 3:d 4:e 5:a
1->0* 0->0 : 0:b 2:c 3:d 4:e 5:f
1->0  0->0*: 0:b 2:c 3:d 4:e 5:f
1->0* 0->1 : 2:c 3:d 4:e 5:f
1->0  0->1*: 2:c 3:d 4:e 5:f
1->0* 0->2 : 2:b 3:d 4:e 5:f
1->0  0->2*: 2:b 3:d 4:e 5:f
1->0* 0->3 : 2:c 3:b 4:e 5:f
1->0  0->3*: 2:c 3:b 4:e 5:f
1->0* 0->4 : 2:c 3:d 4:b 5:f
1->0  0->4*: 2:c 3:d 4:b 5:f
1->0* 0->5 : 2:c 3:d 4:e 5:b
1->0  0->5*: 2:c 3:d 4:e 5:b
1->0* 1->0 : 0:b 2:c 3:d 4:e 5:f
1->0  1->0*: 0:b 2:c 3:d 4:e 5:f
1->0* 1->1 : 0:b 2:c 3:d 4:e 5:f
1->0  1->1*: 0:b 2:c 3:d 4:e 5:f
1->0* 1->2 : 0:b 3:d 4:e 5:f
1->0  1->2*: 2:b 3:d 4:e 5:f
1->0* 1->3 : 0:b 2:c 4:e 5:f
1->0  1->3*: 2:c 3:b 4:e 5:f
1->0* 1->4 : 0:b 2:c 3:d 5:f
1->0  1->4*: 2:c 3:d 4:b 5:f
1->0* 1->5 : 0:b 2:c 3:d 4:e
1->0  1->5*: 2:c 3:d 4:e 5:b
1->0* 2->0 : 0:b 3:d 4:e 5:f
1->0  2->0*: 0:c 3:d 4:e 5:f
1->0* 2->1 : 0:c 3:d 4:e 5:f
1->0  2->1*: 0:c 3:d 4:e 5:f
1->0* 2->2 : 0:b 2:c 3:d 4:e 5:f
1->0  2->2*: 0:b 2:c 3:d 4:e 5:f
1->0* 2->3 : 0:b 3:c 4:e 5:f
1->0  2->3*: 0:b 3:c 4:e 5:f
1->0* 2->4 : 0:b 3:d 4:c 5:f
1->0  2->4*: 0:b 3:d 4:c 5:f
1->0* 2->5 : 0:b 3:d 4:e 5:c
1->0  2->5*: 0:b 3:d 4:e 5:c
1->0* 3->0 : 0:b 2:c 4:e 5:f
1->0  3->0*: 0:d 2:c 4:e 5:f
1->0* 3->1 : 0:d 2:c 4:e 5:f
1->0  3->1*: 0:d 2:c 4:e 5:f
1->0* 3->2 : 0:b 2:d 4:e 5:f
1->0  3->2*: 0:b 2:d 4:e 5:f
1->0* 3->3 : 0:b 2:c 3:d 4:e 5:f
1->0  3->3*: 0:b 2:c 3:d 4:e 5:f
1->0* 3->4 : 0:b 2:c 4:d 5:f
1->0  3->4*: 0:b 2:c 4:d 5:f
1->0* 3->5 : 0:b 2:c 4:e 5:d
1->0  3->5*: 0:b 2:c 4:e 5:d
1->0* 4->0 : 0:b 2:c 3:d 5:f
1->0  4->0*: 0:e 2:c 3:d 5:f
1->0* 4->1 : 0:e 2:c 3:d 5:f
1->0  4->1*: 0:e 2:c 3:d 5:f
1->0* 4->2 : 0:b 2:e 3:d 5:f
1->0  4->2*: 0:b 2:e 3:d 5:f
1->0* 4->3 : 0:b 2:c 3:e 5:f
1->0  4->3*: 0:b 2:c 3:e 5:f
1->0* 4->4 : 0:b 2:c 3:d 4:e 5:f
1->0  4->4*: 0:b 2:c 3:d 4:e 5:f
1->0* 4->5 : 0:b 2:c 3:d 5:e
1->0  4->5*: 0:b 2:c 3:d 5:e
1->0* 5->0 : 0:b 2:c 3:d 4:e
1->0  5->0*: 0:f 2:c 3:d 4:e
1->0* 5->1 : 0:f 2:c 3:d 4:e
1->0  5->1*: 0:f 2:c 3:d 4:e
1->0* 5->2 : 0:b 2:f 3:d 4:e
1->0  5->2*: 0:b 2:f 3:d 4:e
1->0* 5->3 : 0:b 2:c 3:f 4:e
1->0  5->3*: 0:b 2:c 3:f 4:e
1->0* 5->4 : 0:b 2:c 3:d 4:f
1->0  5->4*: 0:b 2:c 3:d 4:f
1->0* 5->5 : 0:b 2:c 3:d 4:e 5:f
1->0  5->5*: 0:b 2:c 3:d 4:e 5:f
1->1* 0->0 : 0:a 1:b 2:c 3:d 4:e 5:f
1->1  0->0*: 0:a 1:b 2:c 3:d 4:e 5:f
1->1* 0->1 : 1:a 2:c 3:d 4:e 5:f
1->1  0->1*: 1:a 2:c 3:d 4:e 5:f
1->1* 0->2 : 1:b 2:a 3:d 4:e 5:f
1->1  0->2*: 1:b 2:a 3:d 4:e 5:f
1->1* 0->3 : 1:b 2:c 3:a 4:e 5:f
1->1  0->3*: 1:b 2:c 3:a 4:e 5:f
1->1* 0->4 : 1:b 2:c 3:d 4:a 5:f
1->1  0->4*: 1:b 2:c 3:d 4:a 5:f
1->1* 0->5 : 1:b 2:c 3:d 4:e 5:a
1->1  0->5*: 1:b 2:c 3:d 4:e 5:a
1->1* 1->0 : 0:b 2:c 3:d 4:e 5:f
1->1  1->0*: 0:b 2:c 3:d 4:e 5:f
1->1* 1->1 : 0:a 1:b 2:c 3:d 4:e 5:f
1->1  1->1*: 0:a 1:b 2:c 3:d 4:e 5:f
1->1* 1->2 : 0:a 2:b 3:d 4:e 5:f
1->1  1->2*: 0:a 2:b 3:d 4:e 5:f
1->1* 1->3 : 0:a 2:c 3:b 4:e 5:f
1->1  1->3*: 0:a 2:c 3:b 4:e 5:f
1->1* 1->4 : 0:a 2:c 3:d 4:b 5:f
1->1  1->4*: 0:a 2:c 3:d 4:b 5:f
1->1* 1->5 : 0:a 2:c 3:d 4:e 5:b
1->1  1->5*: 0:a 2:c 3:d 4:e 5:b
1->1* 2->0 : 0:c 1:b 3:d 4:e 5:f
1->1  2->0*: 0:c 1:b 3:d 4:e 5:f
1->1* 2->1 : 0:a 1:c 3:d 4:e 5:f
1->1  2->1*: 0:a 1:c 3:d 4:e 5:f
1->1* 2->2 : 0:a 1:b 2:c 3:d 4:e 5:f
1->1  2->2*: 0:a 1:b 2:c 3:d 4:e 5:f
1->1* 2->3 : 0:a 1:b 3:c 4:e 5:f
1->1  2->3*: 0:a 1:b 3:c 4:e 5:f
1->1* 2->4 : 0:a 1:b 3:d 4:c 5:f
1->1  2->4*: 0:a 1:b 3:d 4:c 5:f
1->1* 2->5 : 0:a 1:b 3:d 4:e 5:c
1->1  2->5*: 0:a 1:b 3:d 4:e 5:c
1->1* 3->0 : 0:d 1:b 2:c 4:e 5:f
1->1  3->0*: 0:d 1:b 2:c 4:e 5:f
1->1* 3->1 : 0:a 1:d 2:c 4:e 5:f
1->1  3->1*: 0:a 1:d 2:c 4:e 5:f
1->1* 3->2 : 0:a 1:b 2:d 4:e 5:f
1->1  3->2*: 0:a 1:b 2:d 4:e 5:f
1->1* 3->3 : 0:a 1:b 2:c 3:d 4:e 5:f
1->1  3->3*: 0:a 1:b 2:c 3:d 4:e 5:f
1->1* 3->4 : 0:a 1:b 2:c 4:d 5:f
1->1  3->4*: 0:a 1:b 2:c 4:d 5:f
1->1* 3->5 : 0:a 1:b 2:c 4:e 5:d
1->1  3->5*: 0:a 1:b 2:c 4:e 5:d
1->1* 4->0 : 0:e 1:b 2:c 3:d 5:f
1->1  4->0*: 0:e 1:b 2:c 3:d 5:f
1->1* 4->1 : 0:a 1:e 2:c 3:d 5:f
1->1  4->1*: 0:a 1:e 2:c 3:d 5:f
1->1* 4->2 : 0:a 1:b 2:e 3:d 5:f
1->1  4->2*: 0:a 1:b 2:e 3:d 5:f
1->1* 4->3 : 0:a 1:b 2:c 3:e 5:f
1->1  4->3*: 0:a 1:b 2:c 3:e 5:f
1->1* 4->4 : 0:a 1:b 2:c 3:d 4:e 5:f
1->1  4->4*: 0:a 1:b 2:c 3:d 4:e 5:f
1->1* 4->5 : 0:a 1:b 2:c 3:d 5:e
1->1  4->5*: 0:a 1:b 2:c 3:d 5:e
1->1* 5->0 : 0:f 1:b 2:c 3:d 4:e
1->1  5->0*: 0:f 1:b 2:c 3:d 4:e
1->1* 5->1 : 0:a 1:f 2:c 3:d 4:e
1->1  5->1*: 0:a 1:f 2:c 3:d 4:e
1->1* 5->2 : 0:a 1:b 2:f 3:d 4:e
1->1  5->2*: 0:a 1:b 2:f 3:d 4:e
1->1* 5->3 : 0:a 1:b 2:c 3:f 4:e
1->1  5->3*: 0:a 1:b 2:c 3:f 4:e
1->1* 5->4 : 0:a 1:b 2:c 3:d 4:f
1->1  5->4*: 0:a 1:b 2:c 3:d 4:f
1->1* 5->5 : 0:a 1:b 2:c 3:d 4:e 5:f
1->1  5->5*: 0:a 1:b 2:c 3:d 4:e 5:f
1->2* 0->0 : 0:a 2:b 3:d 4:e 5:f
1->2  0->0*: 0:a 2:b 3:d 4:e 5:f
1->2* 0->1 : 2:a 3:d 4:e 5:f
1->2  0->1*: 2:a 3:d 4:e 5:f
1->2* 0->2 : 2:b 3:d 4:e 5:f
1->2  0->2*: 2:a 3:d 4:e 5:f
1->2* 0->3 : 2:b 3:a 4:e 5:f
1->2  0->3*: 2:b 3:a 4:e 5:f
1->2* 0->4 : 2:b 3:d 4:a 5:f
1->2  0->4*: 2:b 3:d 4:a 5:f
1->2* 0->5 : 2:b 3:d 4:e 5:a
1->2  0->5*: 2:b 3:d 4:e 5:a
1->2* 1->0 : 2:b 3:d 4:e 5:f
1->2  1->0*: 0:b 3:d 4:e 5:f
1->2* 1->1 : 0:a 2:b 3:d 4:e 5:f
1->2  1->1*: 0:a 2:b 3:d 4:e 5:f
1->2* 1->2 : 0:a 2:b 3:d 4:e 5:f
1->2  1->2*: 0:a 2:b 3:d 4:e 5:f
1->2* 1->3 : 0:a 2:b 4:e 5:f
1->2  1->3*: 0:a 3:b 4:e 5:f
1->2* 1->4 : 0:a 2:b 3:d 5:f
1->2  1->4*: 0:a 3:d 4:b 5:f
1->2* 1->5 : 0:a 2:b 3:d 4:e
1->2  1->5*: 0:a 3:d 4:e 5:b
1->2* 2->0 : 0:b 3:d 4:e 5:f
1->2  2->0*: 0:b 3:d 4:e 5:f
1->2* 2->1 : 0:a 3:d 4:e 5:f
1->2  2->1*: 0:a 3:d 4:e 5:f
1->2* 2->2 : 0:a 2:b 3:d 4:e 5:f
1->2  2->2*: 0:a 2:b 3:d 4:e 5:f
1->2* 2->3 : 0:a 3:b 4:e 5:f
1->2  2->3*: 0:a 3:b 4:e 5:f
1->2* 2->4 : 0:a 3:d 4:b 5:f
1->2  2->4*: 0:a 3:d 4:b 5:f
1->2* 2->5 : 0:a 3:d 4:e 5:b
1->2  2->5*: 0:a 3:d 4:e 5:b
1->2* 3->0 : 0:d 2:b 4:e 5:f
1->2  3->0*: 0:d 2:b 4:e 5:f
1->2* 3->1 : 0:a 2:d 4:e 5:f
1->2  3->1*: 0:a 2:d 4:e 5:f
1->2* 3->2 : 0:a 2:b 4:e 5:f
1->2  3->2*: 0:a 2:d 4:e 5:f
1->2* 3->3 : 0:a 2:b 3:d 4:e 5:f
1->2  3->3*: 0:a 2:b 3:d 4:e 5:f
1->2* 3->4 : 0:a 2:b 4:d 5:f
1->2  3->4*: 0:a 2:b 4:d 5:f
1->2* 3->5 : 0:a 2:b 4:e 5:d
1->2  3->5*: 0:a 2:b 4:e 5:d
1->2* 4->0 : 0:e 2:b 3:d 5:f
1->2  4->0*: 0:e 2:b 3:d 5:f
1->2* 4->1 : 0:a 2:e 3:d 5:f
1->2  4->1*: 0:a 2:e 3:d 5:f
1->2* 4->2 : 0:a 2:b 3:d 5:f
1->2  4->2*: 0:a 2:e 3:d 5:f
1->2* 4->3 : 0:a 2:b 3:e 5:f
1->2  4->3*: 0:a 2:b 3:e 5:f
1->2* 4->4 : 0:a 2:b 3:d 4:e 5:f
1->2  4->4*: 0:a 2:b 3:d 4:e 5:f
1->2* 4->5 : 0:a 2:b 3:d 5:e
1->2  4->5*: 0:a 2:b 3:d 5:e
1->2* 5->0 : 0:f 2:b 3:d 4:e
1->2  5->0*: 0:f 2:b 3:d 4:e
1->2* 5->1 : 0:a 2:f 3:d 4:e
1->2  5->1*: 0:a 2:f 3:d 4:e
1->2* 5->2 : 0:a 2:b 3:d 4:e
1->2  5->2*: 0:a 2:f 3:d 4:e
1->2* 5->3 : 0:a 2:b 3:f 4:e
1->2  5->3*: 0:a 2:b 3:f 4:e
1->2* 5->4 : 0:a 2:b 3:d 4:f
1->2  5->4*: 0:a 2:b 3:d 4:f
1->2* 5->5 : 0:a 2:b 3:d 4:e 5:f
1->2  5->5*: 0:a 2:b 3:d 4:e 5:f
1->3* 0->0 : 0:a 2:c 3:b 4:e 5:f
1->3  0->0*: 0:a 2:c 3:b 4:e 5:f
1->3* 0->1 : 2:c 3:a 4:e 5:f
1->3  0->1*: 2:c 3:a 4:e 5:f
1->3* 0->2 : 2:a 3:b 4:e 5:f
1->3  0->2*: 2:a 3:b 4:e 5:f
1->3* 0->3 : 2:c 3:b 4:e 5:f
1->3  0->3*: 2:c 3:a 4:e 5:f
1->3* 0->4 : 2:c 3:b 4:a 5:f
1->3  0->4*: 2:c 3:b 4:a 5:f
1->3* 0->5 : 2:c 3:b 4:e 5:a
1->3  0->5*: 2:c 3:b 4:e 5:a
1->3* 1->0 : 2:c 3:b 4:e 5:f
1->3  1->0*: 0:b 2:c 4:e 5:f
1->3* 1->1 : 0:a 2:c 3:b 4:e 5:f
1->3  1->1*: 0:a 2:c 3:b 4:e 5:f
1->3* 1->2 : 0:a 3:b 4:e 5:f
1->3  1->2*: 0:a 2:b 4:e 5:f
1->3* 1->3 : 0:a 2:c 3:b 4:e 5:f
1->3  1->3*: 0:a 2:c 3:b 4:e 5:f
1->3* 1->4 : 0:a 2:c 3:b 5:f
1->3  1->4*: 0:a 2:c 4:b 5:f
1->3* 1->5 : 0:a 2:c 3:b 4:e
1->3  1->5*: 0:a 2:c 4:e 5:b
1->3* 2->0 : 0:c 3:b 4:e 5:f
1->3  2->0*: 0:c 3:b 4:e 5:f
1->3* 2->1 : 0:a 3:c 4:e 5:f
1->3  2->1*: 0:a 3:c 4:e 5:f
1->3* 2->2 : 0:a 2:c 3:b 4:e 5:f
1->3  2->2*: 0:a 2:c 3:b 4:e 5:f
1->3* 2->3 : 0:a 3:b 4:e 5:f
1->3  2->3*: 0:a 3:c 4:e 5:f
1->3* 2->4 : 0:a 3:b 4:c 5:f
1->3  2->4*: 0:a 3:b 4:c 5:f
1->3* 2->5 : 0:a 3:b 4:e 5:c
1->3  2->5*: 0:a 3:b 4:e 5:c
1->3* 3->0 : 0:b 2:c 4:e 5:f
1->3  3->0*: 0:b 2:c 4:e 5:f
1->3* 3->1 : 0:a 2:c 4:e 5:f
1->3  3->1*: 0:a 2:c 4:e 5:f
1->3* 3->2 : 0:a 2:b 4:e 5:f
1->3  3->2*: 0:a 2:b 4:e 5:f
1->3* 3->3 : 0:a 2:c 3:b 4:e 5:f
1->3  3->3*: 0:a 2:c 3:b 4:e 5:f
1->3* 3->4 : 0:a 2:c 4:b 5:f
1->3  3->4*: 0:a 2:c 4:b 5:f
1->3* 3->5 : 0:a 2:c 4:e 5:b
1->3  3->5*: 0:a 2:c 4:e 5:b
1->3* 4->0 : 0:e 2:c 3:b 5:f
1->3  4->0*: 0:e 2:c 3:b 5:f
1->3* 4->1 : 0:a 2:c 3:e 5:f
1->3  4->1*: 0:a 2:c 3:e 5:f
1->3* 4->2 : 0:a 2:e 3:b 5:f
1->3  4->2*: 0:a 2:e 3:b 5:f
1->3* 4->3 : 0:a 2:c 3:b 5:f
1->3  4->3*: 0:a 2:c 3:e 5:f
1->3* 4->4 : 0:a 2:c 3:b 4:e 5:f
1->3  4->4*: 0:a 2:c 3:b 4:e 5:f
1->3* 4->5 : 0:a 2:c 3:b 5:e
1->3  4->5*: 0:a 2:c 3:b 5:e
1->3* 5->0 : 0:f 2:c 3:b 4:e
1->3  5->0*: 0:f 2:c 3:b 4:e
1->3* 5->1 : 0:a 2:c 3:f 4:e
1->3  5->1*: 0:a 2:c 3:f 4:e
1->3* 5->2 : 0:a 2:f 3:b 4:e
1->3  5->2*: 0:a 2:f 3:b 4:e
1->3* 5->3 : 0:a 2:c 3:b 4:e
1->3  5->3*: 0:a 2:c 3:f 4:e
1->3* 5->4 : 0:a 2:c 3:b 4:f
1->3  5->4*: 0:a 2:c 3:b 4:f
1->3* 5->5 : 0:a 2:c 3:b 4:e 5:f
1->3  5->5*: 0:a 2:c 3:b 4:e 5:f
1->4* 0->0 : 0:a 2:c 3:d 4:b 5:f
1->4  0->0*: 0:a 2:c 3:d 4:b 5:f
1->4* 0->1 : 2:c 3:d 4:a 5:f
1->4  0->1*: 2:c 3:d 4:a 5:f
1->4* 0->2 : 2:a 3:d 4:b 5:f
1->4  0->2*: 2:a 3:d 4:b 5:f
1->4* 0->3 : 2:c 3:a 4:b 5:f
1->4  0->3*: 2:c 3:a 4:b 5:f
1->4* 0->4 : 2:c 3:d 4:b 5:f
1->4  0->4*: 2:c 3:d 4:a 5:f
1->4* 0->5 : 2:c 3:d 4:b 5:a
1->4  0->5*: 2:c 3:d 4:b 5:a
1->4* 1->0 : 2:c 3:d 4:b 5:f
1->4  1->0*: 0:b 2:c 3:d 5:f
1->4* 1->1 : 0:a 2:c 3:d 4:b 5:f
1->4  1->1*: 0:a 2:c 3:d 4:b 5:f
1->4* 1->2 : 0:a 3:d 4:b 5:f
1->4  1->2*: 0:a 2:b 3:d 5:f
1->4* 1->3 : 0:a 2:c 4:b 5:f
1->4  1->3*: 0:a 2:c 3:b 5:f
1->4* 1->4 : 0:a 2:c 3:d 4:b 5:f
1->4  1->4*: 0:a 2:c 3:d 4:b 5:f
1->4* 1->5 : 0:a 2:c 3:d 4:b
1->4  1->5*: 0:a 2:c 3:d 5:b
1->4* 2->0 : 0:c 3:d 4:b 5:f
1->4  2->0*: 0:c 3:d 4:b 5:f
1->4* 2->1 : 0:a 3:d 4:c 5:f
1->4  2->1*: 0:a 3:d 4:c 5:f
1->4* 2->2 : 0:a 2:c 3:d 4:b 5:f
1->4  2->2*: 0:a 2:c 3:d 4:b 5:f
1->4* 2->3 : 0:a 3:c 4:b 5:f
1->4  2->3*: 0:a 3:c 4:b 5:f
1->4* 2->4 : 0:a 3:d 4:b 5:f
1->4  2->4*: 0:a 3:d 4:c 5:f
1->4* 2->5 : 0:a 3:d 4:b 5:c
1->4  2->5*: 0:a 3:d 4:b 5:c
1->4* 3->0 : 0:d 2:c 4:b 5:f
1->4  3->0*: 0:d 2:c 4:b 5:f
1->4* 3->1 : 0:a 2:c 4:d 5:f
1->4  3->1*: 0:a 2:c 4:d 5:f
1->4* 3->2 : 0:a 2:d 4:b 5:f
1->4  3->2*: 0:a 2:d 4:b 5:f
1->4* 3->3 : 0:a 2:c 3:d 4:b 5:f
1->4  3->3*: 0:a 2:c 3:d 4:b 5:f
1->4* 3->4 : 0:a 2:c 4:b 5:f
1->4  3->4*: 0:a 2:c 4:d 5:f
1->4* 3->5 : 0:a 2:c 4:b 5:d
1->4  3->5*: 0:a 2:c 4:b 5:d
1->4* 4->0 : 0:b 2:c 3:d 5:f
1->4  4->0*: 0:b 2:c 3:d 5:f
1->4* 4->1 : 0:a 2:c 3:d 5:f
1->4  4->1*: 0:a 2:c 3:d 5:f
1->4* 4->2 : 0:a 2:b 3:d 5:f
1->4  4->2*: 0:a 2:b 3:d 5:f
1->4* 4->3 : 0:a 2:c 3:b 5:f
1->4  4->3*: 0:a 2:c 3:b 5:f
1->4* 4->4 : 0:a 2:c 3:d 4:b 5:f
1->4  4->4*: 0:a 2:c 3:d 4:b 5:f
1->4* 4->5 : 0:a 2:c 3:d 5:b
1->4  4->5*: 0:a 2:c 3:d 5:b
1->4* 5->0 : 0:f 2:c 3:d 4:b
1->4  5->0*: 0:f 2:c 3:d 4:b
1->4* 5->1 : 0:a 2:c 3:d 4:f
1->4  5->1*: 0:a 2:c 3:d 4:f
1->4* 5->2 : 0:a 2:f 3:d 4:b
1->4  5->2*: 0:a 2:f 3:d 4:b
1->4* 5->3 : 0:a 2:c 3:f 4:b
1->4  5->3*: 0:a 2:c 3:f 4:b
1->4* 5->4 : 0:a 2:c 3:d 4:b
1->4  5->4*: 0:a 2:c 3:d 4:f
1->4* 5->5 : 0:a 2:c 3:d 4:b 5:f
1->4  5->5*: 0:a 2:c 3:d 4:b 5:f
1->5* 0->0 : 0:a 2:c 3:d 4:e 5:b
1->5  0->0*: 0:a 2:c 3:d 4:e 5:b
1->5* 0->1 : 2:c 3:d 4:e 5:a
1->5  0->1*: 2:c 3:d 4:e 5:a
1->5* 0->2 : 2:a 3:d 4:e 5:b
1->5  0->2*: 2:a 3:d 4:e 5:b
1->5* 0->3 : 2:c 3:a 4:e 5:b
1->5  0->3*: 2:c 3:a 4:e 5:b
1->5* 0->4 : 2:c 3:d 4:a 5:b
1->5  0->4*: 2:c 3:d 4:a 5:b
1->5* 0->5 : 2:c 3:d 4:e 5:b
1->5  0->5*: 2:c 3:d 4:e 5:a
1->5* 1->0 : 2:c 3:d 4:e 5:b
1->5  1->0*: 0:b 2:c 3:d 4:e
1->5* 1->1 : 0:a 2:c 3:d 4:e 5:b
1->5  1->1*: 0:a 2:c 3:d 4:e 5:b
1->5* 1->2 : 0:a 3:d 4:e 5:b
1->5  1->2*: 0:a 2:b 3:d 4:e
1->5* 1->3 : 0:a 2:c 4:e 5:b
1->5  1->3*: 0:a 2:c 3:b 4:e
1->5* 1->4 : 0:a 2:c 3:d 5:b
1->5  1->4*: 0:a 2:c 3:d 4:b
1->5* 1->5 : 0:a 2:c 3:d 4:e 5:b
1->5  1->5*: 0:a 2:c 3:d 4:e 5:b
1->5* 2->0 : 0:c 3:d 4:e 5:b
1->5  2->0*: 0:c 3:d 4:e 5:b
1->5* 2->1 : 0:a 3:d 4:e 5:c
1->5  2->1*: 0:a 3:d 4:e 5:c
1->5* 2->2 : 0:a 2:c 3:d 4:e 5:b
1->5  2->2*: 0:a 2:c 3:d 4:e 5:b
1->5* 2->3 : 0:a 3:c 4:e 5:b
1->5  2->3*: 0:a 3:c 4:e 5:b
1->5* 2->4 : 0:a 3:d 4:c 5:b
1->5  2->4*: 0:a 3:d 4:c 5:b
1->5* 2->5 : 0:a 3:d 4:e 5:b
1->5  2->5*: 0:a 3:d 4:e 5:c
1->5* 3->0 : 0:d 2:c 4:e 5:b
1->5  3->0*: 0:d 2:c 4:e 5:b
1->5* 3->1 : 0:a 2:c 4:e 5:d
1->5  3->1*: 0:a 2:c 4:e 5:d
1->5* 3->2 : 0:a 2:d 4:e 5:b
1->5  3->2*: 0:a 2:d 4:e 5:b
1->5* 3->3 : 0:a 2:c 3:d 4:e 5:b
1->5  3->3*: 0:a 2:c 3:d 4:e 5:b
1->5* 3->4 : 0:a 2:c 4:d 5:b
1->5  3->4*: 0:a 2:c 4:d 5:b
1->5* 3->5 : 0:a 2:c 4:e 5:b
1->5  3->5*: 0:a 2:c 4:e 5:d
1->5* 4->0 : 0:e 2:c 3:d 5:b
1->5  4->0*: 0:e 2:c 3:d 5:b
1->5* 4->1 : 0:a 2:c 3:d 5:e
1->5  4->1*: 0:a 2:c 3:d 5:e
1->5* 4->2 : 0:a 2:e 3:d 5:b
1->5  4->2*: 0:a 2:e 3:d 5:b
1->5* 4->3 : 0:a 2:c 3:e 5:b
1->5  4->3*: 0:a 2:c 3:e 5:b
1->5* 4->4 : 0:a 2:c 3:d 4:e 5:b
1->5  4->4*: 0:a 2:c 3:d 4:e 5:b
1->5* 4->5 : 0:a 2:c 3:d 5:b
1->5  4->5*: 0:a 2:c 3:d 5:e
1->5* 5->0 : 0:b 2:c 3:d 4:e
1->5  5->0*: 0:b 2:c 3:d 4:e
1->5* 5->1 : 0:a 2:c 3:d 4:e
1->5  5->1*: 0:a 2:c 3:d 4:e
1->5* 5->2 : 0:a 2:b 3:d 4:e
1->5  5->2*: 0:a 2:b 3:d 4:e
1->5* 5->3 : 0:a 2:c 3:b 4:e
1->5  5->3*: 0:a 2:c 3:b 4:e
1->5* 5->4 : 0:a 2:c 3:d 4:b
1->5  5->4*: 0:a 2:c 3:d 4:b
1->5* 5->5 : 0:a 2:c 3:d 4:e 5:b
1->5  5->5*: 0:a 2:c 3:d 4:e 5:b
2->0* 0->0 : 0:c 1:b 3:d 4:e 5:f
2->0  0->0*: 0:c 1:b 3:d 4:e 5:f
2->0* 0->1 : 1:c 3:d 4:e 5:f
2->0  0->1*: 1:c 3:d 4:e 5:f
2->0* 0->2 : 1:b 3:d 4:e 5:f
2->0  0->2*: 1:b 3:d 4:e 5:f
2->0* 0->3 : 1:b 3:c 4:e 5:f
2->0  0->3*: 1:b 3:c 4:e 5:f
2->0* 0->4 : 1:b 3:d 4:c 5:f
2->0  0->4*: 1:b 3:d 4:c 5:f
2->0* 0->5 : 1:b 3:d 4:e 5:c
2->0  0->5*: 1:b 3:d 4:e 5:c
2->0* 1->0 : 0:c 3:d 4:e 5:f
2->0  1->0*: 0:b 3:d 4:e 5:f
2->0* 1->1 : 0:c 1:b 3:d 4:e 5:f
2->0  1->1*: 0:c 1:b 3:d 4:e 5:f
2->0* 1->2 : 0:b 3:d 4:e 5:f
2->0  1->2*: 0:b 3:d 4:e 5:f
2->0* 1->3 : 0:c 3:b 4:e 5:f
2->0  1->3*: 0:c 3:b 4:e 5:f
2->0* 1->4 : 0:c 3:d 4:b 5:f
2->0  1->4*: 0:c 3:d 4:b 5:f
2->0* 1->5 : 0:c 3:d 4:e 5:b
2->0  1->5*: 0:c 3:d 4:e 5:b
2->0* 2->0 : 0:c 1:b 3:d 4:e 5:f
2->0  2->0*: 0:c 1:b 3:d 4:e 5:f
2->0* 2->1 : 0:c 3:d 4:e 5:f
2->0  2->1*: 1:c 3:d 4:e 5:f
2->0* 2->2 : 0:c 1:b 3:d 4:e 5:f
2->0  2->2*: 0:c 1:b 3:d 4:e 5:f
2->0* 2->3 : 0:c 1:b 4:e 5:f
2->0  2->3*: 1:b 3:c 4:e 5:f
2->0* 2->4 : 0:c 1:b 3:d 5:f
2->0  2->4*: 1:b 3:d 4:c 5:f
2->0* 2->5 : 0:c 1:b 3:d 4:e
2->0  2->5*: 1:b 3:d 4:e 5:c
2->0* 3->0 : 0:c 1:b 4:e 5:f
2->0  3->0*: 0:d 1:b 4:e 5:f
2->0* 3->1 : 0:c 1:d 4:e 5:f
2->0  3->1*: 0:c 1:d 4:e 5:f
2->0* 3->2 : 0:d 1:b 4:e 5:f
2->0  3->2*: 0:d 1:b 4:e 5:f
2->0* 3->3 : 0:c 1:b 3:d 4:e 5:f
2->0  3->3*: 0:c 1:b 3:d 4:e 5:f
2->0* 3->4 : 0:c 1:b 4:d 5:f
2->0  3->4*: 0:c 1:b 4:d 5:f
2->0* 3->5 : 0:c 1:b 4:e 5:d
2->0  3->5*: 0:c 1:b 4:e 5:d
2->0* 4->0 : 0:c 1:b 3:d 5:f
2->0  4->0*: 0:e 1:b 3:d 5:f
2->0* 4->1 : 0:c 1:e 3:d 5:f
2->0  4->1*: 0:c 1:e 3:d 5:f
2->0* 4->2 : 0:e 1:b 3:d 5:f
2->0  4->2*: 0:e 1:b 3:d 5:f
2->0* 4->3 : 0:c 1:b 3:e 5:f
2->0  4->3*: 0:c 1:b 3:e 5:f
2->0* 4->4 : 0:c 1:b 3:d 4:e 5:f
2->0  4->4*: 0:c 1:b 3:d 4:e 5:f
2->0* 4->5 : 0:c 1:b 3:d 5:e
2->0  4->5*: 0:c 1:b 3:d 5:e
2->0* 5->0 : 0:c 1:b 3:d 4:e
2->0  5->0*: 0:f 1:b 3:d 4:e
2->0* 5->1 : 0:c 1:f 3:d 4:e
2->0  5->1*: 0:c 1:f 3:d 4:e
2->0* 5->2 : 0:f 1:b 3:d 4:e
2->0  5->2*: 0:f 1:b 3:d 4:e
2->0* 5->3 : 0:c 1:b 3:f 4:e
2->0  5->3*: 0:c 1:b 3:f 4:e
2->0* 5->4 : 0:c 1:b 3:d 4:f
2->0  5->4*: 0:c 1:b 3:d 4:f
2->0* 5->5 : 0:c 1:b 3:d 4:e 5:f
2->0  5->5*: 0:c 1:b 3:d 4:e 5:f
2->1* 0->0 : 0:a 1:c 3:d 4:e 5:f
2->1  0->0*: 0:a 1:c 3:d 4:e 5:f
2->1* 0->1 : 1:c 3:d 4:e 5:f
2->1  0->1*: 1:a 3:d 4:e 5:f
2->1* 0->2 : 1:a 3:d 4:e 5:f
2->1  0->2*: 1:a 3:d 4:e 5:f
2->1* 0->3 : 1:c 3:a 4:e 5:f
2->1  0->3*: 1:c 3:a 4:e 5:f
2->1* 0->4 : 1:c 3:d 4:a 5:f
2->1  0->4*: 1:c 3:d 4:a 5:f
2->1* 0->5 : 1:c 3:d 4:e 5:a
2->1  0->5*: 1:c 3:d 4:e 5:a
2->1* 1->0 : 0:c 3:d 4:e 5:f
2->1  1->0*: 0:c 3:d 4:e 5:f
2->1* 1->1 : 0:a 1:c 3:d 4:e 5:f
2->1  1->1*: 0:a 1:c 3:d 4:e 5:f
2->1* 1->2 : 0:a 3:d 4:e 5:f
2->1  1->2*: 0:a 3:d 4:e 5:f
2->1* 1->3 : 0:a 3:c 4:e 5:f
2->1  1->3*: 0:a 3:c 4:e 5:f
2->1* 1->4 : 0:a 3:d 4:c 5:f
2->1  1->4*: 0:a 3:d 4:c 5:f
2->1* 1->5 : 0:a 3:d 4:e 5:c
2->1  1->5*: 0:a 3:d 4:e 5:c
2->1* 2->0 : 1:c 3:d 4:e 5:f
2->1  2->0*: 0:c 3:d 4:e 5:f
2->1* 2->1 : 0:a 1:c 3:d 4:e 5:f
2->1  2->1*: 0:a 1:c 3:d 4:e 5:f
2->1* 2->2 : 0:a 1:c 3:d 4:e 5:f
2->1  2->2*: 0:a 1:c 3:d 4:e 5:f
2->1* 2->3 : 0:a 1:c 4:e 5:f
2->1  2->3*: 0:a 3:c 4:e 5:f
2->1* 2->4 : 0:a 1:c 3:d 5:f
2->1  2->4*: 0:a 3:d 4:c 5:f
2->1* 2->5 : 0:a 1:c 3:d 4:e
2->1  2->5*: 0:a 3:d 4:e 5:c
2->1* 3->0 : 0:d 1:c 4:e 5:f
2->1  3->0*: 0:d 1:c 4:e 5:f
2->1* 3->1 : 0:a 1:c 4:e 5:f
2->1  3->1*: 0:a 1:d 4:e 5:f
2->1* 3->2 : 0:a 1:d 4:e 5:f
2->1  3->2*: 0:a 1:d 4:e 5:f
2->1* 3->3 : 0:a 1:c 3:d 4:e 5:f
2->1  3->3*: 0:a 1:c 3:d 4:e 5:f
2->1* 3->4 : 0:a 1:c 4:d 5:f
2->1  3->4*: 0:a 1:c 4:d 5:f
2->1* 3->5 : 0:a 1:c 4:e 5:d
2->1  3->5*: 0:a 1:c 4:e 5:d
2->1* 4->0 : 0:e 1:c 3:d 5:f
2->1  4->0*: 0:e 1:c 3:d 5:f
2->1* 4->1 : 0:a 1:c 3:d 5:f
2->1  4->1*: 0:a 1:e 3:d 5:f
2->1* 4->2 : 0:a 1:e 3:d 5:f
2->1  4->2*: 0:a 1:e 3:d 5:f
2->1* 4->3 : 0:a 1:c 3:e 5:f
2->1  4->3*: 0:a 1:c 3:e 5:f
2->1* 4->4 : 0:a 1:c 3:d 4:e 5:f
2->1  4->4*: 0:a 1:c 3:d 4:e 5:f
2->1* 4->5 : 0:a 1:c 3:d 5:e
2->1  4->5*: 0:a 1:c 3:d 5:e
2->1* 5->0 : 0:f 1:c 3:d 4:e
2->1  5->0*: 0:f 1:c 3:d 4:e
2->1* 5->1 : 0:a 1:c 3:d 4:e
2->1  5->1*: 0:a 1:f 3:d 4:e
2->1* 5->2 : 0:a 1:f 3:d 4:e
2->1  5->2*: 0:a 1:f 3:d 4:e
2->1* 5->3 : 0:a 1:c 3:f 4:e
2->1  5->3*: 0:a 1:c 3:f 4:e
2->1* 5->4 : 0:a 1:c 3:d 4:f
2->1  5->4*: 0:a 1:c 3:d 4:f
2->1* 5->5 : 0:a 1:c 3:d 4:e 5:f
2->1  5->5*: 0:a 1:c 3:d 4:e 5:f
2->2* 0->0 : 0:a 1:b 2:c 3:d 4:e 5:f
2->2  0->0*: 0:a 1:b 2:c 3:d 4:e 5:f
2->2* 0->1 : 1:a 2:c 3:d 4:e 5:f
2->2  0->1*: 1:a 2:c 3:d 4:e 5:f
2->2* 0->2 : 1:b 2:a 3:d 4:e 5:f
2->2  0->2*: 1:b 2:a 3:d 4:e 5:f
2->2* 0->3 : 1:b 2:c 3:a 4:e 5:f
2->2  0->3*: 1:b 2:c 3:a 4:e 5:f
2->2* 0->4 : 1:b 2:c 3:d 4:a 5:f
2->2  0->4*: 1:b 2:c 3:d 4:a 5:f
2->2* 0->5 : 1:b 2:c 3:d 4:e 5:a
2->2  0->5*: 1:b 2:c 3:d 4:e 5:a
2->2* 1->0 : 0:b 2:c 3:d 4:e 5:f
2->2  1->0*: 0:b 2:c 3:d 4:e 5:f
2->2* 1->1 : 0:a 1:b 2:c 3:d 4:e 5:f
2->2  1->1*: 0:a 1:b 2:c 3:d 4:e 5:f
2->2* 1->2 : 0:a 2:b 3:d 4:e 5:f
2->2  1->2*: 0:a 2:b 3:d 4:e 5:f
2->2* 1->3 : 0:a 2:c 3:b 4:e 5:f
2->2  1->3*: 0:a 2:c 3:b 4:e 5:f
2->2* 1->4 : 0:a 2:c 3:d 4:b 5:f
2->2  1->4*: 0:a 2:c 3:d 4:b 5:f
2->2* 1->5 : 0:a 2:c 3:d 4:e 5:b
2->2  1->5*: 0:a 2:c 3:d 4:e 5:b
2->2* 2->0 : 0:c 1:b 3:d 4:e 5:f
2->2  2->0*: 0:c 1:b 3:d 4:e 5:f
2->2* 2->1 : 0:a 1:c 3:d 4:e 5:f
2->2  2->1*: 0:a 1:c 3:d 4:e 5:f
2->2* 2->2 : 0:a 1:b 2:c 3:d 4:e 5:f
2->2  2->2*: 0:a 1:b 2:c 3:d 4:e 5:f
2->2* 2->3 : 0:a 1:b 3:c 4:e 5:f
2->2  2->3*: 0:a 1:b 3:c 4:e 5:f
2->2* 2->4 : 0:a 1:b 3:d 4:c 5:f
2->2  2->4*: 0:a 1:b 3:d 4:c 5:f
2->2* 2->5 : 0:a 1:b 3:d 4:e 5:c
2->2  2->5*: 0:a 1:b 3:d 4:e 5:c
2->2* 3->0 : 0:d 1:b 2:c 4:e 5:f
2->2  3->0*: 0:d 1:b 2:c 4:e 5:f
2->2* 3->1 : 0:a 1:d 2:c 4:e 5:f
2->2  3->1*: 0:a 1:d 2:c 4:e 5:f
2->2* 3->2 : 0:a 1:b 2:d 4:e 5:f
2->2  3->2*: 0:a 1:b 2:d 4:e 5:f
2->2* 3->3 : 0:a 1:b 2:c 3:d 4:e 5:f
2->2  3->3*: 0:a 1:b 2:c 3:d 4:e 5:f
2->2* 3->4 : 0:a 1:b 2:c 4:d 5:f
2->2  3->4*: 0:a 1:b 2:c 4:d 5:f
2->2* 3->5 : 0:a 1:b 2:c 4:e 5:d
2->2  3->5*: 0:a 1:b 2:c 4:e 5:d
2->2* 4->0 : 0:e 1:b 2:c 3:d 5:f
2->2  4->0*: 0:e 1:b 2:c 3:d 5:f
2->2* 4->1 : 0:a 1:e 2:c 3:d 5:f
2->2  4->1*: 0:a 1:e 2:c 3:d 5:f
2->2* 4->2 : 0:a 1:b 2:e 3:d 5:f
2->2  4->2*: 0:a 1:b 2:e 3:d 5:f
2->2* 4->3 : 0:a 1:b 2:c 3:e 5:f
2->2  4->3*: 0:a 1:b 2:c 3:e 5:f
2->2* 4->4 : 0:a 1:b 2:c 3:d 4:e 5:f
2->2  4->4*: 0:a 1:b 2:c 3:d 4:e 5:f
2->2* 4->5 : 0:a 1:b 2:c 3:d 5:e
2->2  4->5*: 0:a 1:b 2:c 3:d 5:e
2->2* 5->0 : 0:f 1:b 2:c 3:d 4:e
2->2  5->0*: 0:f 1:b 2:c 3:d 4:e
2->2* 5->1 : 0:a 1:f 2:c 3:d 4:e
2->2  5->1*: 0:a 1:f 2:c 3:d 4:e
2->2* 5->2 : 0:a 1:b 2:f 3:d 4:e
2->2  5->2*: 0:a 1:b 2:f 3:d 4:e
2->2* 5->3 : 0:a 1:b 2:c 3:f 4:e
2->2  5->3*: 0:a 1:b 2:c 3:f 4:e
2->2* 5->4 : 0:a 1:b 2:c 3:d 4:f
2->2  5->4*: 0:a 1:b 2:c 3:d 4:f
2->2* 5->5 : 0:a 1:b 2:c 3:d 4:e 5:f
2->2  5->5*: 0:a 1:b 2:c 3:d 4:e 5:f
2->3* 0->0 : 0:a 1:b 3:c 4:e 5:f
2->3  0->0*: 0:a 1:b 3:c 4:e 5:f
2->3* 0->1 : 1:a 3:c 4:e 5:f
2->3  0->1*: 1:a 3:c 4:e 5:f
2->3* 0->2 : 1:b 3:a 4:e 5:f
2->3  0->2*: 1:b 3:a 4:e 5:f
2->3* 0->3 : 1:b 3:c 4:e 5:f
2->3  0->3*: 1:b 3:a 4:e 5:f
2->3* 0->4 : 1:b 3:c 4:a 5:f
2->3  0->4*: 1:b 3:c 4:a 5:f
2->3* 0->5 : 1:b 3:c 4:e 5:a
2->3  0->5*: 1:b 3:c 4:e 5:a
2->3* 1->0 : 0:b 3:c 4:e 5:f
2->3  1->0*: 0:b 3:c 4:e 5:f
2->3* 1->1 : 0:a 1:b 3:c 4:e 5:f
2->3  1->1*: 0:a 1:b 3:c 4:e 5:f
2->3* 1->2 : 0:a 3:b 4:e 5:f
2->3  1->2*: 0:a 3:b 4:e 5:f
2->3* 1->3 : 0:a 3:c 4:e 5:f
2->3  1->3*: 0:a 3:b 4:e 5:f
2->3* 1->4 : 0:a 3:c 4:b 5:f
2->3  1->4*: 0:a 3:c 4:b 5:f
2->3* 1->5 : 0:a 3:c 4:e 5:b
2->3  1->5*: 0:a 3:c 4:e 5:b
2->3* 2->0 : 1:b 3:c 4:e 5:f
2->3  2->0*: 0:c 1:b 4:e 5:f
2->3* 2->1 : 0:a 3:c 4:e 5:f
2->3  2->1*: 0:a 1:c 4:e 5:f
2->3* 2->2 : 0:a 1:b 3:c 4:e 5:f
2->3  2->2*: 0:a 1:b 3:c 4:e 5:f
2->3* 2->3 : 0:a 1:b 3:c 4:e 5:f
2->3  2->3*: 0:a 1:b 3:c 4:e 5:f
2->3* 2->4 : 0:a 1:b 3:c 5:f
2->3  2->4*: 0:a 1:b 4:c 5:f
2->3* 2->5 : 0:a 1:b 3:c 4:e
2->3  2->5*: 0:a 1:b 4:e 5:c
2->3* 3->0 : 0:c 1:b 4:e 5:f
2->3  3->0*: 0:c 1:b 4:e 5:f
2->3* 3->1 : 0:a 1:c 4:e 5:f
2->3  3->1*: 0:a 1:c 4:e 5:f
2->3* 3->2 : 0:a 1:b 4:e 5:f
2->3  3->2*: 0:a 1:b 4:e 5:f
2->3* 3->3 : 0:a 1:b 3:c 4:e 5:f
2->3  3->3*: 0:a 1:b 3:c 4:e 5:f
2->3* 3->4 : 0:a 1:b 4:c 5:f
2->3  3->4*: 0:a 1:b 4:c 5:f
2->3* 3->5 : 0:a 1:b 4:e 5:c
2->3  3->5*: 0:a 1:b 4:e 5:c
2->3* 4->0 : 0:e 1:b 3:c 5:f
2->3  4->0*: 0:e 1:b 3:c 5:f
2->3* 4->1 : 0:a 1:e 3:c 5:f
2->3  4->1*: 0:a 1:e 3:c 5:f
2->3* 4->2 : 0:a 1:b 3:e 5:f
2->3  4->2*: 0:a 1:b 3:e 5:f
2->3* 4->3 : 0:a 1:b 3:c 5:f
2->3  4->3*: 0:a 1:b 3:e 5:f
2->3* 4->4 : 0:a 1:b 3:c 4:e 5:f
2->3  4->4*: 0:a 1:b 3:c 4:e 5:f
2->3* 4->5 : 0:a 1:b 3:c 5:e
2->3  4->5*: 0:a 1:b 3:c 5:e
2->3* 5->0 : 0:f 1:b 3:c 4:e
2->3  5->0*: 0:f 1:b 3:c 4:e
2->3* 5->1 : 0:a 1:f 3:c 4:e
2->3  5->1*: 0:a 1:f 3:c 4:e
2->3* 5->2 : 0:a 1:b 3:f 4:e
2->3  5->2*: 0:a 1:b 3:f 4:e
2->3* 5->3 : 0:a 1:b 3:c 4:e
2->3  5->3*: 0:a 1:b 3:f 4:e
2->3* 5->4 : 0:a 1:b 3:c 4:f
2->3  5->4*: 0:a 1:b 3:c 4:f
2->3* 5->5 : 0:a 1:b 3:c 4:e 5:f
2->3  5->5*: 0:a 1:b 3:c 4:e 5:f
2->4* 0->0 : 0:a 1:b 3:d 4:c 5:f
2->4  0->0*: 0:a 1:b 3:d 4:c 5:f
2->4* 0->1 : 1:a 3:d 4:c 5:f
2->4  0->1*: 1:a 3:d 4:c 5:f
2->4* 0->2 : 1:b 3:d 4:a 5:f
2->4  0->2*: 1:b 3:d 4:a 5:f
2->4* 0->3 : 1:b 3:a 4:c 5:f
2->4  0->3*: 1:b 3:a 4:c 5:f
2->4* 0->4 : 1:b 3:d 4:c 5:f
2->4  0->4*: 1:b 3:d 4:a 5:f
2->4* 0->5 : 1:b 3:d 4:c 5:a
2->4  0->5*: 1:b 3:d 4:c 5:a
2->4* 1->0 : 0:b 3:d 4:c 5:f
2->4  1->0*: 0:b 3:d 4:c 5:f
2->4* 1->1 : 0:a 1:b 3:d 4:c 5:f
2->4  1->1*: 0:a 1:b 3:d 4:c 5:f
2->4* 1->2 : 0:a 3:d 4:b 5:f
2->4  1->2*: 0:a 3:d 4:b 5:f
2->4* 1->3 : 0:a 3:b 4:c 5:f
2->4  1->3*: 0:a 3:b 4:c 5:f
2->4* 1->4 : 0:a 3:d 4:c 5:f
2->4  1->4*: 0:a 3:d 4:b 5:f
2->4* 1->5 : 0:a 3:d 4:c 5:b
2->4  1->5*: 0:a 3:d 4:c 5:b
2->4* 2->0 : 1:b 3:d 4:c 5:f
2->4  2->0*: 0:c 1:b 3:d 5:f
2->4* 2->1 : 0:a 3:d 4:c 5:f
2->4  2->1*: 0:a 1:c 3:d 5:f
2->4* 2->2 : 0:a 1:b 3:d 4:c 5:f
2->4  2->2*: 0:a 1:b 3:d 4:c 5:f
2->4* 2->3 : 0:a 1:b 4:c 5:f
2->4  2->3*: 0:a 1:b 3:c 5:f
2->4* 2->4 : 0:a 1:b 3:d 4:c 5:f
2->4  2->4*: 0:a 1:b 3:d 4:c 5:f
2->4* 2->5 : 0:a 1:b 3:d 4:c
2->4  2->5*: 0:a 1:b 3:d 5:c
2->4* 3->0 : 0:d 1:b 4:c 5:f
2->4  3->0*: 0:d 1:b 4:c 5:f
2->4* 3->1 : 0:a 1:d 4:c 5:f
2->4  3->1*: 0:a 1:d 4:c 5:f
2->4* 3->2 : 0:a 1:b 4:d 5:f
2->4  3->2*: 0:a 1:b 4:d 5:f
2->4* 3->3 : 0:a 1:b 3:d 4:c 5:f
2->4  3->3*: 0:a 1:b 3:d 4:c 5:f
2->4* 3->4 : 0:a 1:b 4:c 5:f
2->4  3->4*: 0:a 1:b 4:d 5:f
2->4* 3->5 : 0:a 1:b 4:c 5:d
2->4  3->5*: 0:a 1:b 4:c 5:d
2->4* 4->0 : 0:c 1:b 3:d 5:f
2->4  4->0*: 0:c 1:b 3:d 5:f
2->4* 4->1 : 0:a 1:c 3:d 5:f
2->4  4->1*: 0:a 1:c 3:d 5:f
2->4* 4->2 : 0:a 1:b 3:d 5:f
2->4  4->2*: 0:a 1:b 3:d 5:f
2->4* 4->3 : 0:a 1:b 3:c 5:f
2->4  4->3*: 0:a 1:b 3:c 5:f
2->4* 4->4 : 0:a 1:b 3:d 4:c 5:f
2->4  4->4*: 0:a 1:b 3:d 4:c 5:f
2->4* 4->5 : 0:a 1:b 3:d 5:c
2->4  4->5*: 0:a 1:b 3:d 5:c
2->4* 5->0 : 0:f 1:b 3:d 4:c
2->4  5->0*: 0:f 1:b 3:d 4:c
2->4* 5->1 : 0:a 1:f 3:d 4:c
2->4  5->1*: 0:a 1:f 3:d 4:c
2->4* 5->2 : 0:a 1:b 3:d 4:f
2->4  5->2*: 0:a 1:b 3:d 4:f
2->4* 5->3 : 0:a 1:b 3:f 4:c
2->4  5->3*: 0:a 1:b 3:f 4:c
2->4* 5->4 : 0:a 1:b 3:d 4:c
2->4  5->4*: 0:a 1:b 3:d 4:f
2->4* 5->5 : 0:a 1:b 3:d 4:c 5:f
2->4  5->5*: 0:a 1:b 3:d 4:c 5:f
2->5* 0->0 : 0:a 1:b 3:d 4:e 5:c
2->5  0->0*: 0:a 1:b 3:d 4:e 5:c
2->5* 0->1 : 1:a 3:d 4:e 5:c
2->5  0->1*: 1:a 3:d 4:e 5:c
2->5* 0->2 : 1:b 3:d 4:e 5:a
2->5  0->2*: 1:b 3:d 4:e 5:a
2->5* 0->3 : 1:b 3:a 4:e 5:c
2->5  0->3*: 1:b 3:a 4:e 5:c
2->5* 0->4 : 1:b 3:d 4:a 5:c
2->5  0->4*: 1:b 3:d 4:a 5:c
2->5* 0->5 : 1:b 3:d 4:e 5:c
2->5  0->5*: 1:b 3:d 4:e 5:a
2->5* 1->0 : 0:b 3:d 4:e 5:c
2->5  1->0*: 0:b 3:d 4:e 5:c
2->5* 1->1 : 0:a 1:b 3:d 4:e 5:c
2->5  1->1*: 0:a 1:b 3:d 4:e 5:c
2->5* 1->2 : 0:a 3:d 4:e 5:b
2->5  1->2*: 0:a 3:d 4:e 5:b
2->5* 1->3 : 0:a 3:b 4:e 5:c
2->5  1->3*: 0:a 3:b 4:e 5:c
2->5* 1->4 : 0:a 3:d 4:b 5:c
2->5  1->4*: 0:a 3:d 4:b 5:c
2->5* 1->5 : 0:a 3:d 4:e 5:c
2->5  1->5*: 0:a 3:d 4:e 5:b
2->5* 2->0 : 1:b 3:d 4:e 5:c
2->5  2->0*: 0:c 1:b 3:d 4:e
2->5* 2->1 : 0:a 3:d 4:e 5:c
2->5  2->1*: 0:a 1:c 3:d 4:e
2->5* 2->2 : 0:a 1:b 3:d 4:e 5:c
2->5  2->2*: 0:a 1:b 3:d 4:e 5:c
2->5* 2->3 : 0:a 1:b 4:e 5:c
2->5  2->3*: 0:a 1:b 3:c 4:e
2->5* 2->4 : 0:a 1:b 3:d 5:c
2->5  2->4*: 0:a 1:b 3:d 4:c
2->5* 2->5 : 0:a 1:b 3:d 4:e 5:c
2->5  2->5*: 0:a 1:b 3:d 4:e 5:c
2->5* 3->0 : 0:d 1:b 4:e 5:c
2->5  3->0*: 0:d 1:b 4:e 5:c
2->5* 3->1 : 0:a 1:d 4:e 5:c
2->5  3->1*: 0:a 1:d 4:e 5:c
2->5* 3->2 : 0:a 1:b 4:e 5:d
2->5  3->2*: 0:a 1:b 4:e 5:d
2->5* 3->3 : 0:a 1:b 3:d 4:e 5:c
2->5  3->3*: 0:a 1:b 3:d 4:e 5:c
2->5* 3->4 : 0:a 1:b 4:d 5:c
2->5  3->4*: 0:a 1:b 4:d 5:c
2->5* 3->5 : 0:a 1:b 4:e 5:c
2->5  3->5*: 0:a 1:b 4:e 5:d
2->5* 4->0 : 0:e 1:b 3:d 5:c
2->5  4->0*: 0:e 1:b 3:d 5:c
2->5* 4->1 : 0:a 1:e 3:d 5:c
2->5  4->1*: 0:a 1:e 3:d 5:c
2->5* 4->2 : 0:a 1:b 3:d 5:e
2->5  4->2*: 0:a 1:b 3:d 5:e
2->5* 4->3 : 0:a 1:b 3:e 5:c
2->5  4->3*: 0:a 1:b 3:e 5:c
2->5* 4->4 : 0:a 1:b 3:d 4:e 5:c
2->5  4->4*: 0:a 1:b 3:d 4:e 5:c
2->5* 4->5 : 0:a 1:b 3:d 5:c
2->5  4->5*: 0:a 1:b 3:d 5:e
2->5* 5->0 : 0:c 1:b 3:d 4:e
2->5  5->0*: 0:c 1:b 3:d 4:e
2->5* 5->1 : 0:a 1:c 3:d 4:e
2->5  5->1*: 0:a 1:c 3:d 4:e
2->5* 5->2 : 0:a 1:b 3:d 4:e
2->5  5->2*: 0:a 1:b 3:d 4:e
2->5* 5->3 : 0:a 1:b 3:c 4:e
2->5  5->3*: 0:a 1:b 3:c 4:e
2->5* 5->4 : 0:a 1:b 3:d 4:c
2->5  5->4*: 0:a 1:b 3:d 4:c
2->5* 5->5 : 0:a 1:b 3:d 4:e 5:c
2->5  5->5*: 0:a 1:b 3:d 4:e 5:c
3->0* 0->0 : 0:d 1:b 2:c 4:e 5:f
3->0  0->0*: 0:d 1:b 2:c 4:e 5:f
3->0* 0->1 : 1:d 2:c 4:e 5:f
3->0  0->1*: 1:d 2:c 4:e 5:f
3->0* 0->2 : 1:b 2:d 4:e 5:f
3->0  0->2*: 1:b 2:d 4:e 5:f
3->0* 0->3 : 1:b 2:c 4:e 5:f
3->0  0->3*: 1:b 2:c 4:e 5:f
3->0* 0->4 : 1:b 2:c 4:d 5:f
3->0  0->4*: 1:b 2:c 4:d 5:f
3->0* 0->5 : 1:b 2:c 4:e 5:d
3->0  0->5*: 1:b 2:c 4:e 5:d
3->0* 1->0 : 0:d 2:c 4:e 5:f
3->0  1->0*: 0:b 2:c 4:e 5:f
3->0* 1->1 : 0:d 1:b 2:c 4:e 5:f
3->0  1->1*: 0:d 1:b 2:c 4:e 5:f
3->0* 1->2 : 0:d 2:b 4:e 5:f
3->0  1->2*: 0:d 2:b 4:e 5:f
3->0* 1->3 : 0:b 2:c 4:e 5:f
3->0  1->3*: 0:b 2:c 4:e 5:f
3->0* 1->4 : 0:d 2:c 4:b 5:f
3->0  1->4*: 0:d 2:c 4:b 5:f
3->0* 1->5 : 0:d 2:c 4:e 5:b
3->0  1->5*: 0:d 2:c 4:e 5:b
3->0* 2->0 : 0:d 1:b 4:e 5:f
3->0  2->0*: 0:c 1:b 4:e 5:f
3->0* 2->1 : 0:d 1:c 4:e 5:f
3->0  2->1*: 0:d 1:c 4:e 5:f
3->0* 2->2 : 0:d 1:b 2:c 4:e 5:f
3->0  2->2*: 0:d 1:b 2:c 4:e 5:f
3->0* 2->3 : 0:c 1:b 4:e 5:f
3->0  2->3*: 0:c 1:b 4:e 5:f
3->0* 2->4 : 0:d 1:b 4:c 5:f
3->0  2->4*: 0:d 1:b 4:c 5:f
3->0* 2->5 : 0:d 1:b 4:e 5:c
3->0  2->5*: 0:d 1:b 4:e 5:c
3->0* 3->0 : 0:d 1:b 2:c 4:e 5:f
3->0  3->0*: 0:d 1:b 2:c 4:e 5:f
3->0* 3->1 : 0:d 2:c 4:e 5:f
3->0  3->1*: 1:d 2:c 4:e 5:f
3->0* 3->2 : 0:d 1:b 4:e 5:f
3->0  3->2*: 1:b 2:d 4:e 5:f
3->0* 3->3 : 0:d 1:b 2:c 4:e 5:f
3->0  3->3*: 0:d 1:b 2:c 4:e 5:f
3->0* 3->4 : 0:d 1:b 2:c 5:f
3->0  3->4*: 1:b 2:c 4:d 5:f
3->0* 3->5 : 0:d 1:b 2:c 4:e
3->0  3->5*: 1:b 2:c 4:e 5:d
3->0* 4->0 : 0:d 1:b 2:c 5:f
3->0  4->0*: 0:e 1:b 2:c 5:f
3->0* 4->1 : 0:d 1:e 2:c 5:f
3->0  4->1*: 0:d 1:e 2:c 5:f
3->0* 4->2 : 0:d 1:b 2:e 5:f
3->0  4->2*: 0:d 1:b 2:e 5:f
3->0* 4->3 : 0:e 1:b 2:c 5:f
3->0  4->3*: 0:e 1:b 2:c 5:f
3->0* 4->4 : 0:d 1:b 2:c 4:e 5:f
3->0  4->4*: 0:d 1:b 2:c 4:e 5:f
3->0* 4->5 : 0:d 1:b 2:c 5:e
3->0  4->5*: 0:d 1:b 2:c 5:e
3->0* 5->0 : 0:d 1:b 2:c 4:e
3->0  5->0*: 0:f 1:b 2:c 4:e
3->0* 5->1 : 0:d 1:f 2:c 4:e
3->0  5->1*: 0:d 1:f 2:c 4:e
3->0* 5->2 : 0:d 1:b 2:f 4:e
3->0  5->2*: 0:d 1:b 2:f 4:e
3->0* 5->3 : 0:f 1:b 2:c 4:e
3->0  5->3*: 0:f 1:b 2:c 4:e
3->0* 5->4 : 0:d 1:b 2:c 4:f
3->0  5->4*: 0:d 1:b 2:c 4:f
3->0* 5->5 : 0:d 1:b 2:c 4:e 5:f
3->0  5->5*: 0:d 1:b 2:c 4:e 5:f
3->1* 0->0 : 0:a 1:d 2:c 4:e 5:f
3->1  0->0*: 0:a 1:d 2:c 4:e 5:f
3->1* 0->1 : 1:d 2:c 4:e 5:f
3->1  0->1*: 1:a 2:c 4:e 5:f
3->1* 0->2 : 1:d 2:a 4:e 5:f
3->1  0->2*: 1:d 2:a 4:e 5:f
3->1* 0->3 : 1:a 2:c 4:e 5:f
3->1  0->3*: 1:a 2:c 4:e 5:f
3->1* 0->4 : 1:d 2:c 4:a 5:f
3->1  0->4*: 1:d 2:c 4:a 5:f
3->1* 0->5 : 1:d 2:c 4:e 5:a
3->1  0->5*: 1:d 2:c 4:e 5:a
3->1* 1->0 : 0:d 2:c 4:e 5:f
3->1  1->0*: 0:d 2:c 4:e 5:f
3->1* 1->1 : 0:a 1:d 2:c 4:e 5:f
3->1  1->1*: 0:a 1:d 2:c 4:e 5:f
3->1* 1->2 : 0:a 2:d 4:e 5:f
3->1  1->2*: 0:a 2:d 4:e 5:f
3->1* 1->3 : 0:a 2:c 4:e 5:f
3->1  1->3*: 0:a 2:c 4:e 5:f
3->1* 1->4 : 0:a 2:c 4:d 5:f
3->1  1->4*: 0:a 2:c 4:d 5:f
3->1* 1->5 : 0:a 2:c 4:e 5:d
3->1  1->5*: 0:a 2:c 4:e 5:d
3->1* 2->0 : 0:c 1:d 4:e 5:f
3->1  2->0*: 0:c 1:d 4:e 5:f
3->1* 2->1 : 0:a 1:d 4:e 5:f
3->1  2->1*: 0:a 1:c 4:e 5:f
3->1* 2->2 : 0:a 1:d 2:c 4:e 5:f
3->1  2->2*: 0:a 1:d 2:c 4:e 5:f
3->1* 2->3 : 0:a 1:c 4:e 5:f
3->1  2->3*: 0:a 1:c 4:e 5:f
3->1* 2->4 : 0:a 1:d 4:c 5:f
3->1  2->4*: 0:a 1:d 4:c 5:f
3->1* 2->5 : 0:a 1:d 4:e 5:c
3->1  2->5*: 0:a 1:d 4:e 5:c
3->1* 3->0 : 1:d 2:c 4:e 5:f
3->1  3->0*: 0:d 2:c 4:e 5:f
3->1* 3->1 : 0:a 1:d 2:c 4:e 5:f
3->1  3->1*: 0:a 1:d 2:c 4:e 5:f
3->1* 3->2 : 0:a 1:d 4:e 5:f
3->1  3->2*: 0:a 2:d 4:e 5:f
3->1* 3->3 : 0:a 1:d 2:c 4:e 5:f
3->1  3->3*: 0:a 1:d 2:c 4:e 5:f
3->1* 3->4 : 0:a 1:d 2:c 5:f
3->1  3->4*: 0:a 2:c 4:d 5:f
3->1* 3->5 : 0:a 1:d 2:c 4:e
3->1  3->5*: 0:a 2:c 4:e 5:d
3->1* 4->0 : 0:e 1:d 2:c 5:f
3->1  4->0*: 0:e 1:d 2:c 5:f
3->1* 4->1 : 0:a 1:d 2:c 5:f
3->1  4->1*: 0:a 1:e 2:c 5:f
3->1* 4->2 : 0:a 1:d 2:e 5:f
3->1  4->2*: 0:a 1:d 2:e 5:f
3->1* 4->3 : 0:a 1:e 2:c 5:f
3->1  4->3*: 0:a 1:e 2:c 5:f
3->1* 4->4 : 0:a 1:d 2:c 4:e 5:f
3->1  4->4*: 0:a 1:d 2:c 4:e 5:f
3->1* 4->5 : 0:a 1:d 2:c 5:e
3->1  4->5*: 0:a 1:d 2:c 5:e
3->1* 5->0 : 0:f 1:d 2:c 4:e
3->1  5->0*: 0:f 1:d 2:c 4:e
3->1* 5->1 : 0:a 1:d 2:c 4:e
3->1  5->1*: 0:a 1:f 2:c 4:e
3->1* 5->2 : 0:a 1:d 2:f 4:e
3->1  5->2*: 0:a 1:d 2:f 4:e
3->1* 5->3 : 0:a 1:f 2:c 4:e
3->1  5->3*: 0:a 1:f 2:c 4:e
3->1* 5->4 : 0:a 1:d 2:c 4:f
3->1  5->4*: 0:a 1:d 2:c 4:f
3->1* 5->5 : 0:a 1:d 2:c 4:e 5:f
3->1  5->5*: 0:a 1:d 2:c 4:e 5:f
3->2* 0->0 : 0:a 1:b 2:d 4:e 5:f
3->2  0->0*: 0:a 1:b 2:d 4:e 5:f
3->2* 0->1 : 1:a 2:d 4:e 5:f
3->2  0->1*: 1:a 2:d 4:e 5:f
3->2* 0->2 : 1:b 2:d 4:e 5:f
3->2  0->2*: 1:b 2:a 4:e 5:f
3->2* 0->3 : 1:b 2:a 4:e 5:f
3->2  0->3*: 1:b 2:a 4:e 5:f
3->2* 0->4 : 1:b 2:d 4:a 5:f
3->2  0->4*: 1:b 2:d 4:a 5:f
3->2* 0->5 : 1:b 2:d 4:e 5:a
3->2  0->5*: 1:b 2:d 4:e 5:a
3->2* 1->0 : 0:b 2:d 4:e 5:f
3->2  1->0*: 0:b 2:d 4:e 5:f
3->2* 1->1 : 0:a 1:b 2:d 4:e 5:f
3->2  1->1*: 0:a 1:b 2:d 4:e 5:f
3->2* 1->2 : 0:a 2:d 4:e 5:f
3->2  1->2*: 0:a 2:b 4:e 5:f
3->2* 1->3 : 0:a 2:b 4:e 5:f
3->2  1->3*: 0:a 2:b 4:e 5:f
3->2* 1->4 : 0:a 2:d 4:b 5:f
3->2  1->4*: 0:a 2:d 4:b 5:f
3->2* 1->5 : 0:a 2:d 4:e 5:b
3->2  1->5*: 0:a 2:d 4:e 5:b
3->2* 2->0 : 0:d 1:b 4:e 5:f
3->2  2->0*: 0:d 1:b 4:e 5:f
3->2* 2->1 : 0:a 1:d 4:e 5:f
3->2  2->1*: 0:a 1:d 4:e 5:f
3->2* 2->2 : 0:a 1:b 2:d 4:e 5:f
3->2  2->2*: 0:a 1:b 2:d 4:e 5:f
3->2* 2->3 : 0:a 1:b 4:e 5:f
3->2  2->3*: 0:a 1:b 4:e 5:f
3->2* 2->4 : 0:a 1:b 4:d 5:f
3->2  2->4*: 0:a 1:b 4:d 5:f
3->2* 2->5 : 0:a 1:b 4:e 5:d
3->2  2->5*: 0:a 1:b 4:e 5:d
3->2* 3->0 : 1:b 2:d 4:e 5:f
3->2  3->0*: 0:d 1:b 4:e 5:f
3->2* 3->1 : 0:a 2:d 4:e 5:f
3->2  3->1*: 0:a 1:d 4:e 5:f
3->2* 3->2 : 0:a 1:b 2:d 4:e 5:f
3->2  3->2*: 0:a 1:b 2:d 4:e 5:f
3->2* 3->3 : 0:a 1:b 2:d 4:e 5:f
3->2  3->3*: 0:a 1:b 2:d 4:e 5:f
3->2* 3->4 : 0:a 1:b 2:d 5:f
3->2  3->4*: 0:a 1:b 4:d 5:f
3->2* 3->5 : 0:a 1:b 2:d 4:e
3->2  3->5*: 0:a 1:b 4:e 5:d
3->2* 4->0 : 0:e 1:b 2:d 5:f
3->2  4->0*: 0:e 1:b 2:d 5:f
3->2* 4->1 : 0:a 1:e 2:d 5:f
3->2  4->1*: 0:a 1:e 2:d 5:f
3->2* 4->2 : 0:a 1:b 2:d 5:f
3->2  4->2*: 0:a 1:b 2:e 5:f
3->2* 4->3 : 0:a 1:b 2:e 5:f
3->2  4->3*: 0:a 1:b 2:e 5:f
3->2* 4->4 : 0:a 1:b 2:d 4:e 5:f
3->2  4->4*: 0:a 1:b 2:d 4:e 5:f
3->2* 4->5 : 0:a 1:b 2:d 5:e
3->2  4->5*: 0:a 1:b 2:d 5:e
3->2* 5->0 : 0:f 1:b 2:d 4:e
3->2  5->0*: 0:f 1:b 2:d 4:e
3->2* 5->1 : 0:a 1:f 2:d 4:e
3->2  5->1*: 0:a 1:f 2:d 4:e
3->2* 5->2 : 0:a 1:b 2:d 4:e
3->2  5->2*: 0:a 1:b 2:f 4:e
3->2* 5->3 : 0:a 1:b 2:f 4:e
3->2  5->3*: 0:a 1:b 2:f 4:e
3->2* 5->4 : 0:a 1:b 2:d 4:f
3->2  5->4*: 0:a 1:b 2:d 4:f
3->2* 5->5 : 0:a 1:b 2:d 4:e 5:f
3->2  5->5*: 0:a 1:b 2:d 4:e 5:f
3->3* 0->0 : 0:a 1:b 2:c 3:d 4:e 5:f
3->3  0->0*: 0:a 1:b 2:c 3:d 4:e 5:f
3->3* 0->1 : 1:a 2:c 3:d 4:e 5:f
3->3  0->1*: 1:a 2:c 3:d 4:e 5:f
3->3* 0->2 : 1:b 2:a 3:d 4:e 5:f
3->3  0->2*: 1:b 2:a 3:d 4:e 5:f
3->3* 0->3 : 1:b 2:c 3:a 4:e 5:f
3->3  0->3*: 1:b 2:c 3:a 4:e 5:f
3->3* 0->4 : 1:b 2:c 3:d 4:a 5:f
3->3  0->4*: 1:b 2:c 3:d 4:a 5:f
3->3* 0->5 : 1:b 2:c 3:d 4:e 5:a
3->3  0->5*: 1:b 2:c 3:d 4:e 5:a
3->3* 1->0 : 0:b 2:c 3:d 4:e 5:f
3->3  1->0*: 0:b 2:c 3:d 4:e 5:f
3->3* 1->1 : 0:a 1:b 2:c 3:d 4:e 5:f
3->3  1->1*: 0:a 1:b 2:c 3:d 4:e 5:f
3->3* 1->2 : 0:a 2:b 3:d 4:e 5:f
3->3  1->2*: 0:a 2:b 3:d 4:e 5:f
3->3* 1->3 : 0:a 2:c 3:b 4:e 5:f
3->3  1->3*: 0:a 2:c 3:b 4:e 5:f
3->3* 1->4 : 0:a 2:c 3:d 4:b 5:f
3->3  1->4*: 0:a 2:c 3:d 4:b 5:f
3->3* 1->5 : 0:a 2:c 3:d 4:e 5:b
3->3  1->5*: 0:a 2:c 3:d 4:e 5:b
3->3* 2->0 : 0:c 1:b 3:d 4:e 5:f
3->3  2->0*: 0:c 1:b 3:d 4:e 5:f
3->3* 2->1 : 0:a 1:c 3:d 4:e 5:f
3->3  2->1*: 0:a 1:c 3:d 4:e 5:f
3->3* 2->2 : 0:a 1:b 2:c 3:d 4:e 5:f
3->3  2->2*: 0:a 1:b 2:c 3:d 4:e 5:f
3->3* 2->3 : 0:a 1:b 3:c 4:e 5:f
3->3  2->3*: 0:a 1:b 3:c 4:e 5:f
3->3* 2->4 : 0:a 1:b 3:d 4:c 5:f
3->3  2->4*: 0:a 1:b 3:d 4:c 5:f
3->3* 2->5 : 0:a 1:b 3:d 4:e 5:c
3->3  2->5*: 0:a 1:b 3:d 4:e 5:c
3->3* 3->0 : 0:d 1:b 2:c 4:e 5:f
3->3  3->0*: 0:d 1:b 2:c 4:e 5:f
3->3* 3->1 : 0:a 1:d 2:c 4:e 5:f
3->3  3->1*: 0:a 1:d 2:c 4:e 5:f
3->3* 3->2 : 0:a 1:b 2:d 4:e 5:f
3->3  3->2*: 0:a 1:b 2:d 4:e 5:f
3->3* 3->3 : 0:a 1:b 2:c 3:d 4:e 5:f
3->3  3->3*: 0:a 1:b 2:c 3:d 4:e 5:f
3->3* 3->4 : 0:a 1:b 2:c 4:d 5:f
3->3  3->4*: 0:a 1:b 2:c 4:d 5:f
3->3* 3->5 : 0:a 1:b 2:c 4:e 5:d
3->3  3->5*: 0:a 1:b 2:c 4:e 5:d
3->3* 4->0 : 0:e 1:b 2:c 3:d 5:f
3->3  4->0*: 0:e 1:b 2:c 3:d 5:f
3->3* 4->1 : 0:a 1:e 2:c 3:d 5:f
3->3  4->1*: 0:a 1:e 2:c 3:d 5:f
3->3* 4->2 : 0:a 1:b 2:e 3:d 5:f
3->3  4->2*: 0:a 1:b 2:e 3:d 5:f
3->3* 4->3 : 0:a 1:b 2:c 3:e 5:f
3->3  4->3*: 0:a 1:b 2:c 3:e 5:f
3->3* 4->4 : 0:a 1:b 2:c 3:d 4:e 5:f
3->3  4->4*: 0:a 1:b 2:c 3:d 4:e 5:f
3->3* 4->5 : 0:a 1:b 2:c 3:d 5:e
3->3  4->5*: 0:a 1:b 2:c 3:d 5:e
3->3* 5->0 : 0:f 1:b 2:c 3:d 4:e
3->3  5->0*: 0:f 1:b 2:c 3:d 4:e
3->3* 5->1 : 0:a 1:f 2:c 3:d 4:e
3->3  5->1*: 0:a 1:f 2:c 3:d 4:e
3->3* 5->2 : 0:a 1:b 2:f 3:d 4:e
3->3  5->2*: 0:a 1:b 2:f 3:d 4:e
3->3* 5->3 : 0:a 1:b 2:c 3:f 4:e
3->3  5->3*: 0:a 1:b 2:c 3:f 4:e
3->3* 5->4 : 0:a 1:b 2:c 3:d 4:f
3->3  5->4*: 0:a 1:b 2:c 3:d 4:f
3->3* 5->5 : 0:a 1:b 2:c 3:d 4:e 5:f
3->3  5->5*: 0:a 1:b 2:c 3:d 4:e 5:f
3->4* 0->0 : 0:a 1:b 2:c 4:d 5:f
3->4  0->0*: 0:a 1:b 2:c 4:d 5:f
3->4* 0->1 : 1:a 2:c 4:d 5:f
3->4  0->1*: 1:a 2:c 4:d 5:f
3->4* 0->2 : 1:b 2:a 4:d 5:f
3->4  0->2*: 1:b 2:a 4:d 5:f
3->4* 0->3 : 1:b 2:c 4:a 5:f
3->4  0->3*: 1:b 2:c 4:a 5:f
3->4* 0->4 : 1:b 2:c 4:d 5:f
3->4  0->4*: 1:b 2:c 4:a 5:f
3->4* 0->5 : 1:b 2:c 4:d 5:a
3->4  0->5*: 1:b 2:c 4:d 5:a
3->4* 1->0 : 0:b 2:c 4:d 5:f
3->4  1->0*: 0:b 2:c 4:d 5:f
3->4* 1->1 : 0:a 1:b 2:c 4:d 5:f
3->4  1->1*: 0:a 1:b 2:c 4:d 5:f
3->4* 1->2 : 0:a 2:b 4:d 5:f
3->4  1->2*: 0:a 2:b 4:d 5:f
3->4* 1->3 : 0:a 2:c 4:b 5:f
3->4  1->3*: 0:a 2:c 4:b 5:f
3->4* 1->4 : 0:a 2:c 4:d 5:f
3->4  1->4*: 0:a 2:c 4:b 5:f
3->4* 1->5 : 0:a 2:c 4:d 5:b
3->4  1->5*: 0:a 2:c 4:d 5:b
3->4* 2->0 : 0:c 1:b 4:d 5:f
3->4  2->0*: 0:c 1:b 4:d 5:f
3->4* 2->1 : 0:a 1:c 4:d 5:f
3->4  2->1*: 0:a 1:c 4:d 5:f
3->4* 2->2 : 0:a 1:b 2:c 4:d 5:f
3->4  2->2*: 0:a 1:b 2:c 4:d 5:f
3->4* 2->3 : 0:a 1:b 4:c 5:f
3->4  2->3*: 0:a 1:b 4:c 5:f
3->4* 2->4 : 0:a 1:b 4:d 5:f
3->4  2->4*: 0:a 1:b 4:c 5:f
3->4* 2->5 : 0:a 1:b 4:d 5:c
3->4  2->5*: 0:a 1:b 4:d 5:c
3->4* 3->0 : 1:b 2:c 4:d 5:f
3->4  3->0*: 0:d 1:b 2:c 5:f
3->4* 3->1 : 0:a 2:c 4:d 5:f
3->4  3->1*: 0:a 1:d 2:c 5:f
3->4* 3->2 : 0:a 1:b 4:d 5:f
3->4  3->2*: 0:a 1:b 2:d 5:f
3->4* 3->3 : 0:a 1:b 2:c 4:d 5:f
3->4  3->3*: 0:a 1:b 2:c 4:d 5:f
3->4* 3->4 : 0:a 1:b 2:c 4:d 5:f
3->4  3->4*: 0:a 1:b 2:c 4:d 5:f
3->4* 3->5 : 0:a 1:b 2:c 4:d
3->4  3->5*: 0:a 1:b 2:c 5:d
3->4* 4->0 : 0:d 1:b 2:c 5:f
3->4  4->0*: 0:d 1:b 2:c 5:f
3->4* 4->1 : 0:a 1:d 2:c 5:f
3->4  4->1*: 0:a 1:d 2:c 5:f
3->4* 4->2 : 0:a 1:b 2:d 5:f
3->4  4->2*: 0:a 1:b 2:d 5:f
3->4* 4->3 : 0:a 1:b 2:c 5:f
3->4  4->3*: 0:a 1:b 2:c 5:f
3->4* 4->4 : 0:a 1:b 2:c 4:d 5:f
3->4  4->4*: 0:a 1:b 2:c 4:d 5:f
3->4* 4->5 : 0:a 1:b 2:c 5:d
3->4  4->5*: 0:a 1:b 2:c 5:d
3->4* 5->0 : 0:f 1:b 2:c 4:d
3->4  5->0*: 0:f 1:b 2:c 4:d
3->4* 5->1 : 0:a 1:f 2:c 4:d
3->4  5->1*: 0:a 1:f 2:c 4:d
3->4* 5->2 : 0:a 1:b 2:f 4:d
3->4  5->2*: 0:a 1:b 2:f 4:d
3->4* 5->3 : 0:a 1:b 2:c 4:f
3->4  5->3*: 0:a 1:b 2:c 4:f
3->4* 5->4 : 0:a 1:b 2:c 4:d
3->4  5->4*: 0:a 1:b 2:c 4:f
3->4* 5->5 : 0:a 1:b 2:c 4:d 5:f
3->4  5->5*: 0:a 1:b 2:c 4:d 5:f
3->5* 0->0 : 0:a 1:b 2:c 4:e 5:d
3->5  0->0*: 0:a 1:b 2:c 4:e 5:d
3->5* 0->1 : 1:a 2:c 4:e 5:d
3->5  0->1*: 1:a 2:c 4:e 5:d
3->5* 0->2 : 1:b 2:a 4:e 5:d
3->5  0->2*: 1:b 2:a 4:e 5:d
3->5* 0->3 : 1:b 2:c 4:e 5:a
3->5  0->3*: 1:b 2:c 4:e 5:a
3->5* 0->4 : 1:b 2:c 4:a 5:d
3->5  0->4*: 1:b 2:c 4:a 5:d
3->5* 0->5 : 1:b 2:c 4:e 5:d
3->5  0->5*: 1:b 2:c 4:e 5:a
3->5* 1->0 : 0:b 2:c 4:e 5:d
3->5  1->0*: 0:b 2:c 4:e 5:d
3->5* 1->1 : 0:a 1:b 2:c 4:e 5:d
3->5  1->1*: 0:a 1:b 2:c 4:e 5:d
3->5* 1->2 : 0:a 2:b 4:e 5:d
3->5  1->2*: 0:a 2:b 4:e 5:d
3->5* 1->3 : 0:a 2:c 4:e 5:b
3->5  1->3*: 0:a 2:c 4:e 5:b
3->5* 1->4 : 0:a 2:c 4:b 5:d
3->5  1->4*: 0:a 2:c 4:b 5:d
3->5* 1->5 : 0:a 2:c 4:e 5:d
3->5  1->5*: 0:a 2:c 4:e 5:b
3->5* 2->0 : 0:c 1:b 4:e 5:d
3->5  2->0*: 0:c 1:b 4:e 5:d
3->5* 2->1 : 0:a 1:c 4:e 5:d
3->5  2->1*: 0:a 1:c 4:e 5:d
3->5* 2->2 : 0:a 1:b 2:c 4:e 5:d
3->5  2->2*: 0:a 1:b 2:c 4:e 5:d
3->5* 2->3 : 0:a 1:b 4:e 5:c
3->5  2->3*: 0:a 1:b 4:e 5:c
3->5* 2->4 : 0:a 1:b 4:c 5:d
3->5  2->4*: 0:a 1:b 4:c 5:d
3->5* 2->5 : 0:a 1:b 4:e 5:d
3->5  2->5*: 0:a 1:b 4:e 5:c
3->5* 3->0 : 1:b 2:c 4:e 5:d
3->5  3->0*: 0:d 1:b 2:c 4:e
3->5* 3->1 : 0:a 2:c 4:e 5:d
3->5  3->1*: 0:a 1:d 2:c 4:e
3->5* 3->2 : 0:a 1:b 4:e 5:d
3->5  3->2*: 0:a 1:b 2:d 4:e
3->5* 3->3 : 0:a 1:b 2:c 4:e 5:d
3->5  3->3*: 0:a 1:b 2:c 4:e 5:d
3->5* 3->4 : 0:a 1:b 2:c 5:d
3->5  3->4*: 0:a 1:b 2:c 4:d
3->5* 3->5 : 0:a 1:b 2:c 4:e 5:d
3->5  3->5*: 0:a 1:b 2:c 4:e 5:d
3->5* 4->0 : 0:e 1:b 2:c 5:d
3->5  4->0*: 0:e 1:b 2:c 5:d
3->5* 4->1 : 0:a 1:e 2:c 5:d
3->5  4->1*: 0:a 1:e 2:c 5:d
3->5* 4->2 : 0:a 1:b 2:e 5:d
3->5  4->2*: 0:a 1:b 2:e 5:d
3->5* 4->3 : 0:a 1:b 2:c 5:e
3->5  4->3*: 0:a 1:b 2:c 5:e
3->5* 4->4 : 0:a 1:b 2:c 4:e 5:d
3->5  4->4*: 0:a 1:b 2:c 4:e 5:d
3->5* 4->5 : 0:a 1:b 2:c 5:d
3->5  4->5*: 0:a 1:b 2:c 5:e
3->5* 5->0 : 0:d 1:b 2:c 4:e
3->5  5->0*: 0:d 1:b 2:c 4:e
3->5* 5->1 : 0:a 1:d 2:c 4:e
3->5  5->1*: 0:a 1:d 2:c 4:e
3->5* 5->2 : 0:a 1:b 2:d 4:e
3->5  5->2*: 0:a 1:b 2:d 4:e
3->5* 5->3 : 0:a 1:b 2:c 4:e
3->5  5->3*: 0:a 1:b 2:c 4:e
3->5* 5->4 : 0:a 1:b 2:c 4:d
3->5  5->4*: 0:a 1:b 2:c 4:d
3->5* 5->5 : 0:a 1:b 2:c 4:e 5:d
3->5  5->5*: 0:a 1:b 2:c 4:e 5:d
4->0* 0->0 : 0:e 1:b 2:c 3:d 5:f
4->0  0->0*: 0:e 1:b 2:c 3:d 5:f
4->0* 0->1 : 1:e 2:c 3:d 5:f
4->0  0->1*: 1:e 2:c 3:d 5:f
4->0* 0->2 : 1:b 2:e 3:d 5:f
4->0  0->2*: 1:b 2:e 3:d 5:f
4->0* 0->3 : 1:b 2:c 3:e 5:f
4->0  0->3*: 1:b 2:c 3:e 5:f
4->0* 0->4 : 1:b 2:c 3:d 5:f
4->0  0->4*: 1:b 2:c 3:d 5:f
4->0* 0->5 : 1:b 2:c 3:d 5:e
4->0  0->5*: 1:b 2:c 3:d 5:e
4->0* 1->0 : 0:e 2:c 3:d 5:f
4->0  1->0*: 0:b 2:c 3:d 5:f
4->0* 1->1 : 0:e 1:b 2:c 3:d 5:f
4->0  1->1*: 0:e 1:b 2:c 3:d 5:f
4->0* 1->2 : 0:e 2:b 3:d 5:f
4->0  1->2*: 0:e 2:b 3:d 5:f
4->0* 1->3 : 0:e 2:c 3:b 5:f
4->0  1->3*: 0:e 2:c 3:b 5:f
4->0* 1->4 : 0:b 2:c 3:d 5:f
4->0  1->4*: 0:b 2:c 3:d 5:f
4->0* 1->5 : 0:e 2:c 3:d 5:b
4->0  1->5*: 0:e 2:c 3:d 5:b
4->0* 2->0 : 0:e 1:b 3:d 5:f
4->0  2->0*: 0:c 1:b 3:d 5:f
4->0* 2->1 : 0:e 1:c 3:d 5:f
4->0  2->1*: 0:e 1:c 3:d 5:f
4->0* 2->2 : 0:e 1:b 2:c 3:d 5:f
4->0  2->2*: 0:e 1:b 2:c 3:d 5:f
4->0* 2->3 : 0:e 1:b 3:c 5:f
4->0  2->3*: 0:e 1:b 3:c 5:f
4->0* 2->4 : 0:c 1:b 3:d 5:f
4->0  2->4*: 0:c 1:b 3:d 5:f
4->0* 2->5 : 0:e 1:b 3:d 5:c
4->0  2->5*: 0:e 1:b 3:d 5:c
4->0* 3->0 : 0:e 1:b 2:c 5:f
4->0  3->0*: 0:d 1:b 2:c 5:f
4->0* 3->1 : 0:e 1:d 2:c 5:f
4->0  3->1*: 0:e 1:d 2:c 5:f
4->0* 3->2 : 0:e 1:b 2:d 5:f
4->0  3->2*: 0:e 1:b 2:d 5:f
4->0* 3->3 : 0:e 1:b 2:c 3:d 5:f
4->0  3->3*: 0:e 1:b 2:c 3:d 5:f
4->0* 3->4 : 0:d 1:b 2:c 5:f
4->0  3->4*: 0:d 1:b 2:c 5:f
4->0* 3->5 : 0:e 1:b 2:c 5:d
4->0  3->5*: 0:e 1:b 2:c 5:d
4->0* 4->0 : 0:e 1:b 2:c 3:d 5:f
4->0  4->0*: 0:e 1:b 2:c 3:d 5:f
4->0* 4->1 : 0:e 2:c 3:d 5:f
4->0  4->1*: 1:e 2:c 3:d 5:f
4->0* 4->2 : 0:e 1:b 3:d 5:f
4->0  4->2*: 1:b 2:e 3:d 5:f
4->0* 4->3 : 0:e 1:b 2:c 5:f
4->0  4->3*: 1:b 2:c 3:e 5:f
4->0* 4->4 : 0:e 1:b 2:c 3:d 5:f
4->0  4->4*: 0:e 1:b 2:c 3:d 5:f
4->0* 4->5 : 0:e 1:b 2:c 3:d
4->0  4->5*: 1:b 2:c 3:d 5:e
4->0* 5->0 : 0:e 1:b 2:c 3:d
4->0  5->0*: 0:f 1:b 2:c 3:d
4->0* 5->1 : 0:e 1:f 2:c 3:d
4->0  5->1*: 0:e 1:f 2:c 3:d
4->0* 5->2 : 0:e 1:b 2:f 3:d
4->0  5->2*: 0:e 1:b 2:f 3:d
4->0* 5->3 : 0:e 1:b 2:c 3:f
4->0  5->3*: 0:e 1:b 2:c 3:f
4->0* 5->4 : 0:f 1:b 2:c 3:d
4->0  5->4*: 0:f 1:b 2:c 3:d
4->0* 5->5 : 0:e 1:b 2:c 3:d 5:f
4->0  5->5*: 0:e 1:b 2:c 3:d 5:f
4->1* 0->0 : 0:a 1:e 2:c 3:d 5:f
4->1  0->0*: 0:a 1:e 2:c 3:d 5:f
4->1* 0->1 : 1:e 2:c 3:d 5:f
4->1  0->1*: 1:a 2:c 3:d 5:f
4->1* 0->2 : 1:e 2:a 3:d 5:f
4->1  0->2*: 1:e 2:a 3:d 5:f
4->1* 0->3 : 1:e 2:c 3:a 5:f
4->1  0->3*: 1:e 2:c 3:a 5:f
4->1* 0->4 : 1:a 2:c 3:d 5:f
4->1  0->4*: 1:a 2:c 3:d 5:f
4->1* 0->5 : 1:e 2:c 3:d 5:a
4->1  0->5*: 1:e 2:c 3:d 5:a
4->1* 1->0 : 0:e 2:c 3:d 5:f
4->1  1->0*: 0:e 2:c 3:d 5:f
4->1* 1->1 : 0:a 1:e 2:c 3:d 5:f
4->1  1->1*: 0:a 1:e 2:c 3:d 5:f
4->1* 1->2 : 0:a 2:e 3:d 5:f
4->1  1->2*: 0:a 2:e 3:d 5:f
4->1* 1->3 : 0:a 2:c 3:e 5:f
4->1  1->3*: 0:a 2:c 3:e 5:f
4->1* 1->4 : 0:a 2:c 3:d 5:f
4->1  1->4*: 0:a 2:c 3:d 5:f
4->1* 1->5 : 0:a 2:c 3:d 5:e
4->1  1->5*: 0:a 2:c 3:d 5:e
4->1* 2->0 : 0:c 1:e 3:d 5:f
4->1  2->0*: 0:c 1:e 3:d 5:f
4->1* 2->1 : 0:a 1:e 3:d 5:f
4->1  2->1*: 0:a 1:c 3:d 5:f
4->1* 2->2 : 0:a 1:e 2:c 3:d 5:f
4->1  2->2*: 0:a 1:e 2:c 3:d 5:f
4->1* 2->3 : 0:a 1:e 3:c 5:f
4->1  2->3*: 0:a 1:e 3:c 5:f
4->1* 2->4 : 0:a 1:c 3:d 5:f
4->1  2->4*: 0:a 1:c 3:d 5:f
4->1* 2->5 : 0:a 1:e 3:d 5:c
4->1  2->5*: 0:a 1:e 3:d 5:c
4->1* 3->0 : 0:d 1:e 2:c 5:f
4->1  3->0*: 0:d 1:e 2:c 5:f
4->1* 3->1 : 0:a 1:e 2:c 5:f
4->1  3->1*: 0:a 1:d 2:c 5:f
4->1* 3->2 : 0:a 1:e 2:d 5:f
4->1  3->2*: 0:a 1:e 2:d 5:f
4->1* 3->3 : 0:a 1:e 2:c 3:d 5:f
4->1  3->3*: 0:a 1:e 2:c 3:d 5:f
4->1* 3->4 : 0:a 1:d 2:c 5:f
4->1  3->4*: 0:a 1:d 2:c 5:f
4->1* 3->5 : 0:a 1:e 2:c 5:d
4->1  3->5*: 0:a 1:e 2:c 5:d
4->1* 4->0 : 1:e 2:c 3:d 5:f
4->1  4->0*: 0:e 2:c 3:d 5:f
4->1* 4->1 : 0:a 1:e 2:c 3:d 5:f
4->1  4->1*: 0:a 1:e 2:c 3:d 5:f
4->1* 4->2 : 0:a 1:e 3:d 5:f
4->1  4->2*: 0:a 2:e 3:d 5:f
4->1* 4->3 : 0:a 1:e 2:c 5:f
4->1  4->3*: 0:a 2:c 3:e 5:f
4->1* 4->4 : 0:a 1:e 2:c 3:d 5:f
4->1  4->4*: 0:a 1:e 2:c 3:d 5:f
4->1* 4->5 : 0:a 1:e 2:c 3:d
4->1  4->5*: 0:a 2:c 3:d 5:e
4->1* 5->0 : 0:f 1:e 2:c 3:d
4->1  5->0*: 0:f 1:e 2:c 3:d
4->1* 5->1 : 0:a 1:e 2:c 3:d
4->1  5->1*: 0:a 1:f 2:c 3:d
4->1* 5->2 : 0:a 1:e 2:f 3:d
4->1  5->2*: 0:a 1:e 2:f 3:d
4->1* 5->3 : 0:a 1:e 2:c 3:f
4->1  5->3*: 0:a 1:e 2:c 3:f
4->1* 5->4 : 0:a 1:f 2:c 3:d
4->1  5->4*: 0:a 1:f 2:c 3:d
4->1* 5->5 : 0:a 1:e 2:c 3:d 5:f
4->1  5->5*: 0:a 1:e 2:c 3:d 5:f
4->2* 0->0 : 0:a 1:b 2:e 3:d 5:f
4->2  0->0*: 0:a 1:b 2:e 3:d 5:f
4->2* 0->1 : 1:a 2:e 3:d 5:f
4->2  0->1*: 1:a 2:e 3:d 5:f
4->2* 0->2 : 1:b 2:e 3:d 5:f
4->2  0->2*: 1:b 2:a 3:d 5:f
4->2* 0->3 : 1:b 2:e 3:a 5:f
4->2  0->3*: 1:b 2:e 3:a 5:f
4->2* 0->4 : 1:b 2:a 3:d 5:f
4->2  0->4*: 1:b 2:a 3:d 5:f
4->2* 0->5 : 1:b 2:e 3:d 5:a
4->2  0->5*: 1:b 2:e 3:d 5:a
4->2* 1->0 : 0:b 2:e 3:d 5:f
4->2  1->0*: 0:b 2:e 3:d 5:f
4->2* 1->1 : 0:a 1:b 2:e 3:d 5:f
4->2  1->1*: 0:a 1:b 2:e 3:d 5:f
4->2* 1->2 : 0:a 2:e 3:d 5:f
4->2  1->2*: 0:a 2:b 3:d 5:f
4->2* 1->3 : 0:a 2:e 3:b 5:f
4->2  1->3*: 0:a 2:e 3:b 5:f
4->2* 1->4 : 0:a 2:b 3:d 5:f
4->2  1->4*: 0:a 2:b 3:d 5:f
4->2* 1->5 : 0:a 2:e 3:d 5:b
4->2  1->5*: 0:a 2:e 3:d 5:b
4->2* 2->0 : 0:e 1:b 3:d 5:f
4->2  2->0*: 0:e 1:b 3:d 5:f
4->2* 2->1 : 0:a 1:e 3:d 5:f
4->2  2->1*: 0:a 1:e 3:d 5:f
4->2* 2->2 : 0:a 1:b 2:e 3:d 5:f
4->2  2->2*: 0:a 1:b 2:e 3:d 5:f
4->2* 2->3 : 0:a 1:b 3:e 5:f
4->2  2->3*: 0:a 1:b 3:e 5:f
4->2* 2->4 : 0:a 1:b 3:d 5:f
4->2  2->4*: 0:a 1:b 3:d 5:f
4->2* 2->5 : 0:a 1:b 3:d 5:e
4->2  2->5*: 0:a 1:b 3:d 5:e
4->2* 3->0 : 0:d 1:b 2:e 5:f
4->2  3->0*: 0:d 1:b 2:e 5:f
4->2* 3->1 : 0:a 1:d 2:e 5:f
4->2  3->1*: 0:a 1:d 2:e 5:f
4->2* 3->2 : 0:a 1:b 2:e 5:f
4->2  3->2*: 0:a 1:b 2:d 5:f
4->2* 3->3 : 0:a 1:b 2:e 3:d 5:f
4->2  3->3*: 0:a 1:b 2:e 3:d 5:f
4->2* 3->4 : 0:a 1:b 2:d 5:f
4->2  3->4*: 0:a 1:b 2:d 5:f
4->2* 3->5 : 0:a 1:b 2:e 5:d
4->2  3->5*: 0:a 1:b 2:e 5:d
4->2* 4->0 : 1:b 2:e 3:d 5:f
4->2  4->0*: 0:e 1:b 3:d 5:f
4->2* 4->1 : 0:a 2:e 3:d 5:f
4->2  4->1*: 0:a 1:e 3:d 5:f
4->2* 4->2 : 0:a 1:b 2:e 3:d 5:f
4->2  4->2*: 0:a 1:b 2:e 3:d 5:f
4->2* 4->3 : 0:a 1:b 2:e 5:f
4->2  4->3*: 0:a 1:b 3:e 5:f
4->2* 4->4 : 0:a 1:b 2:e 3:d 5:f
4->2  4->4*: 0:a 1:b 2:e 3:d 5:f
4->2* 4->5 : 0:a 1:b 2:e 3:d
4->2  4->5*: 0:a 1:b 3:d 5:e
4->2* 5->0 : 0:f 1:b 2:e 3:d
4->2  5->0*: 0:f 1:b 2:e 3:d
4->2* 5->1 : 0:a 1:f 2:e 3:d
4->2  5->1*: 0:a 1:f 2:e 3:d
4->2* 5->2 : 0:a 1:b 2:e 3:d
4->2  5->2*: 0:a 1:b 2:f 3:d
4->2* 5->3 : 0:a 1:b 2:e 3:f
4->2  5->3*: 0:a 1:b 2:e 3:f
4->2* 5->4 : 0:a 1:b 2:f 3:d
4->2  5->4*: 0:a 1:b 2:f 3:d
4->2* 5->5 : 0:a 1:b 2:e 3:d 5:f
4->2  5->5*: 0:a 1:b 2:e 3:d 5:f
4->3* 0->0 : 0:a 1:b 2:c 3:e 5:f
4->3  0->0*: 0:a 1:b 2:c 3:e 5:f
4->3* 0->1 : 1:a 2:c 3:e 5:f
4->3  0->1*: 1:a 2:c 3:e 5:f
4->3* 0->2 : 1:b 2:a 3:e 5:f
4->3  0->2*: 1:b 2:a 3:e 5:f
4->3* 0->3 : 1:b 2:c 3:e 5:f
4->3  0->3*: 1:b 2:c 3:a 5:f
4->3* 0->4 : 1:b 2:c 3:a 5:f
4->3  0->4*: 1:b 2:c 3:a 5:f
4->3* 0->5 : 1:b 2:c 3:e 5:a
4->3  0->5*: 1:b 2:c 3:e 5:a
4->3* 1->0 : 0:b 2:c 3:e 5:f
4->3  1->0*: 0:b 2:c 3:e 5:f
4->3* 1->1 : 0:a 1:b 2:c 3:e 5:f
4->3  1->1*: 0:a 1:b 2:c 3:e 5:f
4->3* 1->2 : 0:a 2:b 3:e 5:f
4->3  1->2*: 0:a 2:b 3:e 5:f
4->3* 1->3 : 0:a 2:c 3:e 5:f
4->3  1->3*: 0:a 2:c 3:b 5:f
4->3* 1->4 : 0:a 2:c 3:b 5:f
4->3  1->4*: 0:a 2:c 3:b 5:f
4->3* 1->5 : 0:a 2:c 3:e 5:b
4->3  1->5*: 0:a 2:c 3:e 5:b
4->3* 2->0 : 0:c 1:b 3:e 5:f
4->3  2->0*: 0:c 1:b 3:e 5:f
4->3* 2->1 : 0:a 1:c 3:e 5:f
4->3  2->1*: 0:a 1:c 3:e 5:f
4->3* 2->2 : 0:a 1:b 2:c 3:e 5:f
4->3  2->2*: 0:a 1:b 2:c 3:e 5:f
4->3* 2->3 : 0:a 1:b 3:e 5:f
4->3  2->3*: 0:a 1:b 3:c 5:f
4->3* 2->4 : 0:a 1:b 3:c 5:f
4->3  2->4*: 0:a 1:b 3:c 5:f
4->3* 2->5 : 0:a 1:b 3:e 5:c
4->3  2->5*: 0:a 1:b 3:e 5:c
4->3* 3->0 : 0:e 1:b 2:c 5:f
4->3  3->0*: 0:e 1:b 2:c 5:f
4->3* 3->1 : 0:a 1:e 2:c 5:f
4->3  3->1*: 0:a 1:e 2:c 5:f
4->3* 3->2 : 0:a 1:b 2:e 5:f
4->3  3->2*: 0:a 1:b 2:e 5:f
4->3* 3->3 : 0:a 1:b 2:c 3:e 5:f
4->3  3->3*: 0:a 1:b 2:c 3:e 5:f
4->3* 3->4 : 0:a 1:b 2:c 5:f
4->3  3->4*: 0:a 1:b 2:c 5:f
4->3* 3->5 : 0:a 1:b 2:c 5:e
4->3  3->5*: 0:a 1:b 2:c 5:e
4->3* 4->0 : 1:b 2:c 3:e 5:f
4->3  4->0*: 0:e 1:b 2:c 5:f
4->3* 4->1 : 0:a 2:c 3:e 5:f
4->3  4->1*: 0:a 1:e 2:c 5:f
4->3* 4->2 : 0:a 1:b 3:e 5:f
4->3  4->2*: 0:a 1:b 2:e 5:f
4->3* 4->3 : 0:a 1:b 2:c 3:e 5:f
4->3  4->3*: 0:a 1:b 2:c 3:e 5:f
4->3* 4->4 : 0:a 1:b 2:c 3:e 5:f
4->3  4->4*: 0:a 1:b 2:c 3:e 5:f
4->3* 4->5 : 0:a 1:b 2:c 3:e
4->3  4->5*: 0:a 1:b 2:c 5:e
4->3* 5->0 : 0:f 1:b 2:c 3:e
4->3  5->0*: 0:f 1:b 2:c 3:e
4->3* 5->1 : 0:a 1:f 2:c 3:e
4->3  5->1*: 0:a 1:f 2:c 3:e
4->3* 5->2 : 0:a 1:b 2:f 3:e
4->3  5->2*: 0:a 1:b 2:f 3:e
4->3* 5->3 : 0:a 1:b 2:c 3:e
4->3  5->3*: 0:a 1:b 2:c 3:f
4->3* 5->4 : 0:a 1:b 2:c 3:f
4->3  5->4*: 0:a 1:b 2:c 3:f
4->3* 5->5 : 0:a 1:b 2:c 3:e 5:f
4->3  5->5*: 0:a 1:b 2:c 3:e 5:f
4->4* 0->0 : 0:a 1:b 2:c 3:d 4:e 5:f
4->4  0->0*: 0:a 1:b 2:c 3:d 4:e 5:f
4->4* 0->1 : 1:a 2:c 3:d 4:e 5:f
4->4  0->1*: 1:a 2:c 3:d 4:e 5:f
4->4* 0->2 : 1:b 2:a 3:d 4:e 5:f
4->4  0->2*: 1:b 2:a 3:d 4:e 5:f
4->4* 0->3 : 1:b 2:c 3:a 4:e 5:f
4->4  0->3*: 1:b 2:c 3:a 4:e 5:f
4->4* 0->4 : 1:b 2:c 3:d 4:a 5:f
4->4  0->4*: 1:b 2:c 3:d 4:a 5:f
4->4* 0->5 : 1:b 2:c 3:d 4:e 5:a
4->4  0->5*: 1:b 2:c 3:d 4:e 5:a
4->4* 1->0 : 0:b 2:c 3:d 4:e 5:f
4->4  1->0*: 0:b 2:c 3:d 4:e 5:f
4->4* 1->1 : 0:a 1:b 2:c 3:d 4:e 5:f
4->4  1->1*: 0:a 1:b 2:c 3:d 4:e 5:f
4->4* 1->2 : 0:a 2:b 3:d 4:e 5:f
4->4  1->2*: 0:a 2:b 3:d 4:e 5:f
4->4* 1->3 : 0:a 2:c 3:b 4:e 5:f
4->4  1->3*: 0:a 2:c 3:b 4:e 5:f
4->4* 1->4 : 0:a 2:c 3:d 4:b 5:f
4->4  1->4*: 0:a 2:c 3:d 4:b 5:f
4->4* 1->5 : 0:a 2:c 3:d 4:e 5:b
4->4  1->5*: 0:a 2:c 3:d 4:e 5:b
4->4* 2->0 : 0:c 1:b 3:d 4:e 5:f
4->4  2->0*: 0:c 1:b 3:d 4:e 5:f
4->4* 2->1 : 0:a 1:c 3:d 4:e 5:f
4->4  2->1*: 0:a 1:c 3:d 4:e 5:f
4->4* 2->2 : 0:a 1:b 2:c 3:d 4:e 5:f
4->4  2->2*: 0:a 1:b 2:c 3:d 4:e 5:f
4->4* 2->3 : 0:a 1:b 3:c 4:e 5:f
4->4  2->3*: 0:a 1:b 3:c 4:e 5:f
4->4* 2->4 : 0:a 1:b 3:d 4:c 5:f
4->4  2->4*: 0:a 1:b 3:d 4:c 5:f
4->4* 2->5 : 0:a 1:b 3:d 4:e 5:c
4->4  2->5*: 0:a 1:b 3:d 4:e 5:c
4->4* 3->0 : 0:d 1:b 2:c 4:e 5:f
4->4  3->0*: 0:d 1:b 2:c 4:e 5:f
4->4* 3->1 : 0:a 1:d 2:c 4:e 5:f
4->4  3->1*: 0:a 1:d 2:c 4:e 5:f
4->4* 3->2 : 0:a 1:b 2:d 4:e 5:f
4->4  3->2*: 0:a 1:b 2:d 4:e 5:f
4->4* 3->3 : 0:a 1:b 2:c 3:d 4:e 5:f
4->4  3->3*: 0:a 1:b 2:c 3:d 4:e 5:f
4->4* 3->4 : 0:a 1:b 2:c 4:d 5:f
4->4  3->4*: 0:a 1:b 2:c 4:d 5:f
4->4* 3->5 : 0:a 1:b 2:c 4:e 5:d
4->4  3->5*: 0:a 1:b 2:c 4:e 5:d
4->4* 4->0 : 0:e 1:b 2:c 3:d 5:f
4->4  4->0*: 0:e 1:b 2:c 3:d 5:f
4->4* 4->1 : 0:a 1:e 2:c 3:d 5:f
4->4  4->1*: 0:a 1:e 2:c 3:d 5:f
4->4* 4->2 : 0:a 1:b 2:e 3:d 5:f
4->4  4->2*: 0:a 1:b 2:e 3:d 5:f
4->4* 4->3 : 0:a 1:b 2:c 3:e 5:f
4->4  4->3*: 0:a 1:b 2:c 3:e 5:f
4->4* 4->4 : 0:a 1:b 2:c 3:d 4:e 5:f
4->4  4->4*: 0:a 1:b 2:c 3:d 4:e 5:f
4->4* 4->5 : 0:a 1:b 2:c 3:d 5:e
4->4  4->5*: 0:a 1:b 2:c 3:d 5:e
4->4* 5->0 : 0:f 1:b 2:c 3:d 4:e
4->4  5->0*: 0:f 1:b 2:c 3:d 4:e
4->4* 5->1 : 0:a 1:f 2:c 3:d 4:e
4->4  5->1*: 0:a 1:f 2:c 3:d 4:e
4->4* 5->2 : 0:a 1:b 2:f 3:d 4:e
4->4  5->2*: 0:a 1:b 2:f 3:d 4:e
4->4* 5->3 : 0:a 1:b 2:c 3:f 4:e
4->4  5->3*: 0:a 1:b 2:c 3:f 4:e
4->4* 5->4 : 0:a 1:b 2:c 3:d 4:f
4->4  5->4*: 0:a 1:b 2:c 3:d 4:f
4->4* 5->5 : 0:a 1:b 2:c 3:d 4:e 5:f
4->4  5->5*: 0:a 1:b 2:c 3:d 4:e 5:f
4->5* 0->0 : 0:a 1:b 2:c 3:d 5:e
4->5  0->0*: 0:a 1:b 2:c 3:d 5:e
4->5* 0->1 : 1:a 2:c 3:d 5:e
4->5  0->1*: 1:a 2:c 3:d 5:e
4->5* 0->2 : 1:b 2:a 3:d 5:e
4->5  0->2*: 1:b 2:a 3:d 5:e
4->5* 0->3 : 1:b 2:c 3:a 5:e
4->5  0->3*: 1:b 2:c 3:a 5:e
4->5* 0->4 : 1:b 2:c 3:d 5:a
4->5  0->4*: 1:b 2:c 3:d 5:a
4->5* 0->5 : 1:b 2:c 3:d 5:e
4->5  0->5*: 1:b 2:c 3:d 5:a
4->5* 1->0 : 0:b 2:c 3:d 5:e
4->5  1->0*: 0:b 2:c 3:d 5:e
4->5* 1->1 : 0:a 1:b 2:c 3:d 5:e
4->5  1->1*: 0:a 1:b 2:c 3:d 5:e
4->5* 1->2 : 0:a 2:b 3:d 5:e
4->5  1->2*: 0:a 2:b 3:d 5:e
4->5* 1->3 : 0:a 2:c 3:b 5:e
4->5  1->3*: 0:a 2:c 3:b 5:e
4->5* 1->4 : 0:a 2:c 3:d 5:b
4->5  1->4*: 0:a 2:c 3:d 5:b
4->5* 1->5 : 0:a 2:c 3:d 5:e
4->5  1->5*: 0:a 2:c 3:d 5:b
4->5* 2->0 : 0:c 1:b 3:d 5:e
4->5  2->0*: 0:c 1:b 3:d 5:e
4->5* 2->1 : 0:a 1:c 3:d 5:e
4->5  2->1*: 0:a 1:c 3:d 5:e
4->5* 2->2 : 0:a 1:b 2:c 3:d 5:e
4->5  2->2*: 0:a 1:b 2:c 3:d 5:e
4->5* 2->3 : 0:a 1:b 3:c 5:e
4->5  2->3*: 0:a 1:b 3:c 5:e
4->5* 2->4 : 0:a 1:b 3:d 5:c
4->5  2->4*: 0:a 1:b 3:d 5:c
4->5* 2->5 : 0:a 1:b 3:d 5:e
4->5  2->5*: 0:a 1:b 3:d 5:c
4->5* 3->0 : 0:d 1:b 2:c 5:e
4->5  3->0*: 0:d 1:b 2:c 5:e
4->5* 3->1 : 0:a 1:d 2:c 5:e
4->5  3->1*: 0:a 1:d 2:c 5:e
4->5* 3->2 : 0:a 1:b 2:d 5:e
4->5  3->2*: 0:a 1:b 2:d 5:e
4->5* 3->3 : 0:a 1:b 2:c 3:d 5:e
4->5  3->3*: 0:a 1:b 2:c 3:d 5:e
4->5* 3->4 : 0:a 1:b 2:c 5:d
4->5  3->4*: 0:a 1:b 2:c 5:d
4->5* 3->5 : 0:a 1:b 2:c 5:e
4->5  3->5*: 0:a 1:b 2:c 5:d
4->5* 4->0 : 1:b 2:c 3:d 5:e
4->5  4->0*: 0:e 1:b 2:c 3:d
4->5* 4->1 : 0:a 2:c 3:d 5:e
4->5  4->1*: 0:a 1:e 2:c 3:d
4->5* 4->2 : 0:a 1:b 3:d 5:e
4->5  4->2*: 0:a 1:b 2:e 3:d
4->5* 4->3 : 0:a 1:b 2:c 5:e
4->5  4->3*: 0:a 1:b 2:c 3:e
4->5* 4->4 : 0:a 1:b 2:c 3:d 5:e
4->5  4->4*: 0:a 1:b 2:c 3:d 5:e
4->5* 4->5 : 0:a 1:b 2:c 3:d 5:e
4->5  4->5*: 0:a 1:b 2:c 3:d 5:e
4->5* 5->0 : 0:e 1:b 2:c 3:d
4->5  5->0*: 0:e 1:b 2:c 3:d
4->5* 5->1 : 0:a 1:e 2:c 3:d
4->5  5->1*: 0:a 1:e 2:c 3:d
4->5* 5->2 : 0:a 1:b 2:e 3:d
4->5  5->2*: 0:a 1:b 2:e 3:d
4->5* 5->3 : 0:a 1:b 2:c 3:e
4->5  5->3*: 0:a 1:b 2:c 3:e
4->5* 5->4 : 0:a 1:b 2:c 3:d
4->5  5->4*: 0:a 1:b 2:c 3:d
4->5* 5->5 : 0:a 1:b 2:c 3:d 5:e
4->5  5->5*: 0:a 1:b 2:c 3:d 5:e
5->0* 0->0 : 0:f 1:b 2:c 3:d 4:e
5->0  0->0*: 0:f 1:b 2:c 3:d 4:e
5->0* 0->1 : 1:f 2:c 3:d 4:e
5->0  0->1*: 1:f 2:c 3:d 4:e
5->0* 0->2 : 1:b 2:f 3:d 4:e
5->0  0->2*: 1:b 2:f 3:d 4:e
5->0* 0->3 : 1:b 2:c 3:f 4:e
5->0  0->3*: 1:b 2:c 3:f 4:e
5->0* 0->4 : 1:b 2:c 3:d 4:f
5->0  0->4*: 1:b 2:c 3:d 4:f
5->0* 0->5 : 1:b 2:c 3:d 4:e
5->0  0->5*: 1:b 2:c 3:d 4:e
5->0* 1->0 : 0:f 2:c 3:d 4:e
5->0  1->0*: 0:b 2:c 3:d 4:e
5->0* 1->1 : 0:f 1:b 2:c 3:d 4:e
5->0  1->1*: 0:f 1:b 2:c 3:d 4:e
5->0* 1->2 : 0:f 2:b 3:d 4:e
5->0  1->2*: 0:f 2:b 3:d 4:e
5->0* 1->3 : 0:f 2:c 3:b 4:e
5->0  1->3*: 0:f 2:c 3:b 4:e
5->0* 1->4 : 0:f 2:c 3:d 4:b
5->0  1->4*: 0:f 2:c 3:d 4:b
5->0* 1->5 : 0:b 2:c 3:d 4:e
5->0  1->5*: 0:b 2:c 3:d 4:e
5->0* 2->0 : 0:f 1:b 3:d 4:e
5->0  2->0*: 0:c 1:b 3:d 4:e
5->0* 2->1 : 0:f 1:c 3:d 4:e
5->0  2->1*: 0:f 1:c 3:d 4:e
5->0* 2->2 : 0:f 1:b 2:c 3:d 4:e
5->0  2->2*: 0:f 1:b 2:c 3:d 4:e
5->0* 2->3 : 0:f 1:b 3:c 4:e
5->0  2->3*: 0:f 1:b 3:c 4:e
5->0* 2->4 : 0:f 1:b 3:d 4:c
5->0  2->4*: 0:f 1:b 3:d 4:c
5->0* 2->5 : 0:c 1:b 3:d 4:e
5->0  2->5*: 0:c 1:b 3:d 4:e
5->0* 3->0 : 0:f 1:b 2:c 4:e
5->0  3->0*: 0:d 1:b 2:c 4:e
5->0* 3->1 : 0:f 1:d 2:c 4:e
5->0  3->1*: 0:f 1:d 2:c 4:e
5->0* 3->2 : 0:f 1:b 2:d 4:e
5->0  3->2*: 0:f 1:b 2:d 4:e
5->0* 3->3 : 0:f 1:b 2:c 3:d 4:e
5->0  3->3*: 0:f 1:b 2:c 3:d 4:e
5->0* 3->4 : 0:f 1:b 2:c 4:d
5->0  3->4*: 0:f 1:b 2:c 4:d
5->0* 3->5 : 0:d 1:b 2:c 4:e
5->0  3->5*: 0:d 1:b 2:c 4:e
5->0* 4->0 : 0:f 1:b 2:c 3:d
5->0  4->0*: 0:e 1:b 2:c 3:d
5->0* 4->1 : 0:f 1:e 2:c 3:d
5->0  4->1*: 0:f 1:e 2:c 3:d
5->0* 4->2 : 0:f 1:b 2:e 3:d
5->0  4->2*: 0:f 1:b 2:e 3:d
5->0* 4->3 : 0:f 1:b 2:c 3:e
5->0  4->3*: 0:f 1:b 2:c 3:e
5->0* 4->4 : 0:f 1:b 2:c 3:d 4:e
5->0  4->4*: 0:f 1:b 2:c 3:d 4:e
5->0* 4->5 : 0:e 1:b 2:c 3:d
5->0  4->5*: 0:e 1:b 2:c 3:d
5->0* 5->0 : 0:f 1:b 2:c 3:d 4:e
5->0  5->0*: 0:f 1:b 2:c 3:d 4:e
5->0* 5->1 : 0:f 2:c 3:d 4:e
5->0  5->1*: 1:f 2:c 3:d 4:e
5->0* 5->2 : 0:f 1:b 3:d 4:e
5->0  5->2*: 1:b 2:f 3:d 4:e
5->0* 5->3 : 0:f 1:b 2:c 4:e
5->0  5->3*: 1:b 2:c 3:f 4:e
5->0* 5->4 : 0:f 1:b 2:c 3:d
5->0  5->4*: 1:b 2:c 3:d 4:f
5->0* 5->5 : 0:f 1:b 2:c 3:d 4:e
5->0  5->5*: 0:f 1:b 2:c 3:d 4:e
5->1* 0->0 : 0:a 1:f 2:c 3:d 4:e
5->1  0->0*: 0:a 1:f 2:c 3:d 4:e
5->1* 0->1 : 1:f 2:c 3:d 4:e
5->1  0->1*: 1:a 2:c 3:d 4:e
5->1* 0->2 : 1:f 2:a 3:d 4:e
5->1  0->2*: 1:f 2:a 3:d 4:e
5->1* 0->3 : 1:f 2:c 3:a 4:e
5->1  0->3*: 1:f 2:c 3:a 4:e
5->1* 0->4 : 1:f 2:c 3:d 4:a
5->1  0->4*: 1:f 2:c 3:d 4:a
5->1* 0->5 : 1:a 2:c 3:d 4:e
5->1  0->5*: 1:a 2:c 3:d 4:e
5->1* 1->0 : 0:f 2:c 3:d 4:e
5->1  1->0*: 0:f 2:c 3:d 4:e
5->1* 1->1 : 0:a 1:f 2:c 3:d 4:e
5->1  1->1*: 0:a 1:f 2:c 3:d 4:e
5->1* 1->2 : 0:a 2:f 3:d 4:e
5->1  1->2*: 0:a 2:f 3:d 4:e
5->1* 1->3 : 0:a 2:c 3:f 4:e
5->1  1->3*: 0:a 2:c 3:f 4:e
5->1* 1->4 : 0:a 2:c 3:d 4:f
5->1  1->4*: 0:a 2:c 3:d 4:f
5->1* 1->5 : 0:a 2:c 3:d 4:e
5->1  1->5*: 0:a 2:c 3:d 4:e
5->1* 2->0 : 0:c 1:f 3:d 4:e
5->1  2->0*: 0:c 1:f 3:d 4:e
5->1* 2->1 : 0:a 1:f 3:d 4:e
5->1  2->1*: 0:a 1:c 3:d 4:e
5->1* 2->2 : 0:a 1:f 2:c 3:d 4:e
5->1  2->2*: 0:a 1:f 2:c 3:d 4:e
5->1* 2->3 : 0:a 1:f 3:c 4:e
5->1  2->3*: 0:a 1:f 3:c 4:e
5->1* 2->4 : 0:a 1:f 3:d 4:c
5->1  2->4*: 0:a 1:f 3:d 4:c
5->1* 2->5 : 0:a 1:c 3:d 4:e
5->1  2->5*: 0:a 1:c 3:d 4:e
5->1* 3->0 : 0:d 1:f 2:c 4:e
5->1  3->0*: 0:d 1:f 2:c 4:e
5->1* 3->1 : 0:a 1:f 2:c 4:e
5->1  3->1*: 0:a 1:d 2:c 4:e
5->1* 3->2 : 0:a 1:f 2:d 4:e
5->1  3->2*: 0:a 1:f 2:d 4:e
5->1* 3->3 : 0:a 1:f 2:c 3:d 4:e
5->1  3->3*: 0:a 1:f 2:c 3:d 4:e
5->1* 3->4 : 0:a 1:f 2:c 4:d
5->1  3->4*: 0:a 1:f 2:c 4:d
5->1* 3->5 : 0:a 1:d 2:c 4:e
5->1  3->5*: 0:a 1:d 2:c 4:e
5->1* 4->0 : 0:e 1:f 2:c 3:d
5->1  4->0*: 0:e 1:f 2:c 3:d
5->1* 4->1 : 0:a 1:f 2:c 3:d
5->1  4->1*: 0:a 1:e 2:c 3:d
5->1* 4->2 : 0:a 1:f 2:e 3:d
5->1  4->2*: 0:a 1:f 2:e 3:d
5->1* 4->3 : 0:a 1:f 2:c 3:e
5->1  4->3*: 0:a 1:f 2:c 3:e
5->1* 4->4 : 0:a 1:f 2:c 3:d 4:e
5->1  4->4*: 0:a 1:f 2:c 3:d 4:e
5->1* 4->5 : 0:a 1:e 2:c 3:d
5->1  4->5*: 0:a 1:e 2:c 3:d
5->1* 5->0 : 1:f 2:c 3:d 4:e
5->1  5->0*: 0:f 2:c 3:d 4:e
5->1* 5->1 : 0:a 1:f 2:c 3:d 4:e
5->1  5->1*: 0:a 1:f 2:c 3:d 4:e
5->1* 5->2 : 0:a 1:f 3:d 4:e
5->1  5->2*: 0:a 2:f 3:d 4:e
5->1* 5->3 : 0:a 1:f 2:c 4:e
5->1  5->3*: 0:a 2:c 3:f 4:e
5->1* 5->4 : 0:a 1:f 2:c 3:d
5->1  5->4*: 0:a 2:c 3:d 4:f
5->1* 5->5 : 0:a 1:f 2:c 3:d 4:e
5->1  5->5*: 0:a 1:f 2:c 3:d 4:e
5->2* 0->0 : 0:a 1:b 2:f 3:d 4:e
5->2  0->0*: 0:a 1:b 2:f 3:d 4:e
5->2* 0->1 : 1:a 2:f 3:d 4:e
5->2  0->1*: 1:a 2:f 3:d 4:e
5->2* 0->2 : 1:b 2:f 3:d 4:e
5->2  0->2*: 1:b 2:a 3:d 4:e
5->2* 0->3 : 1:b 2:f 3:a 4:e
5->2  0->3*: 1:b 2:f 3:a 4:e
5->2* 0->4 : 1:b 2:f 3:d 4:a
5->2  0->4*: 1:b 2:f 3:d 4:a
5->2* 0->5 : 1:b 2:a 3:d 4:e
5->2  0->5*: 1:b 2:a 3:d 4:e
5->2* 1->0 : 0:b 2:f 3:d 4:e
5->2  1->0*: 0:b 2:f 3:d 4:e
5->2* 1->1 : 0:a 1:b 2:f 3:d 4:e
5->2  1->1*: 0:a 1:b 2:f 3:d 4:e
5->2* 1->2 : 0:a 2:f 3:d 4:e
5->2  1->2*: 0:a 2:b 3:d 4:e
5->2* 1->3 : 0:a 2:f 3:b 4:e
5->2  1->3*: 0:a 2:f 3:b 4:e
5->2* 1->4 : 0:a 2:f 3:d 4:b
5->2  1->4*: 0:a 2:f 3:d 4:b
5->2* 1->5 : 0:a 2:b 3:d 4:e
5->2  1->5*: 0:a 2:b 3:d 4:e
5->2* 2->0 : 0:f 1:b 3:d 4:e
5->2  2->0*: 0:f 1:b 3:d 4:e
5->2* 2->1 : 0:a 1:f 3:d 4:e
5->2  2->1*: 0:a 1:f 3:d 4:e
5->2* 2->2 : 0:a 1:b 2:f 3:d 4:e
5->2  2->2*: 0:a 1:b 2:f 3:d 4:e
5->2* 2->3 : 0:a 1:b 3:f 4:e
5->2  2->3*: 0:a 1:b 3:f 4:e
5->2* 2->4 : 0:a 1:b 3:d 4:f
5->2  2->4*: 0:a 1:b 3:d 4:f
5->2* 2->5 : 0:a 1:b 3:d 4:e
5->2  2->5*: 0:a 1:b 3:d 4:e
5->2* 3->0 : 0:d 1:b 2:f 4:e
5->2  3->0*: 0:d 1:b 2:f 4:e
5->2* 3->1 : 0:a 1:d 2:f 4:e
5->2  3->1*: 0:a 1:d 2:f 4:e
5->2* 3->2 : 0:a 1:b 2:f 4:e
5->2  3->2*: 0:a 1:b 2:d 4:e
5->2* 3->3 : 0:a 1:b 2:f 3:d 4:e
5->2  3->3*: 0:a 1:b 2:f 3:d 4:e
5->2* 3->4 : 0:a 1:b 2:f 4:d
5->2  3->4*: 0:a 1:b 2:f 4:d
5->2* 3->5 : 0:a 1:b 2:d 4:e
5->2  3->5*: 0:a 1:b 2:d 4:e
5->2* 4->0 : 0:e 1:b 2:f 3:d
5->2  4->0*: 0:e 1:b 2:f 3:d
5->2* 4->1 : 0:a 1:e 2:f 3:d
5->2  4->1*: 0:a 1:e 2:f 3:d
5->2* 4->2 : 0:a 1:b 2:f 3:d
5->2  4->2*: 0:a 1:b 2:e 3:d
5->2* 4->3 : 0:a 1:b 2:f 3:e
5->2  4->3*: 0:a 1:b 2:f 3:e
5->2* 4->4 : 0:a 1:b 2:f 3:d 4:e
5->2  4->4*: 0:a 1:b 2:f 3:d 4:e
5->2* 4->5 : 0:a 1:b 2:e 3:d
5->2  4->5*: 0:a 1:b 2:e 3:d
5->2* 5->0 : 1:b 2:f 3:d 4:e
5->2  5->0*: 0:f 1:b 3:d 4:e
5->2* 5->1 : 0:a 2:f 3:d 4:e
5->2  5->1*: 0:a 1:f 3:d 4:e
5->2* 5->2 : 0:a 1:b 2:f 3:d 4:e
5->2  5->2*: 0:a 1:b 2:f 3:d 4:e
5->2* 5->3 : 0:a 1:b 2:f 4:e
5->2  5->3*: 0:a 1:b 3:f 4:e
5->2* 5->4 : 0:a 1:b 2:f 3:d
5->2  5->4*: 0:a 1:b 3:d 4:f
5->2* 5->5 : 0:a 1:b 2:f 3:d 4:e
5->2  5->5*: 0:a 1:b 2:f 3:d 4:e
5->3* 0->0 : 0:a 1:b 2:c 3:f 4:e
5->3  0->0*: 0:a 1:b 2:c 3:f 4:e
5->3* 0->1 : 1:a 2:c 3:f 4:e
5->3  0->1*: 1:a 2:c 3:f 4:e
5->3* 0->2 : 1:b 2:a 3:f 4:e
5->3  0->2*: 1:b 2:a 3:f 4:e
5->3* 0->3 : 1:b 2:c 3:f 4:e
5->3  0->3*: 1:b 2:c 3:a 4:e
5->3* 0->4 : 1:b 2:c 3:f 4:a
5->3  0->4*: 1:b 2:c 3:f 4:a
5->3* 0->5 : 1:b 2:c 3:a 4:e
5->3  0->5*: 1:b 2:c 3:a 4:e
5->3* 1->0 : 0:b 2:c 3:f 4:e
5->3  1->0*: 0:b 2:c 3:f 4:e
5->3* 1->1 : 0:a 1:b 2:c 3:f 4:e
5->3  1->1*: 0:a 1:b 2:c 3:f 4:e
5->3* 1->2 : 0:a 2:b 3:f 4:e
5->3  1->2*: 0:a 2:b 3:f 4:e
5->3* 1->3 : 0:a 2:c 3:f 4:e
5->3  1->3*: 0:a 2:c 3:b 4:e
5->3* 1->4 : 0:a 2:c 3:f 4:b
5->3  1->4*: 0:a 2:c 3:f 4:b
5->3* 1->5 : 0:a 2:c 3:b 4:e
5->3  1->5*: 0:a 2:c 3:b 4:e
5->3* 2->0 : 0:c 1:b 3:f 4:e
5->3  2->0*: 0:c 1:b 3:f 4:e
5->3* 2->1 : 0:a 1:c 3:f 4:e
5->3  2->1*: 0:a 1:c 3:f 4:e
5->3* 2->2 : 0:a 1:b 2:c 3:f 4:e
5->3  2->2*: 0:a 1:b 2:c 3:f 4:e
5->3* 2->3 : 0:a 1:b 3:f 4:e
5->3  2->3*: 0:a 1:b 3:c 4:e
5->3* 2->4 : 0:a 1:b 3:f 4:c
5->3  2->4*: 0:a 1:b 3:f 4:c
5->3* 2->5 : 0:a 1:b 3:c 4:e
5->3  2->5*: 0:a 1:b 3:c 4:e
5->3* 3->0 : 0:f 1:b 2:c 4:e
5->3  3->0*: 0:f 1:b 2:c 4:e
5->3* 3->1 : 0:a 1:f 2:c 4:e
5->3  3->1*: 0:a 1:f 2:c 4:e
5->3* 3->2 : 0:a 1:b 2:f 4:e
5->3  3->2*: 0:a 1:b 2:f 4:e
5->3* 3->3 : 0:a 1:b 2:c 3:f 4:e
5->3  3->3*: 0:a 1:b 2:c 3:f 4:e
5->3* 3->4 : 0:a 1:b 2:c 4:f
5->3  3->4*: 0:a 1:b 2:c 4:f
5->3* 3->5 : 0:a 1:b 2:c 4:e
5->3  3->5*: 0:a 1:b 2:c 4:e
5->3* 4->0 : 0:e 1:b 2:c 3:f
5->3  4->0*: 0:e 1:b 2:c 3:f
5->3* 4->1 : 0:a 1:e 2:c 3:f
5->3  4->1*: 0:a 1:e 2:c 3:f
5->3* 4->2 : 0:a 1:b 2:e 3:f
5->3  4->2*: 0:a 1:b 2:e 3:f
5->3* 4->3 : 0:a 1:b 2:c 3:f
5->3  4->3*: 0:a 1:b 2:c 3:e
5->3* 4->4 : 0:a 1:b 2:c 3:f 4:e
5->3  4->4*: 0:a 1:b 2:c 3:f 4:e
5->3* 4->5 : 0:a 1:b 2:c 3:e
5->3  4->5*: 0:a 1:b 2:c 3:e
5->3* 5->0 : 1:b 2:c 3:f 4:e
5->3  5->0*: 0:f 1:b 2:c 4:e
5->3* 5->1 : 0:a 2:c 3:f 4:e
5->3  5->1*: 0:a 1:f 2:c 4:e
5->3* 5->2 : 0:a 1:b 3:f 4:e
5->3  5->2*: 0:a 1:b 2:f 4:e
5->3* 5->3 : 0:a 1:b 2:c 3:f 4:e
5->3  5->3*: 0:a 1:b 2:c 3:f 4:e
5->3* 5->4 : 0:a 1:b 2:c 3:f
5->3  5->4*: 0:a 1:b 2:c 4:f
5->3* 5->5 : 0:a 1:b 2:c 3:f 4:e
5->3  5->5*: 0:a 1:b 2:c 3:f 4:e
5->4* 0->0 : 0:a 1:b 2:c 3:d 4:f
5->4  0->0*: 0:a 1:b 2:c 3:d 4:f
5->4* 0->1 : 1:a 2:c 3:d 4:f
5->4  0->1*: 1:a 2:c 3:d 4:f
5->4* 0->2 : 1:b 2:a 3:d 4:f
5->4  0->2*: 1:b 2:a 3:d 4:f
5->4* 0->3 : 1:b 2:c 3:a 4:f
5->4  0->3*: 1:b 2:c 3:a 4:f
5->4* 0->4 : 1:b 2:c 3:d 4:f
5->4  0->4*: 1:b 2:c 3:d 4:a
5->4* 0->5 : 1:b 2:c 3:d 4:a
5->4  0->5*: 1:b 2:c 3:d 4:a
5->4* 1->0 : 0:b 2:c 3:d 4:f
5->4  1->0*: 0:b 2:c 3:d 4:f
5->4* 1->1 : 0:a 1:b 2:c 3:d 4:f
5->4  1->1*: 0:a 1:b 2:c 3:d 4:f
5->4* 1->2 : 0:a 2:b 3:d 4:f
5->4  1->2*: 0:a 2:b 3:d 4:f
5->4* 1->3 : 0:a 2:c 3:b 4:f
5->4  1->3*: 0:a 2:c 3:b 4:f
5->4* 1->4 : 0:a 2:c 3:d 4:f
5->4  1->4*: 0:a 2:c 3:d 4:b
5->4* 1->5 : 0:a 2:c 3:d 4:b
5->4  1->5*: 0:a 2:c 3:d 4:b
5->4* 2->0 : 0:c 1:b 3:d 4:f
5->4  2->0*: 0:c 1:b 3:d 4:f
5->4* 2->1 : 0:a 1:c 3:d 4:f
5->4  2->1*: 0:a 1:c 3:d 4:f
5->4* 2->2 : 0:a 1:b 2:c 3:d 4:f
5->4  2->2*: 0:a 1:b 2:c 3:d 4:f
5->4* 2->3 : 0:a 1:b 3:c 4:f
5->4  2->3*: 0:a 1:b 3:c 4:f
5->4* 2->4 : 0:a 1:b 3:d 4:f
5->4  2->4*: 0:a 1:b 3:d 4:c
5->4* 2->5 : 0:a 1:b 3:d 4:c
5->4  2->5*: 0:a 1:b 3:d 4:c
5->4* 3->0 : 0:d 1:b 2:c 4:f
5->4  3->0*: 0:d 1:b 2:c 4:f
5->4* 3->1 : 0:a 1:d 2:c 4:f
5->4  3->1*: 0:a 1:d 2:c 4:f
5->4* 3->2 : 0:a 1:b 2:d 4:f
5->4  3->2*: 0:a 1:b 2:d 4:f
5->4* 3->3 : 0:a 1:b 2:c 3:d 4:f
5->4  3->3*: 0:a 1:b 2:c 3:d 4:f
5->4* 3->4 : 0:a 1:b 2:c 4:f
5->4  3->4*: 0:a 1:b 2:c 4:d
5->4* 3->5 : 0:a 1:b 2:c 4:d
5->4  3->5*: 0:a 1:b 2:c 4:d
5->4* 4->0 : 0:f 1:b 2:c 3:d
5->4  4->0*: 0:f 1:b 2:c 3:d
5->4* 4->1 : 0:a 1:f 2:c 3:d
5->4  4->1*: 0:a 1:f 2:c 3:d
5->4* 4->2 : 0:a 1:b 2:f 3:d
5->4  4->2*: 0:a 1:b 2:f 3:d
5->4* 4->3 : 0:a 1:b 2:c 3:f
5->4  4->3*: 0:a 1:b 2:c 3:f
5->4* 4->4 : 0:a 1:b 2:c 3:d 4:f
5->4  4->4*: 0:a 1:b 2:c 3:d 4:f
5->4* 4->5 : 0:a 1:b 2:c 3:d
5->4  4->5*: 0:a 1:b 2:c 3:d
5->4* 5->0 : 1:b 2:c 3:d 4:f
5->4  5->0*: 0:f 1:b 2:c 3:d
5->4* 5->1 : 0:a 2:c 3:d 4:f
5->4  5->1*: 0:a 1:f 2:c 3:d
5->4* 5->2 : 0:a 1:b 3:d 4:f
5->4  5->2*: 0:a 1:b 2:f 3:d
5->4* 5->3 : 0:a 1:b 2:c 4:f
5->4  5->3*: 0:a 1:b 2:c 3:f
5->4* 5->4 : 0:a 1:b 2:c 3:d 4:f
5->4  5->4*: 0:a 1:b 2:c 3:d 4:f
5->4* 5->5 : 0:a 1:b 2:c 3:d 4:f
5->4  5->5*: 0:a 1:b 2:c 3:d 4:f
5->5* 0->0 : 0:a 1:b 2:c 3:d 4:e 5:f
5->5  0->0*: 0:a 1:b 2:c 3:d 4:e 5:f
5->5* 0->1 : 1:a 2:c 3:d 4:e 5:f
5->5  0->1*: 1:a 2:c 3:d 4:e 5:f
5->5* 0->2 : 1:b 2:a 3:d 4:e 5:f
5->5  0->2*: 1:b 2:a 3:d 4:e 5:f
5->5* 0->3 : 1:b 2:c 3:a 4:e 5:f
5->5  0->3*: 1:b 2:c 3:a 4:e 5:f
5->5* 0->4 : 1:b 2:c 3:d 4:a 5:f
5->5  0->4*: 1:b 2:c 3:d 4:a 5:f
5->5* 0->5 : 1:b 2:c 3:d 4:e 5:a
5->5  0->5*: 1:b 2:c 3:d 4:e 5:a
5->5* 1->0 : 0:b 2:c 3:d 4:e 5:f
5->5  1->0*: 0:b 2:c 3:d 4:e 5:f
5->5* 1->1 : 0:a 1:b 2:c 3:d 4:e 5:f
5->5  1->1*: 0:a 1:b 2:c 3:d 4:e 5:f
5->5* 1->2 : 0:a 2:b 3:d 4:e 5:f
5->5  1->2*: 0:a 2:b 3:d 4:e 5:f
5->5* 1->3 : 0:a 2:c 3:b 4:e 5:f
5->5  1->3*: 0:a 2:c 3:b 4:e 5:f
5->5* 1->4 : 0:a 2:c 3:d 4:b 5:f
5->5  1->4*: 0:a 2:c 3:d 4:b 5:f
5->5* 1->5 : 0:a 2:c 3:d 4:e 5:b
5->5  1->5*: 0:a 2:c 3:d 4:e 5:b
5->5* 2->0 : 0:c 1:b 3:d 4:e 5:f
5->5  2->0*: 0:c 1:b 3:d 4:e 5:f
5->5* 2->1 : 0:a 1:c 3:d 4:e 5:f
5->5  2->1*: 0:a 1:c 3:d 4:e 5:f
5->5* 2->2 : 0:a 1:b 2:c 3:d 4:e 5:f
5->5  2->2*: 0:a 1:b 2:c 3:d 4:e 5:f
5->5* 2->3 : 0:a 1:b 3:c 4:e 5:f
5->5  2->3*: 0:a 1:b 3:c 4:e 5:f
5->5* 2->4 : 0:a 1:b 3:d 4:c 5:f
5->5  2->4*: 0:a 1:b 3:d 4:c 5:f
5->5* 2->5 : 0:a 1:b 3:d 4:e 5:c
5->5  2->5*: 0:a 1:b 3:d 4:e 5:c
5->5* 3->0 : 0:d 1:b 2:c 4:e 5:f
5->5  3->0*: 0:d 1:b 2:c 4:e 5:f
5->5* 3->1 : 0:a 1:d 2:c 4:e 5:f
5->5  3->1*: 0:a 1:d 2:c 4:e 5:f
5->5* 3->2 : 0:a 1:b 2:d 4:e 5:f
5->5  3->2*: 0:a 1:b 2:d 4:e 5:f
5->5* 3->3 : 0:a 1:b 2:c 3:d 4:e 5:f
5->5  3->3*: 0:a 1:b 2:c 3:d 4:e 5:f
5->5* 3->4 : 0:a 1:b 2:c 4:d 5:f
5->5  3->4*: 0:a 1:b 2:c 4:d 5:f
5->5* 3->5 : 0:a 1:b 2:c 4:e 5:d
5->5  3->5*: 0:a 1:b 2:c 4:e 5:d
5->5* 4->0 : 0:e 1:b 2:c 3:d 5:f
5->5  4->0*: 0:e 1:b 2:c 3:d 5:f
5->5* 4->1 : 0:a 1:e 2:c 3:d 5:f
5->5  4->1*: 0:a 1:e 2:c 3:d 5:f
5->5* 4->2 : 0:a 1:b 2:e 3:d 5:f
5->5  4->2*: 0:a 1:b 2:e 3:d 5:f
5->5* 4->3 : 0:a 1:b 2:c 3:e 5:f
5->5  4->3*: 0:a 1:b 2:c 3:e 5:f
5->5* 4->4 : 0:a 1:b 2:c 3:d 4:e 5:f
5->5  4->4*: 0:a 1:b 2:c 3:d 4:e 5:f
5->5* 4->5 : 0:a 1:b 2:c 3:d 5:e
5->5  4->5*: 0:a 1:b 2:c 3:d 5:e
5->5* 5->0 : 0:f 1:b 2:c 3:d 4:e
5->5  5->0*: 0:f 1:b 2:c 3:d 4:e
5->5* 5->1 : 0:a 1:f 2:c 3:d 4:e
5->5  5->1*: 0:a 1:f 2:c 3:d 4:e
5->5* 5->2 : 0:a 1:b 2:f 3:d 4:e
5->5  5->2*: 0:a 1:b 2:f 3:d 4:e
5->5* 5->3 : 0:a 1:b 2:c 3:f 4:e
5->5  5->3*: 0:a 1:b 2:c 3:f 4:e
5->5* 5->4 : 0:a 1:b 2:c 3:d 4:f
5->5  5->4*: 0:a 1:b 2:c 3:d 4:f
5->5* 5->5 : 0:a 1:b 2:c 3:d 4:e 5:f
5->5  5->5*: 0:a 1:b 2:c 3:d 4:e 5:f''';

const expectedTestTransformMoveEdit = '''
edit0* 0->0 : X b c d e f g
edit0  0->0*: X b c d e f g
0->0* edit0 : X b c d e f g
0->0  edit0*: X b c d e f g
edit1* 0->0 : a X c d e f g
edit1  0->0*: a X c d e f g
0->0* edit1 : a X c d e f g
0->0  edit1*: a X c d e f g
edit2* 0->0 : a b X d e f g
edit2  0->0*: a b X d e f g
0->0* edit2 : a b X d e f g
0->0  edit2*: a b X d e f g
edit3* 0->0 : a b c X e f g
edit3  0->0*: a b c X e f g
0->0* edit3 : a b c X e f g
0->0  edit3*: a b c X e f g
edit4* 0->0 : a b c d X f g
edit4  0->0*: a b c d X f g
0->0* edit4 : a b c d X f g
0->0  edit4*: a b c d X f g
edit5* 0->0 : a b c d e X g
edit5  0->0*: a b c d e X g
0->0* edit5 : a b c d e X g
0->0  edit5*: a b c d e X g
edit6* 0->0 : a b c d e f X
edit6  0->0*: a b c d e f X
0->0* edit6 : a b c d e f X
0->0  edit6*: a b c d e f X
edit0* 0->1 : X b c d e f g
edit0  0->1*: X b c d e f g
0->1* edit0 : X b c d e f g
0->1  edit0*: X b c d e f g
edit1* 0->1 : a X c d e f g
edit1  0->1*: a X c d e f g
0->1* edit1 : a X c d e f g
0->1  edit1*: a X c d e f g
edit2* 0->1 : a b X d e f g
edit2  0->1*: a b X d e f g
0->1* edit2 : a b X d e f g
0->1  edit2*: a b X d e f g
edit3* 0->1 : a b c X e f g
edit3  0->1*: a b c X e f g
0->1* edit3 : a b c X e f g
0->1  edit3*: a b c X e f g
edit4* 0->1 : a b c d X f g
edit4  0->1*: a b c d X f g
0->1* edit4 : a b c d X f g
0->1  edit4*: a b c d X f g
edit5* 0->1 : a b c d e X g
edit5  0->1*: a b c d e X g
0->1* edit5 : a b c d e X g
0->1  edit5*: a b c d e X g
edit6* 0->1 : a b c d e f X
edit6  0->1*: a b c d e f X
0->1* edit6 : a b c d e f X
0->1  edit6*: a b c d e f X
edit0* 0->2 : b X c d e f g
edit0  0->2*: b X c d e f g
0->2* edit0 : b X c d e f g
0->2  edit0*: b X c d e f g
edit1* 0->2 : X a c d e f g
edit1  0->2*: X a c d e f g
0->2* edit1 : X a c d e f g
0->2  edit1*: X a c d e f g
edit2* 0->2 : b a X d e f g
edit2  0->2*: b a X d e f g
0->2* edit2 : b a X d e f g
0->2  edit2*: b a X d e f g
edit3* 0->2 : b a c X e f g
edit3  0->2*: b a c X e f g
0->2* edit3 : b a c X e f g
0->2  edit3*: b a c X e f g
edit4* 0->2 : b a c d X f g
edit4  0->2*: b a c d X f g
0->2* edit4 : b a c d X f g
0->2  edit4*: b a c d X f g
edit5* 0->2 : b a c d e X g
edit5  0->2*: b a c d e X g
0->2* edit5 : b a c d e X g
0->2  edit5*: b a c d e X g
edit6* 0->2 : b a c d e f X
edit6  0->2*: b a c d e f X
0->2* edit6 : b a c d e f X
0->2  edit6*: b a c d e f X
edit0* 0->3 : b c X d e f g
edit0  0->3*: b c X d e f g
0->3* edit0 : b c X d e f g
0->3  edit0*: b c X d e f g
edit1* 0->3 : X c a d e f g
edit1  0->3*: X c a d e f g
0->3* edit1 : X c a d e f g
0->3  edit1*: X c a d e f g
edit2* 0->3 : b X a d e f g
edit2  0->3*: b X a d e f g
0->3* edit2 : b X a d e f g
0->3  edit2*: b X a d e f g
edit3* 0->3 : b c a X e f g
edit3  0->3*: b c a X e f g
0->3* edit3 : b c a X e f g
0->3  edit3*: b c a X e f g
edit4* 0->3 : b c a d X f g
edit4  0->3*: b c a d X f g
0->3* edit4 : b c a d X f g
0->3  edit4*: b c a d X f g
edit5* 0->3 : b c a d e X g
edit5  0->3*: b c a d e X g
0->3* edit5 : b c a d e X g
0->3  edit5*: b c a d e X g
edit6* 0->3 : b c a d e f X
edit6  0->3*: b c a d e f X
0->3* edit6 : b c a d e f X
0->3  edit6*: b c a d e f X
edit0* 0->4 : b c d X e f g
edit0  0->4*: b c d X e f g
0->4* edit0 : b c d X e f g
0->4  edit0*: b c d X e f g
edit1* 0->4 : X c d a e f g
edit1  0->4*: X c d a e f g
0->4* edit1 : X c d a e f g
0->4  edit1*: X c d a e f g
edit2* 0->4 : b X d a e f g
edit2  0->4*: b X d a e f g
0->4* edit2 : b X d a e f g
0->4  edit2*: b X d a e f g
edit3* 0->4 : b c X a e f g
edit3  0->4*: b c X a e f g
0->4* edit3 : b c X a e f g
0->4  edit3*: b c X a e f g
edit4* 0->4 : b c d a X f g
edit4  0->4*: b c d a X f g
0->4* edit4 : b c d a X f g
0->4  edit4*: b c d a X f g
edit5* 0->4 : b c d a e X g
edit5  0->4*: b c d a e X g
0->4* edit5 : b c d a e X g
0->4  edit5*: b c d a e X g
edit6* 0->4 : b c d a e f X
edit6  0->4*: b c d a e f X
0->4* edit6 : b c d a e f X
0->4  edit6*: b c d a e f X
edit0* 0->5 : b c d e X f g
edit0  0->5*: b c d e X f g
0->5* edit0 : b c d e X f g
0->5  edit0*: b c d e X f g
edit1* 0->5 : X c d e a f g
edit1  0->5*: X c d e a f g
0->5* edit1 : X c d e a f g
0->5  edit1*: X c d e a f g
edit2* 0->5 : b X d e a f g
edit2  0->5*: b X d e a f g
0->5* edit2 : b X d e a f g
0->5  edit2*: b X d e a f g
edit3* 0->5 : b c X e a f g
edit3  0->5*: b c X e a f g
0->5* edit3 : b c X e a f g
0->5  edit3*: b c X e a f g
edit4* 0->5 : b c d X a f g
edit4  0->5*: b c d X a f g
0->5* edit4 : b c d X a f g
0->5  edit4*: b c d X a f g
edit5* 0->5 : b c d e a X g
edit5  0->5*: b c d e a X g
0->5* edit5 : b c d e a X g
0->5  edit5*: b c d e a X g
edit6* 0->5 : b c d e a f X
edit6  0->5*: b c d e a f X
0->5* edit6 : b c d e a f X
0->5  edit6*: b c d e a f X
edit0* 0->6 : b c d e f X g
edit0  0->6*: b c d e f X g
0->6* edit0 : b c d e f X g
0->6  edit0*: b c d e f X g
edit1* 0->6 : X c d e f a g
edit1  0->6*: X c d e f a g
0->6* edit1 : X c d e f a g
0->6  edit1*: X c d e f a g
edit2* 0->6 : b X d e f a g
edit2  0->6*: b X d e f a g
0->6* edit2 : b X d e f a g
0->6  edit2*: b X d e f a g
edit3* 0->6 : b c X e f a g
edit3  0->6*: b c X e f a g
0->6* edit3 : b c X e f a g
0->6  edit3*: b c X e f a g
edit4* 0->6 : b c d X f a g
edit4  0->6*: b c d X f a g
0->6* edit4 : b c d X f a g
0->6  edit4*: b c d X f a g
edit5* 0->6 : b c d e X a g
edit5  0->6*: b c d e X a g
0->6* edit5 : b c d e X a g
0->6  edit5*: b c d e X a g
edit6* 0->6 : b c d e f a X
edit6  0->6*: b c d e f a X
0->6* edit6 : b c d e f a X
0->6  edit6*: b c d e f a X
edit0* 0->7 : b c d e f g X
edit0  0->7*: b c d e f g X
0->7* edit0 : b c d e f g X
0->7  edit0*: b c d e f g X
edit1* 0->7 : X c d e f g a
edit1  0->7*: X c d e f g a
0->7* edit1 : X c d e f g a
0->7  edit1*: X c d e f g a
edit2* 0->7 : b X d e f g a
edit2  0->7*: b X d e f g a
0->7* edit2 : b X d e f g a
0->7  edit2*: b X d e f g a
edit3* 0->7 : b c X e f g a
edit3  0->7*: b c X e f g a
0->7* edit3 : b c X e f g a
0->7  edit3*: b c X e f g a
edit4* 0->7 : b c d X f g a
edit4  0->7*: b c d X f g a
0->7* edit4 : b c d X f g a
0->7  edit4*: b c d X f g a
edit5* 0->7 : b c d e X g a
edit5  0->7*: b c d e X g a
0->7* edit5 : b c d e X g a
0->7  edit5*: b c d e X g a
edit6* 0->7 : b c d e f X a
edit6  0->7*: b c d e f X a
0->7* edit6 : b c d e f X a
0->7  edit6*: b c d e f X a
edit0* 1->0 : b X c d e f g
edit0  1->0*: b X c d e f g
1->0* edit0 : b X c d e f g
1->0  edit0*: b X c d e f g
edit1* 1->0 : X a c d e f g
edit1  1->0*: X a c d e f g
1->0* edit1 : X a c d e f g
1->0  edit1*: X a c d e f g
edit2* 1->0 : b a X d e f g
edit2  1->0*: b a X d e f g
1->0* edit2 : b a X d e f g
1->0  edit2*: b a X d e f g
edit3* 1->0 : b a c X e f g
edit3  1->0*: b a c X e f g
1->0* edit3 : b a c X e f g
1->0  edit3*: b a c X e f g
edit4* 1->0 : b a c d X f g
edit4  1->0*: b a c d X f g
1->0* edit4 : b a c d X f g
1->0  edit4*: b a c d X f g
edit5* 1->0 : b a c d e X g
edit5  1->0*: b a c d e X g
1->0* edit5 : b a c d e X g
1->0  edit5*: b a c d e X g
edit6* 1->0 : b a c d e f X
edit6  1->0*: b a c d e f X
1->0* edit6 : b a c d e f X
1->0  edit6*: b a c d e f X
edit0* 1->1 : X b c d e f g
edit0  1->1*: X b c d e f g
1->1* edit0 : X b c d e f g
1->1  edit0*: X b c d e f g
edit1* 1->1 : a X c d e f g
edit1  1->1*: a X c d e f g
1->1* edit1 : a X c d e f g
1->1  edit1*: a X c d e f g
edit2* 1->1 : a b X d e f g
edit2  1->1*: a b X d e f g
1->1* edit2 : a b X d e f g
1->1  edit2*: a b X d e f g
edit3* 1->1 : a b c X e f g
edit3  1->1*: a b c X e f g
1->1* edit3 : a b c X e f g
1->1  edit3*: a b c X e f g
edit4* 1->1 : a b c d X f g
edit4  1->1*: a b c d X f g
1->1* edit4 : a b c d X f g
1->1  edit4*: a b c d X f g
edit5* 1->1 : a b c d e X g
edit5  1->1*: a b c d e X g
1->1* edit5 : a b c d e X g
1->1  edit5*: a b c d e X g
edit6* 1->1 : a b c d e f X
edit6  1->1*: a b c d e f X
1->1* edit6 : a b c d e f X
1->1  edit6*: a b c d e f X
edit0* 1->2 : X b c d e f g
edit0  1->2*: X b c d e f g
1->2* edit0 : X b c d e f g
1->2  edit0*: X b c d e f g
edit1* 1->2 : a X c d e f g
edit1  1->2*: a X c d e f g
1->2* edit1 : a X c d e f g
1->2  edit1*: a X c d e f g
edit2* 1->2 : a b X d e f g
edit2  1->2*: a b X d e f g
1->2* edit2 : a b X d e f g
1->2  edit2*: a b X d e f g
edit3* 1->2 : a b c X e f g
edit3  1->2*: a b c X e f g
1->2* edit3 : a b c X e f g
1->2  edit3*: a b c X e f g
edit4* 1->2 : a b c d X f g
edit4  1->2*: a b c d X f g
1->2* edit4 : a b c d X f g
1->2  edit4*: a b c d X f g
edit5* 1->2 : a b c d e X g
edit5  1->2*: a b c d e X g
1->2* edit5 : a b c d e X g
1->2  edit5*: a b c d e X g
edit6* 1->2 : a b c d e f X
edit6  1->2*: a b c d e f X
1->2* edit6 : a b c d e f X
1->2  edit6*: a b c d e f X
edit0* 1->3 : X c b d e f g
edit0  1->3*: X c b d e f g
1->3* edit0 : X c b d e f g
1->3  edit0*: X c b d e f g
edit1* 1->3 : a c X d e f g
edit1  1->3*: a c X d e f g
1->3* edit1 : a c X d e f g
1->3  edit1*: a c X d e f g
edit2* 1->3 : a X b d e f g
edit2  1->3*: a X b d e f g
1->3* edit2 : a X b d e f g
1->3  edit2*: a X b d e f g
edit3* 1->3 : a c b X e f g
edit3  1->3*: a c b X e f g
1->3* edit3 : a c b X e f g
1->3  edit3*: a c b X e f g
edit4* 1->3 : a c b d X f g
edit4  1->3*: a c b d X f g
1->3* edit4 : a c b d X f g
1->3  edit4*: a c b d X f g
edit5* 1->3 : a c b d e X g
edit5  1->3*: a c b d e X g
1->3* edit5 : a c b d e X g
1->3  edit5*: a c b d e X g
edit6* 1->3 : a c b d e f X
edit6  1->3*: a c b d e f X
1->3* edit6 : a c b d e f X
1->3  edit6*: a c b d e f X
edit0* 1->4 : X c d b e f g
edit0  1->4*: X c d b e f g
1->4* edit0 : X c d b e f g
1->4  edit0*: X c d b e f g
edit1* 1->4 : a c d X e f g
edit1  1->4*: a c d X e f g
1->4* edit1 : a c d X e f g
1->4  edit1*: a c d X e f g
edit2* 1->4 : a X d b e f g
edit2  1->4*: a X d b e f g
1->4* edit2 : a X d b e f g
1->4  edit2*: a X d b e f g
edit3* 1->4 : a c X b e f g
edit3  1->4*: a c X b e f g
1->4* edit3 : a c X b e f g
1->4  edit3*: a c X b e f g
edit4* 1->4 : a c d b X f g
edit4  1->4*: a c d b X f g
1->4* edit4 : a c d b X f g
1->4  edit4*: a c d b X f g
edit5* 1->4 : a c d b e X g
edit5  1->4*: a c d b e X g
1->4* edit5 : a c d b e X g
1->4  edit5*: a c d b e X g
edit6* 1->4 : a c d b e f X
edit6  1->4*: a c d b e f X
1->4* edit6 : a c d b e f X
1->4  edit6*: a c d b e f X
edit0* 1->5 : X c d e b f g
edit0  1->5*: X c d e b f g
1->5* edit0 : X c d e b f g
1->5  edit0*: X c d e b f g
edit1* 1->5 : a c d e X f g
edit1  1->5*: a c d e X f g
1->5* edit1 : a c d e X f g
1->5  edit1*: a c d e X f g
edit2* 1->5 : a X d e b f g
edit2  1->5*: a X d e b f g
1->5* edit2 : a X d e b f g
1->5  edit2*: a X d e b f g
edit3* 1->5 : a c X e b f g
edit3  1->5*: a c X e b f g
1->5* edit3 : a c X e b f g
1->5  edit3*: a c X e b f g
edit4* 1->5 : a c d X b f g
edit4  1->5*: a c d X b f g
1->5* edit4 : a c d X b f g
1->5  edit4*: a c d X b f g
edit5* 1->5 : a c d e b X g
edit5  1->5*: a c d e b X g
1->5* edit5 : a c d e b X g
1->5  edit5*: a c d e b X g
edit6* 1->5 : a c d e b f X
edit6  1->5*: a c d e b f X
1->5* edit6 : a c d e b f X
1->5  edit6*: a c d e b f X
edit0* 1->6 : X c d e f b g
edit0  1->6*: X c d e f b g
1->6* edit0 : X c d e f b g
1->6  edit0*: X c d e f b g
edit1* 1->6 : a c d e f X g
edit1  1->6*: a c d e f X g
1->6* edit1 : a c d e f X g
1->6  edit1*: a c d e f X g
edit2* 1->6 : a X d e f b g
edit2  1->6*: a X d e f b g
1->6* edit2 : a X d e f b g
1->6  edit2*: a X d e f b g
edit3* 1->6 : a c X e f b g
edit3  1->6*: a c X e f b g
1->6* edit3 : a c X e f b g
1->6  edit3*: a c X e f b g
edit4* 1->6 : a c d X f b g
edit4  1->6*: a c d X f b g
1->6* edit4 : a c d X f b g
1->6  edit4*: a c d X f b g
edit5* 1->6 : a c d e X b g
edit5  1->6*: a c d e X b g
1->6* edit5 : a c d e X b g
1->6  edit5*: a c d e X b g
edit6* 1->6 : a c d e f b X
edit6  1->6*: a c d e f b X
1->6* edit6 : a c d e f b X
1->6  edit6*: a c d e f b X
edit0* 1->7 : X c d e f g b
edit0  1->7*: X c d e f g b
1->7* edit0 : X c d e f g b
1->7  edit0*: X c d e f g b
edit1* 1->7 : a c d e f g X
edit1  1->7*: a c d e f g X
1->7* edit1 : a c d e f g X
1->7  edit1*: a c d e f g X
edit2* 1->7 : a X d e f g b
edit2  1->7*: a X d e f g b
1->7* edit2 : a X d e f g b
1->7  edit2*: a X d e f g b
edit3* 1->7 : a c X e f g b
edit3  1->7*: a c X e f g b
1->7* edit3 : a c X e f g b
1->7  edit3*: a c X e f g b
edit4* 1->7 : a c d X f g b
edit4  1->7*: a c d X f g b
1->7* edit4 : a c d X f g b
1->7  edit4*: a c d X f g b
edit5* 1->7 : a c d e X g b
edit5  1->7*: a c d e X g b
1->7* edit5 : a c d e X g b
1->7  edit5*: a c d e X g b
edit6* 1->7 : a c d e f X b
edit6  1->7*: a c d e f X b
1->7* edit6 : a c d e f X b
1->7  edit6*: a c d e f X b
edit0* 2->0 : c X b d e f g
edit0  2->0*: c X b d e f g
2->0* edit0 : c X b d e f g
2->0  edit0*: c X b d e f g
edit1* 2->0 : c a X d e f g
edit1  2->0*: c a X d e f g
2->0* edit1 : c a X d e f g
2->0  edit1*: c a X d e f g
edit2* 2->0 : X a b d e f g
edit2  2->0*: X a b d e f g
2->0* edit2 : X a b d e f g
2->0  edit2*: X a b d e f g
edit3* 2->0 : c a b X e f g
edit3  2->0*: c a b X e f g
2->0* edit3 : c a b X e f g
2->0  edit3*: c a b X e f g
edit4* 2->0 : c a b d X f g
edit4  2->0*: c a b d X f g
2->0* edit4 : c a b d X f g
2->0  edit4*: c a b d X f g
edit5* 2->0 : c a b d e X g
edit5  2->0*: c a b d e X g
2->0* edit5 : c a b d e X g
2->0  edit5*: c a b d e X g
edit6* 2->0 : c a b d e f X
edit6  2->0*: c a b d e f X
2->0* edit6 : c a b d e f X
2->0  edit6*: c a b d e f X
edit0* 2->1 : X c b d e f g
edit0  2->1*: X c b d e f g
2->1* edit0 : X c b d e f g
2->1  edit0*: X c b d e f g
edit1* 2->1 : a c X d e f g
edit1  2->1*: a c X d e f g
2->1* edit1 : a c X d e f g
2->1  edit1*: a c X d e f g
edit2* 2->1 : a X b d e f g
edit2  2->1*: a X b d e f g
2->1* edit2 : a X b d e f g
2->1  edit2*: a X b d e f g
edit3* 2->1 : a c b X e f g
edit3  2->1*: a c b X e f g
2->1* edit3 : a c b X e f g
2->1  edit3*: a c b X e f g
edit4* 2->1 : a c b d X f g
edit4  2->1*: a c b d X f g
2->1* edit4 : a c b d X f g
2->1  edit4*: a c b d X f g
edit5* 2->1 : a c b d e X g
edit5  2->1*: a c b d e X g
2->1* edit5 : a c b d e X g
2->1  edit5*: a c b d e X g
edit6* 2->1 : a c b d e f X
edit6  2->1*: a c b d e f X
2->1* edit6 : a c b d e f X
2->1  edit6*: a c b d e f X
edit0* 2->2 : X b c d e f g
edit0  2->2*: X b c d e f g
2->2* edit0 : X b c d e f g
2->2  edit0*: X b c d e f g
edit1* 2->2 : a X c d e f g
edit1  2->2*: a X c d e f g
2->2* edit1 : a X c d e f g
2->2  edit1*: a X c d e f g
edit2* 2->2 : a b X d e f g
edit2  2->2*: a b X d e f g
2->2* edit2 : a b X d e f g
2->2  edit2*: a b X d e f g
edit3* 2->2 : a b c X e f g
edit3  2->2*: a b c X e f g
2->2* edit3 : a b c X e f g
2->2  edit3*: a b c X e f g
edit4* 2->2 : a b c d X f g
edit4  2->2*: a b c d X f g
2->2* edit4 : a b c d X f g
2->2  edit4*: a b c d X f g
edit5* 2->2 : a b c d e X g
edit5  2->2*: a b c d e X g
2->2* edit5 : a b c d e X g
2->2  edit5*: a b c d e X g
edit6* 2->2 : a b c d e f X
edit6  2->2*: a b c d e f X
2->2* edit6 : a b c d e f X
2->2  edit6*: a b c d e f X
edit0* 2->3 : X b c d e f g
edit0  2->3*: X b c d e f g
2->3* edit0 : X b c d e f g
2->3  edit0*: X b c d e f g
edit1* 2->3 : a X c d e f g
edit1  2->3*: a X c d e f g
2->3* edit1 : a X c d e f g
2->3  edit1*: a X c d e f g
edit2* 2->3 : a b X d e f g
edit2  2->3*: a b X d e f g
2->3* edit2 : a b X d e f g
2->3  edit2*: a b X d e f g
edit3* 2->3 : a b c X e f g
edit3  2->3*: a b c X e f g
2->3* edit3 : a b c X e f g
2->3  edit3*: a b c X e f g
edit4* 2->3 : a b c d X f g
edit4  2->3*: a b c d X f g
2->3* edit4 : a b c d X f g
2->3  edit4*: a b c d X f g
edit5* 2->3 : a b c d e X g
edit5  2->3*: a b c d e X g
2->3* edit5 : a b c d e X g
2->3  edit5*: a b c d e X g
edit6* 2->3 : a b c d e f X
edit6  2->3*: a b c d e f X
2->3* edit6 : a b c d e f X
2->3  edit6*: a b c d e f X
edit0* 2->4 : X b d c e f g
edit0  2->4*: X b d c e f g
2->4* edit0 : X b d c e f g
2->4  edit0*: X b d c e f g
edit1* 2->4 : a X d c e f g
edit1  2->4*: a X d c e f g
2->4* edit1 : a X d c e f g
2->4  edit1*: a X d c e f g
edit2* 2->4 : a b d X e f g
edit2  2->4*: a b d X e f g
2->4* edit2 : a b d X e f g
2->4  edit2*: a b d X e f g
edit3* 2->4 : a b X c e f g
edit3  2->4*: a b X c e f g
2->4* edit3 : a b X c e f g
2->4  edit3*: a b X c e f g
edit4* 2->4 : a b d c X f g
edit4  2->4*: a b d c X f g
2->4* edit4 : a b d c X f g
2->4  edit4*: a b d c X f g
edit5* 2->4 : a b d c e X g
edit5  2->4*: a b d c e X g
2->4* edit5 : a b d c e X g
2->4  edit5*: a b d c e X g
edit6* 2->4 : a b d c e f X
edit6  2->4*: a b d c e f X
2->4* edit6 : a b d c e f X
2->4  edit6*: a b d c e f X
edit0* 2->5 : X b d e c f g
edit0  2->5*: X b d e c f g
2->5* edit0 : X b d e c f g
2->5  edit0*: X b d e c f g
edit1* 2->5 : a X d e c f g
edit1  2->5*: a X d e c f g
2->5* edit1 : a X d e c f g
2->5  edit1*: a X d e c f g
edit2* 2->5 : a b d e X f g
edit2  2->5*: a b d e X f g
2->5* edit2 : a b d e X f g
2->5  edit2*: a b d e X f g
edit3* 2->5 : a b X e c f g
edit3  2->5*: a b X e c f g
2->5* edit3 : a b X e c f g
2->5  edit3*: a b X e c f g
edit4* 2->5 : a b d X c f g
edit4  2->5*: a b d X c f g
2->5* edit4 : a b d X c f g
2->5  edit4*: a b d X c f g
edit5* 2->5 : a b d e c X g
edit5  2->5*: a b d e c X g
2->5* edit5 : a b d e c X g
2->5  edit5*: a b d e c X g
edit6* 2->5 : a b d e c f X
edit6  2->5*: a b d e c f X
2->5* edit6 : a b d e c f X
2->5  edit6*: a b d e c f X
edit0* 2->6 : X b d e f c g
edit0  2->6*: X b d e f c g
2->6* edit0 : X b d e f c g
2->6  edit0*: X b d e f c g
edit1* 2->6 : a X d e f c g
edit1  2->6*: a X d e f c g
2->6* edit1 : a X d e f c g
2->6  edit1*: a X d e f c g
edit2* 2->6 : a b d e f X g
edit2  2->6*: a b d e f X g
2->6* edit2 : a b d e f X g
2->6  edit2*: a b d e f X g
edit3* 2->6 : a b X e f c g
edit3  2->6*: a b X e f c g
2->6* edit3 : a b X e f c g
2->6  edit3*: a b X e f c g
edit4* 2->6 : a b d X f c g
edit4  2->6*: a b d X f c g
2->6* edit4 : a b d X f c g
2->6  edit4*: a b d X f c g
edit5* 2->6 : a b d e X c g
edit5  2->6*: a b d e X c g
2->6* edit5 : a b d e X c g
2->6  edit5*: a b d e X c g
edit6* 2->6 : a b d e f c X
edit6  2->6*: a b d e f c X
2->6* edit6 : a b d e f c X
2->6  edit6*: a b d e f c X
edit0* 2->7 : X b d e f g c
edit0  2->7*: X b d e f g c
2->7* edit0 : X b d e f g c
2->7  edit0*: X b d e f g c
edit1* 2->7 : a X d e f g c
edit1  2->7*: a X d e f g c
2->7* edit1 : a X d e f g c
2->7  edit1*: a X d e f g c
edit2* 2->7 : a b d e f g X
edit2  2->7*: a b d e f g X
2->7* edit2 : a b d e f g X
2->7  edit2*: a b d e f g X
edit3* 2->7 : a b X e f g c
edit3  2->7*: a b X e f g c
2->7* edit3 : a b X e f g c
2->7  edit3*: a b X e f g c
edit4* 2->7 : a b d X f g c
edit4  2->7*: a b d X f g c
2->7* edit4 : a b d X f g c
2->7  edit4*: a b d X f g c
edit5* 2->7 : a b d e X g c
edit5  2->7*: a b d e X g c
2->7* edit5 : a b d e X g c
2->7  edit5*: a b d e X g c
edit6* 2->7 : a b d e f X c
edit6  2->7*: a b d e f X c
2->7* edit6 : a b d e f X c
2->7  edit6*: a b d e f X c
edit0* 3->0 : d X b c e f g
edit0  3->0*: d X b c e f g
3->0* edit0 : d X b c e f g
3->0  edit0*: d X b c e f g
edit1* 3->0 : d a X c e f g
edit1  3->0*: d a X c e f g
3->0* edit1 : d a X c e f g
3->0  edit1*: d a X c e f g
edit2* 3->0 : d a b X e f g
edit2  3->0*: d a b X e f g
3->0* edit2 : d a b X e f g
3->0  edit2*: d a b X e f g
edit3* 3->0 : X a b c e f g
edit3  3->0*: X a b c e f g
3->0* edit3 : X a b c e f g
3->0  edit3*: X a b c e f g
edit4* 3->0 : d a b c X f g
edit4  3->0*: d a b c X f g
3->0* edit4 : d a b c X f g
3->0  edit4*: d a b c X f g
edit5* 3->0 : d a b c e X g
edit5  3->0*: d a b c e X g
3->0* edit5 : d a b c e X g
3->0  edit5*: d a b c e X g
edit6* 3->0 : d a b c e f X
edit6  3->0*: d a b c e f X
3->0* edit6 : d a b c e f X
3->0  edit6*: d a b c e f X
edit0* 3->1 : X d b c e f g
edit0  3->1*: X d b c e f g
3->1* edit0 : X d b c e f g
3->1  edit0*: X d b c e f g
edit1* 3->1 : a d X c e f g
edit1  3->1*: a d X c e f g
3->1* edit1 : a d X c e f g
3->1  edit1*: a d X c e f g
edit2* 3->1 : a d b X e f g
edit2  3->1*: a d b X e f g
3->1* edit2 : a d b X e f g
3->1  edit2*: a d b X e f g
edit3* 3->1 : a X b c e f g
edit3  3->1*: a X b c e f g
3->1* edit3 : a X b c e f g
3->1  edit3*: a X b c e f g
edit4* 3->1 : a d b c X f g
edit4  3->1*: a d b c X f g
3->1* edit4 : a d b c X f g
3->1  edit4*: a d b c X f g
edit5* 3->1 : a d b c e X g
edit5  3->1*: a d b c e X g
3->1* edit5 : a d b c e X g
3->1  edit5*: a d b c e X g
edit6* 3->1 : a d b c e f X
edit6  3->1*: a d b c e f X
3->1* edit6 : a d b c e f X
3->1  edit6*: a d b c e f X
edit0* 3->2 : X b d c e f g
edit0  3->2*: X b d c e f g
3->2* edit0 : X b d c e f g
3->2  edit0*: X b d c e f g
edit1* 3->2 : a X d c e f g
edit1  3->2*: a X d c e f g
3->2* edit1 : a X d c e f g
3->2  edit1*: a X d c e f g
edit2* 3->2 : a b d X e f g
edit2  3->2*: a b d X e f g
3->2* edit2 : a b d X e f g
3->2  edit2*: a b d X e f g
edit3* 3->2 : a b X c e f g
edit3  3->2*: a b X c e f g
3->2* edit3 : a b X c e f g
3->2  edit3*: a b X c e f g
edit4* 3->2 : a b d c X f g
edit4  3->2*: a b d c X f g
3->2* edit4 : a b d c X f g
3->2  edit4*: a b d c X f g
edit5* 3->2 : a b d c e X g
edit5  3->2*: a b d c e X g
3->2* edit5 : a b d c e X g
3->2  edit5*: a b d c e X g
edit6* 3->2 : a b d c e f X
edit6  3->2*: a b d c e f X
3->2* edit6 : a b d c e f X
3->2  edit6*: a b d c e f X
edit0* 3->3 : X b c d e f g
edit0  3->3*: X b c d e f g
3->3* edit0 : X b c d e f g
3->3  edit0*: X b c d e f g
edit1* 3->3 : a X c d e f g
edit1  3->3*: a X c d e f g
3->3* edit1 : a X c d e f g
3->3  edit1*: a X c d e f g
edit2* 3->3 : a b X d e f g
edit2  3->3*: a b X d e f g
3->3* edit2 : a b X d e f g
3->3  edit2*: a b X d e f g
edit3* 3->3 : a b c X e f g
edit3  3->3*: a b c X e f g
3->3* edit3 : a b c X e f g
3->3  edit3*: a b c X e f g
edit4* 3->3 : a b c d X f g
edit4  3->3*: a b c d X f g
3->3* edit4 : a b c d X f g
3->3  edit4*: a b c d X f g
edit5* 3->3 : a b c d e X g
edit5  3->3*: a b c d e X g
3->3* edit5 : a b c d e X g
3->3  edit5*: a b c d e X g
edit6* 3->3 : a b c d e f X
edit6  3->3*: a b c d e f X
3->3* edit6 : a b c d e f X
3->3  edit6*: a b c d e f X
edit0* 3->4 : X b c d e f g
edit0  3->4*: X b c d e f g
3->4* edit0 : X b c d e f g
3->4  edit0*: X b c d e f g
edit1* 3->4 : a X c d e f g
edit1  3->4*: a X c d e f g
3->4* edit1 : a X c d e f g
3->4  edit1*: a X c d e f g
edit2* 3->4 : a b X d e f g
edit2  3->4*: a b X d e f g
3->4* edit2 : a b X d e f g
3->4  edit2*: a b X d e f g
edit3* 3->4 : a b c X e f g
edit3  3->4*: a b c X e f g
3->4* edit3 : a b c X e f g
3->4  edit3*: a b c X e f g
edit4* 3->4 : a b c d X f g
edit4  3->4*: a b c d X f g
3->4* edit4 : a b c d X f g
3->4  edit4*: a b c d X f g
edit5* 3->4 : a b c d e X g
edit5  3->4*: a b c d e X g
3->4* edit5 : a b c d e X g
3->4  edit5*: a b c d e X g
edit6* 3->4 : a b c d e f X
edit6  3->4*: a b c d e f X
3->4* edit6 : a b c d e f X
3->4  edit6*: a b c d e f X
edit0* 3->5 : X b c e d f g
edit0  3->5*: X b c e d f g
3->5* edit0 : X b c e d f g
3->5  edit0*: X b c e d f g
edit1* 3->5 : a X c e d f g
edit1  3->5*: a X c e d f g
3->5* edit1 : a X c e d f g
3->5  edit1*: a X c e d f g
edit2* 3->5 : a b X e d f g
edit2  3->5*: a b X e d f g
3->5* edit2 : a b X e d f g
3->5  edit2*: a b X e d f g
edit3* 3->5 : a b c e X f g
edit3  3->5*: a b c e X f g
3->5* edit3 : a b c e X f g
3->5  edit3*: a b c e X f g
edit4* 3->5 : a b c X d f g
edit4  3->5*: a b c X d f g
3->5* edit4 : a b c X d f g
3->5  edit4*: a b c X d f g
edit5* 3->5 : a b c e d X g
edit5  3->5*: a b c e d X g
3->5* edit5 : a b c e d X g
3->5  edit5*: a b c e d X g
edit6* 3->5 : a b c e d f X
edit6  3->5*: a b c e d f X
3->5* edit6 : a b c e d f X
3->5  edit6*: a b c e d f X
edit0* 3->6 : X b c e f d g
edit0  3->6*: X b c e f d g
3->6* edit0 : X b c e f d g
3->6  edit0*: X b c e f d g
edit1* 3->6 : a X c e f d g
edit1  3->6*: a X c e f d g
3->6* edit1 : a X c e f d g
3->6  edit1*: a X c e f d g
edit2* 3->6 : a b X e f d g
edit2  3->6*: a b X e f d g
3->6* edit2 : a b X e f d g
3->6  edit2*: a b X e f d g
edit3* 3->6 : a b c e f X g
edit3  3->6*: a b c e f X g
3->6* edit3 : a b c e f X g
3->6  edit3*: a b c e f X g
edit4* 3->6 : a b c X f d g
edit4  3->6*: a b c X f d g
3->6* edit4 : a b c X f d g
3->6  edit4*: a b c X f d g
edit5* 3->6 : a b c e X d g
edit5  3->6*: a b c e X d g
3->6* edit5 : a b c e X d g
3->6  edit5*: a b c e X d g
edit6* 3->6 : a b c e f d X
edit6  3->6*: a b c e f d X
3->6* edit6 : a b c e f d X
3->6  edit6*: a b c e f d X
edit0* 3->7 : X b c e f g d
edit0  3->7*: X b c e f g d
3->7* edit0 : X b c e f g d
3->7  edit0*: X b c e f g d
edit1* 3->7 : a X c e f g d
edit1  3->7*: a X c e f g d
3->7* edit1 : a X c e f g d
3->7  edit1*: a X c e f g d
edit2* 3->7 : a b X e f g d
edit2  3->7*: a b X e f g d
3->7* edit2 : a b X e f g d
3->7  edit2*: a b X e f g d
edit3* 3->7 : a b c e f g X
edit3  3->7*: a b c e f g X
3->7* edit3 : a b c e f g X
3->7  edit3*: a b c e f g X
edit4* 3->7 : a b c X f g d
edit4  3->7*: a b c X f g d
3->7* edit4 : a b c X f g d
3->7  edit4*: a b c X f g d
edit5* 3->7 : a b c e X g d
edit5  3->7*: a b c e X g d
3->7* edit5 : a b c e X g d
3->7  edit5*: a b c e X g d
edit6* 3->7 : a b c e f X d
edit6  3->7*: a b c e f X d
3->7* edit6 : a b c e f X d
3->7  edit6*: a b c e f X d
edit0* 4->0 : e X b c d f g
edit0  4->0*: e X b c d f g
4->0* edit0 : e X b c d f g
4->0  edit0*: e X b c d f g
edit1* 4->0 : e a X c d f g
edit1  4->0*: e a X c d f g
4->0* edit1 : e a X c d f g
4->0  edit1*: e a X c d f g
edit2* 4->0 : e a b X d f g
edit2  4->0*: e a b X d f g
4->0* edit2 : e a b X d f g
4->0  edit2*: e a b X d f g
edit3* 4->0 : e a b c X f g
edit3  4->0*: e a b c X f g
4->0* edit3 : e a b c X f g
4->0  edit3*: e a b c X f g
edit4* 4->0 : X a b c d f g
edit4  4->0*: X a b c d f g
4->0* edit4 : X a b c d f g
4->0  edit4*: X a b c d f g
edit5* 4->0 : e a b c d X g
edit5  4->0*: e a b c d X g
4->0* edit5 : e a b c d X g
4->0  edit5*: e a b c d X g
edit6* 4->0 : e a b c d f X
edit6  4->0*: e a b c d f X
4->0* edit6 : e a b c d f X
4->0  edit6*: e a b c d f X
edit0* 4->1 : X e b c d f g
edit0  4->1*: X e b c d f g
4->1* edit0 : X e b c d f g
4->1  edit0*: X e b c d f g
edit1* 4->1 : a e X c d f g
edit1  4->1*: a e X c d f g
4->1* edit1 : a e X c d f g
4->1  edit1*: a e X c d f g
edit2* 4->1 : a e b X d f g
edit2  4->1*: a e b X d f g
4->1* edit2 : a e b X d f g
4->1  edit2*: a e b X d f g
edit3* 4->1 : a e b c X f g
edit3  4->1*: a e b c X f g
4->1* edit3 : a e b c X f g
4->1  edit3*: a e b c X f g
edit4* 4->1 : a X b c d f g
edit4  4->1*: a X b c d f g
4->1* edit4 : a X b c d f g
4->1  edit4*: a X b c d f g
edit5* 4->1 : a e b c d X g
edit5  4->1*: a e b c d X g
4->1* edit5 : a e b c d X g
4->1  edit5*: a e b c d X g
edit6* 4->1 : a e b c d f X
edit6  4->1*: a e b c d f X
4->1* edit6 : a e b c d f X
4->1  edit6*: a e b c d f X
edit0* 4->2 : X b e c d f g
edit0  4->2*: X b e c d f g
4->2* edit0 : X b e c d f g
4->2  edit0*: X b e c d f g
edit1* 4->2 : a X e c d f g
edit1  4->2*: a X e c d f g
4->2* edit1 : a X e c d f g
4->2  edit1*: a X e c d f g
edit2* 4->2 : a b e X d f g
edit2  4->2*: a b e X d f g
4->2* edit2 : a b e X d f g
4->2  edit2*: a b e X d f g
edit3* 4->2 : a b e c X f g
edit3  4->2*: a b e c X f g
4->2* edit3 : a b e c X f g
4->2  edit3*: a b e c X f g
edit4* 4->2 : a b X c d f g
edit4  4->2*: a b X c d f g
4->2* edit4 : a b X c d f g
4->2  edit4*: a b X c d f g
edit5* 4->2 : a b e c d X g
edit5  4->2*: a b e c d X g
4->2* edit5 : a b e c d X g
4->2  edit5*: a b e c d X g
edit6* 4->2 : a b e c d f X
edit6  4->2*: a b e c d f X
4->2* edit6 : a b e c d f X
4->2  edit6*: a b e c d f X
edit0* 4->3 : X b c e d f g
edit0  4->3*: X b c e d f g
4->3* edit0 : X b c e d f g
4->3  edit0*: X b c e d f g
edit1* 4->3 : a X c e d f g
edit1  4->3*: a X c e d f g
4->3* edit1 : a X c e d f g
4->3  edit1*: a X c e d f g
edit2* 4->3 : a b X e d f g
edit2  4->3*: a b X e d f g
4->3* edit2 : a b X e d f g
4->3  edit2*: a b X e d f g
edit3* 4->3 : a b c e X f g
edit3  4->3*: a b c e X f g
4->3* edit3 : a b c e X f g
4->3  edit3*: a b c e X f g
edit4* 4->3 : a b c X d f g
edit4  4->3*: a b c X d f g
4->3* edit4 : a b c X d f g
4->3  edit4*: a b c X d f g
edit5* 4->3 : a b c e d X g
edit5  4->3*: a b c e d X g
4->3* edit5 : a b c e d X g
4->3  edit5*: a b c e d X g
edit6* 4->3 : a b c e d f X
edit6  4->3*: a b c e d f X
4->3* edit6 : a b c e d f X
4->3  edit6*: a b c e d f X
edit0* 4->4 : X b c d e f g
edit0  4->4*: X b c d e f g
4->4* edit0 : X b c d e f g
4->4  edit0*: X b c d e f g
edit1* 4->4 : a X c d e f g
edit1  4->4*: a X c d e f g
4->4* edit1 : a X c d e f g
4->4  edit1*: a X c d e f g
edit2* 4->4 : a b X d e f g
edit2  4->4*: a b X d e f g
4->4* edit2 : a b X d e f g
4->4  edit2*: a b X d e f g
edit3* 4->4 : a b c X e f g
edit3  4->4*: a b c X e f g
4->4* edit3 : a b c X e f g
4->4  edit3*: a b c X e f g
edit4* 4->4 : a b c d X f g
edit4  4->4*: a b c d X f g
4->4* edit4 : a b c d X f g
4->4  edit4*: a b c d X f g
edit5* 4->4 : a b c d e X g
edit5  4->4*: a b c d e X g
4->4* edit5 : a b c d e X g
4->4  edit5*: a b c d e X g
edit6* 4->4 : a b c d e f X
edit6  4->4*: a b c d e f X
4->4* edit6 : a b c d e f X
4->4  edit6*: a b c d e f X
edit0* 4->5 : X b c d e f g
edit0  4->5*: X b c d e f g
4->5* edit0 : X b c d e f g
4->5  edit0*: X b c d e f g
edit1* 4->5 : a X c d e f g
edit1  4->5*: a X c d e f g
4->5* edit1 : a X c d e f g
4->5  edit1*: a X c d e f g
edit2* 4->5 : a b X d e f g
edit2  4->5*: a b X d e f g
4->5* edit2 : a b X d e f g
4->5  edit2*: a b X d e f g
edit3* 4->5 : a b c X e f g
edit3  4->5*: a b c X e f g
4->5* edit3 : a b c X e f g
4->5  edit3*: a b c X e f g
edit4* 4->5 : a b c d X f g
edit4  4->5*: a b c d X f g
4->5* edit4 : a b c d X f g
4->5  edit4*: a b c d X f g
edit5* 4->5 : a b c d e X g
edit5  4->5*: a b c d e X g
4->5* edit5 : a b c d e X g
4->5  edit5*: a b c d e X g
edit6* 4->5 : a b c d e f X
edit6  4->5*: a b c d e f X
4->5* edit6 : a b c d e f X
4->5  edit6*: a b c d e f X
edit0* 4->6 : X b c d f e g
edit0  4->6*: X b c d f e g
4->6* edit0 : X b c d f e g
4->6  edit0*: X b c d f e g
edit1* 4->6 : a X c d f e g
edit1  4->6*: a X c d f e g
4->6* edit1 : a X c d f e g
4->6  edit1*: a X c d f e g
edit2* 4->6 : a b X d f e g
edit2  4->6*: a b X d f e g
4->6* edit2 : a b X d f e g
4->6  edit2*: a b X d f e g
edit3* 4->6 : a b c X f e g
edit3  4->6*: a b c X f e g
4->6* edit3 : a b c X f e g
4->6  edit3*: a b c X f e g
edit4* 4->6 : a b c d f X g
edit4  4->6*: a b c d f X g
4->6* edit4 : a b c d f X g
4->6  edit4*: a b c d f X g
edit5* 4->6 : a b c d X e g
edit5  4->6*: a b c d X e g
4->6* edit5 : a b c d X e g
4->6  edit5*: a b c d X e g
edit6* 4->6 : a b c d f e X
edit6  4->6*: a b c d f e X
4->6* edit6 : a b c d f e X
4->6  edit6*: a b c d f e X
edit0* 4->7 : X b c d f g e
edit0  4->7*: X b c d f g e
4->7* edit0 : X b c d f g e
4->7  edit0*: X b c d f g e
edit1* 4->7 : a X c d f g e
edit1  4->7*: a X c d f g e
4->7* edit1 : a X c d f g e
4->7  edit1*: a X c d f g e
edit2* 4->7 : a b X d f g e
edit2  4->7*: a b X d f g e
4->7* edit2 : a b X d f g e
4->7  edit2*: a b X d f g e
edit3* 4->7 : a b c X f g e
edit3  4->7*: a b c X f g e
4->7* edit3 : a b c X f g e
4->7  edit3*: a b c X f g e
edit4* 4->7 : a b c d f g X
edit4  4->7*: a b c d f g X
4->7* edit4 : a b c d f g X
4->7  edit4*: a b c d f g X
edit5* 4->7 : a b c d X g e
edit5  4->7*: a b c d X g e
4->7* edit5 : a b c d X g e
4->7  edit5*: a b c d X g e
edit6* 4->7 : a b c d f X e
edit6  4->7*: a b c d f X e
4->7* edit6 : a b c d f X e
4->7  edit6*: a b c d f X e
edit0* 5->0 : f X b c d e g
edit0  5->0*: f X b c d e g
5->0* edit0 : f X b c d e g
5->0  edit0*: f X b c d e g
edit1* 5->0 : f a X c d e g
edit1  5->0*: f a X c d e g
5->0* edit1 : f a X c d e g
5->0  edit1*: f a X c d e g
edit2* 5->0 : f a b X d e g
edit2  5->0*: f a b X d e g
5->0* edit2 : f a b X d e g
5->0  edit2*: f a b X d e g
edit3* 5->0 : f a b c X e g
edit3  5->0*: f a b c X e g
5->0* edit3 : f a b c X e g
5->0  edit3*: f a b c X e g
edit4* 5->0 : f a b c d X g
edit4  5->0*: f a b c d X g
5->0* edit4 : f a b c d X g
5->0  edit4*: f a b c d X g
edit5* 5->0 : X a b c d e g
edit5  5->0*: X a b c d e g
5->0* edit5 : X a b c d e g
5->0  edit5*: X a b c d e g
edit6* 5->0 : f a b c d e X
edit6  5->0*: f a b c d e X
5->0* edit6 : f a b c d e X
5->0  edit6*: f a b c d e X
edit0* 5->1 : X f b c d e g
edit0  5->1*: X f b c d e g
5->1* edit0 : X f b c d e g
5->1  edit0*: X f b c d e g
edit1* 5->1 : a f X c d e g
edit1  5->1*: a f X c d e g
5->1* edit1 : a f X c d e g
5->1  edit1*: a f X c d e g
edit2* 5->1 : a f b X d e g
edit2  5->1*: a f b X d e g
5->1* edit2 : a f b X d e g
5->1  edit2*: a f b X d e g
edit3* 5->1 : a f b c X e g
edit3  5->1*: a f b c X e g
5->1* edit3 : a f b c X e g
5->1  edit3*: a f b c X e g
edit4* 5->1 : a f b c d X g
edit4  5->1*: a f b c d X g
5->1* edit4 : a f b c d X g
5->1  edit4*: a f b c d X g
edit5* 5->1 : a X b c d e g
edit5  5->1*: a X b c d e g
5->1* edit5 : a X b c d e g
5->1  edit5*: a X b c d e g
edit6* 5->1 : a f b c d e X
edit6  5->1*: a f b c d e X
5->1* edit6 : a f b c d e X
5->1  edit6*: a f b c d e X
edit0* 5->2 : X b f c d e g
edit0  5->2*: X b f c d e g
5->2* edit0 : X b f c d e g
5->2  edit0*: X b f c d e g
edit1* 5->2 : a X f c d e g
edit1  5->2*: a X f c d e g
5->2* edit1 : a X f c d e g
5->2  edit1*: a X f c d e g
edit2* 5->2 : a b f X d e g
edit2  5->2*: a b f X d e g
5->2* edit2 : a b f X d e g
5->2  edit2*: a b f X d e g
edit3* 5->2 : a b f c X e g
edit3  5->2*: a b f c X e g
5->2* edit3 : a b f c X e g
5->2  edit3*: a b f c X e g
edit4* 5->2 : a b f c d X g
edit4  5->2*: a b f c d X g
5->2* edit4 : a b f c d X g
5->2  edit4*: a b f c d X g
edit5* 5->2 : a b X c d e g
edit5  5->2*: a b X c d e g
5->2* edit5 : a b X c d e g
5->2  edit5*: a b X c d e g
edit6* 5->2 : a b f c d e X
edit6  5->2*: a b f c d e X
5->2* edit6 : a b f c d e X
5->2  edit6*: a b f c d e X
edit0* 5->3 : X b c f d e g
edit0  5->3*: X b c f d e g
5->3* edit0 : X b c f d e g
5->3  edit0*: X b c f d e g
edit1* 5->3 : a X c f d e g
edit1  5->3*: a X c f d e g
5->3* edit1 : a X c f d e g
5->3  edit1*: a X c f d e g
edit2* 5->3 : a b X f d e g
edit2  5->3*: a b X f d e g
5->3* edit2 : a b X f d e g
5->3  edit2*: a b X f d e g
edit3* 5->3 : a b c f X e g
edit3  5->3*: a b c f X e g
5->3* edit3 : a b c f X e g
5->3  edit3*: a b c f X e g
edit4* 5->3 : a b c f d X g
edit4  5->3*: a b c f d X g
5->3* edit4 : a b c f d X g
5->3  edit4*: a b c f d X g
edit5* 5->3 : a b c X d e g
edit5  5->3*: a b c X d e g
5->3* edit5 : a b c X d e g
5->3  edit5*: a b c X d e g
edit6* 5->3 : a b c f d e X
edit6  5->3*: a b c f d e X
5->3* edit6 : a b c f d e X
5->3  edit6*: a b c f d e X
edit0* 5->4 : X b c d f e g
edit0  5->4*: X b c d f e g
5->4* edit0 : X b c d f e g
5->4  edit0*: X b c d f e g
edit1* 5->4 : a X c d f e g
edit1  5->4*: a X c d f e g
5->4* edit1 : a X c d f e g
5->4  edit1*: a X c d f e g
edit2* 5->4 : a b X d f e g
edit2  5->4*: a b X d f e g
5->4* edit2 : a b X d f e g
5->4  edit2*: a b X d f e g
edit3* 5->4 : a b c X f e g
edit3  5->4*: a b c X f e g
5->4* edit3 : a b c X f e g
5->4  edit3*: a b c X f e g
edit4* 5->4 : a b c d f X g
edit4  5->4*: a b c d f X g
5->4* edit4 : a b c d f X g
5->4  edit4*: a b c d f X g
edit5* 5->4 : a b c d X e g
edit5  5->4*: a b c d X e g
5->4* edit5 : a b c d X e g
5->4  edit5*: a b c d X e g
edit6* 5->4 : a b c d f e X
edit6  5->4*: a b c d f e X
5->4* edit6 : a b c d f e X
5->4  edit6*: a b c d f e X
edit0* 5->5 : X b c d e f g
edit0  5->5*: X b c d e f g
5->5* edit0 : X b c d e f g
5->5  edit0*: X b c d e f g
edit1* 5->5 : a X c d e f g
edit1  5->5*: a X c d e f g
5->5* edit1 : a X c d e f g
5->5  edit1*: a X c d e f g
edit2* 5->5 : a b X d e f g
edit2  5->5*: a b X d e f g
5->5* edit2 : a b X d e f g
5->5  edit2*: a b X d e f g
edit3* 5->5 : a b c X e f g
edit3  5->5*: a b c X e f g
5->5* edit3 : a b c X e f g
5->5  edit3*: a b c X e f g
edit4* 5->5 : a b c d X f g
edit4  5->5*: a b c d X f g
5->5* edit4 : a b c d X f g
5->5  edit4*: a b c d X f g
edit5* 5->5 : a b c d e X g
edit5  5->5*: a b c d e X g
5->5* edit5 : a b c d e X g
5->5  edit5*: a b c d e X g
edit6* 5->5 : a b c d e f X
edit6  5->5*: a b c d e f X
5->5* edit6 : a b c d e f X
5->5  edit6*: a b c d e f X
edit0* 5->6 : X b c d e f g
edit0  5->6*: X b c d e f g
5->6* edit0 : X b c d e f g
5->6  edit0*: X b c d e f g
edit1* 5->6 : a X c d e f g
edit1  5->6*: a X c d e f g
5->6* edit1 : a X c d e f g
5->6  edit1*: a X c d e f g
edit2* 5->6 : a b X d e f g
edit2  5->6*: a b X d e f g
5->6* edit2 : a b X d e f g
5->6  edit2*: a b X d e f g
edit3* 5->6 : a b c X e f g
edit3  5->6*: a b c X e f g
5->6* edit3 : a b c X e f g
5->6  edit3*: a b c X e f g
edit4* 5->6 : a b c d X f g
edit4  5->6*: a b c d X f g
5->6* edit4 : a b c d X f g
5->6  edit4*: a b c d X f g
edit5* 5->6 : a b c d e X g
edit5  5->6*: a b c d e X g
5->6* edit5 : a b c d e X g
5->6  edit5*: a b c d e X g
edit6* 5->6 : a b c d e f X
edit6  5->6*: a b c d e f X
5->6* edit6 : a b c d e f X
5->6  edit6*: a b c d e f X
edit0* 5->7 : X b c d e g f
edit0  5->7*: X b c d e g f
5->7* edit0 : X b c d e g f
5->7  edit0*: X b c d e g f
edit1* 5->7 : a X c d e g f
edit1  5->7*: a X c d e g f
5->7* edit1 : a X c d e g f
5->7  edit1*: a X c d e g f
edit2* 5->7 : a b X d e g f
edit2  5->7*: a b X d e g f
5->7* edit2 : a b X d e g f
5->7  edit2*: a b X d e g f
edit3* 5->7 : a b c X e g f
edit3  5->7*: a b c X e g f
5->7* edit3 : a b c X e g f
5->7  edit3*: a b c X e g f
edit4* 5->7 : a b c d X g f
edit4  5->7*: a b c d X g f
5->7* edit4 : a b c d X g f
5->7  edit4*: a b c d X g f
edit5* 5->7 : a b c d e g X
edit5  5->7*: a b c d e g X
5->7* edit5 : a b c d e g X
5->7  edit5*: a b c d e g X
edit6* 5->7 : a b c d e X f
edit6  5->7*: a b c d e X f
5->7* edit6 : a b c d e X f
5->7  edit6*: a b c d e X f
edit0* 6->0 : g X b c d e f
edit0  6->0*: g X b c d e f
6->0* edit0 : g X b c d e f
6->0  edit0*: g X b c d e f
edit1* 6->0 : g a X c d e f
edit1  6->0*: g a X c d e f
6->0* edit1 : g a X c d e f
6->0  edit1*: g a X c d e f
edit2* 6->0 : g a b X d e f
edit2  6->0*: g a b X d e f
6->0* edit2 : g a b X d e f
6->0  edit2*: g a b X d e f
edit3* 6->0 : g a b c X e f
edit3  6->0*: g a b c X e f
6->0* edit3 : g a b c X e f
6->0  edit3*: g a b c X e f
edit4* 6->0 : g a b c d X f
edit4  6->0*: g a b c d X f
6->0* edit4 : g a b c d X f
6->0  edit4*: g a b c d X f
edit5* 6->0 : g a b c d e X
edit5  6->0*: g a b c d e X
6->0* edit5 : g a b c d e X
6->0  edit5*: g a b c d e X
edit6* 6->0 : X a b c d e f
edit6  6->0*: X a b c d e f
6->0* edit6 : X a b c d e f
6->0  edit6*: X a b c d e f
edit0* 6->1 : X g b c d e f
edit0  6->1*: X g b c d e f
6->1* edit0 : X g b c d e f
6->1  edit0*: X g b c d e f
edit1* 6->1 : a g X c d e f
edit1  6->1*: a g X c d e f
6->1* edit1 : a g X c d e f
6->1  edit1*: a g X c d e f
edit2* 6->1 : a g b X d e f
edit2  6->1*: a g b X d e f
6->1* edit2 : a g b X d e f
6->1  edit2*: a g b X d e f
edit3* 6->1 : a g b c X e f
edit3  6->1*: a g b c X e f
6->1* edit3 : a g b c X e f
6->1  edit3*: a g b c X e f
edit4* 6->1 : a g b c d X f
edit4  6->1*: a g b c d X f
6->1* edit4 : a g b c d X f
6->1  edit4*: a g b c d X f
edit5* 6->1 : a g b c d e X
edit5  6->1*: a g b c d e X
6->1* edit5 : a g b c d e X
6->1  edit5*: a g b c d e X
edit6* 6->1 : a X b c d e f
edit6  6->1*: a X b c d e f
6->1* edit6 : a X b c d e f
6->1  edit6*: a X b c d e f
edit0* 6->2 : X b g c d e f
edit0  6->2*: X b g c d e f
6->2* edit0 : X b g c d e f
6->2  edit0*: X b g c d e f
edit1* 6->2 : a X g c d e f
edit1  6->2*: a X g c d e f
6->2* edit1 : a X g c d e f
6->2  edit1*: a X g c d e f
edit2* 6->2 : a b g X d e f
edit2  6->2*: a b g X d e f
6->2* edit2 : a b g X d e f
6->2  edit2*: a b g X d e f
edit3* 6->2 : a b g c X e f
edit3  6->2*: a b g c X e f
6->2* edit3 : a b g c X e f
6->2  edit3*: a b g c X e f
edit4* 6->2 : a b g c d X f
edit4  6->2*: a b g c d X f
6->2* edit4 : a b g c d X f
6->2  edit4*: a b g c d X f
edit5* 6->2 : a b g c d e X
edit5  6->2*: a b g c d e X
6->2* edit5 : a b g c d e X
6->2  edit5*: a b g c d e X
edit6* 6->2 : a b X c d e f
edit6  6->2*: a b X c d e f
6->2* edit6 : a b X c d e f
6->2  edit6*: a b X c d e f
edit0* 6->3 : X b c g d e f
edit0  6->3*: X b c g d e f
6->3* edit0 : X b c g d e f
6->3  edit0*: X b c g d e f
edit1* 6->3 : a X c g d e f
edit1  6->3*: a X c g d e f
6->3* edit1 : a X c g d e f
6->3  edit1*: a X c g d e f
edit2* 6->3 : a b X g d e f
edit2  6->3*: a b X g d e f
6->3* edit2 : a b X g d e f
6->3  edit2*: a b X g d e f
edit3* 6->3 : a b c g X e f
edit3  6->3*: a b c g X e f
6->3* edit3 : a b c g X e f
6->3  edit3*: a b c g X e f
edit4* 6->3 : a b c g d X f
edit4  6->3*: a b c g d X f
6->3* edit4 : a b c g d X f
6->3  edit4*: a b c g d X f
edit5* 6->3 : a b c g d e X
edit5  6->3*: a b c g d e X
6->3* edit5 : a b c g d e X
6->3  edit5*: a b c g d e X
edit6* 6->3 : a b c X d e f
edit6  6->3*: a b c X d e f
6->3* edit6 : a b c X d e f
6->3  edit6*: a b c X d e f
edit0* 6->4 : X b c d g e f
edit0  6->4*: X b c d g e f
6->4* edit0 : X b c d g e f
6->4  edit0*: X b c d g e f
edit1* 6->4 : a X c d g e f
edit1  6->4*: a X c d g e f
6->4* edit1 : a X c d g e f
6->4  edit1*: a X c d g e f
edit2* 6->4 : a b X d g e f
edit2  6->4*: a b X d g e f
6->4* edit2 : a b X d g e f
6->4  edit2*: a b X d g e f
edit3* 6->4 : a b c X g e f
edit3  6->4*: a b c X g e f
6->4* edit3 : a b c X g e f
6->4  edit3*: a b c X g e f
edit4* 6->4 : a b c d g X f
edit4  6->4*: a b c d g X f
6->4* edit4 : a b c d g X f
6->4  edit4*: a b c d g X f
edit5* 6->4 : a b c d g e X
edit5  6->4*: a b c d g e X
6->4* edit5 : a b c d g e X
6->4  edit5*: a b c d g e X
edit6* 6->4 : a b c d X e f
edit6  6->4*: a b c d X e f
6->4* edit6 : a b c d X e f
6->4  edit6*: a b c d X e f
edit0* 6->5 : X b c d e g f
edit0  6->5*: X b c d e g f
6->5* edit0 : X b c d e g f
6->5  edit0*: X b c d e g f
edit1* 6->5 : a X c d e g f
edit1  6->5*: a X c d e g f
6->5* edit1 : a X c d e g f
6->5  edit1*: a X c d e g f
edit2* 6->5 : a b X d e g f
edit2  6->5*: a b X d e g f
6->5* edit2 : a b X d e g f
6->5  edit2*: a b X d e g f
edit3* 6->5 : a b c X e g f
edit3  6->5*: a b c X e g f
6->5* edit3 : a b c X e g f
6->5  edit3*: a b c X e g f
edit4* 6->5 : a b c d X g f
edit4  6->5*: a b c d X g f
6->5* edit4 : a b c d X g f
6->5  edit4*: a b c d X g f
edit5* 6->5 : a b c d e g X
edit5  6->5*: a b c d e g X
6->5* edit5 : a b c d e g X
6->5  edit5*: a b c d e g X
edit6* 6->5 : a b c d e X f
edit6  6->5*: a b c d e X f
6->5* edit6 : a b c d e X f
6->5  edit6*: a b c d e X f
edit0* 6->6 : X b c d e f g
edit0  6->6*: X b c d e f g
6->6* edit0 : X b c d e f g
6->6  edit0*: X b c d e f g
edit1* 6->6 : a X c d e f g
edit1  6->6*: a X c d e f g
6->6* edit1 : a X c d e f g
6->6  edit1*: a X c d e f g
edit2* 6->6 : a b X d e f g
edit2  6->6*: a b X d e f g
6->6* edit2 : a b X d e f g
6->6  edit2*: a b X d e f g
edit3* 6->6 : a b c X e f g
edit3  6->6*: a b c X e f g
6->6* edit3 : a b c X e f g
6->6  edit3*: a b c X e f g
edit4* 6->6 : a b c d X f g
edit4  6->6*: a b c d X f g
6->6* edit4 : a b c d X f g
6->6  edit4*: a b c d X f g
edit5* 6->6 : a b c d e X g
edit5  6->6*: a b c d e X g
6->6* edit5 : a b c d e X g
6->6  edit5*: a b c d e X g
edit6* 6->6 : a b c d e f X
edit6  6->6*: a b c d e f X
6->6* edit6 : a b c d e f X
6->6  edit6*: a b c d e f X
edit0* 6->7 : X b c d e f g
edit0  6->7*: X b c d e f g
6->7* edit0 : X b c d e f g
6->7  edit0*: X b c d e f g
edit1* 6->7 : a X c d e f g
edit1  6->7*: a X c d e f g
6->7* edit1 : a X c d e f g
6->7  edit1*: a X c d e f g
edit2* 6->7 : a b X d e f g
edit2  6->7*: a b X d e f g
6->7* edit2 : a b X d e f g
6->7  edit2*: a b X d e f g
edit3* 6->7 : a b c X e f g
edit3  6->7*: a b c X e f g
6->7* edit3 : a b c X e f g
6->7  edit3*: a b c X e f g
edit4* 6->7 : a b c d X f g
edit4  6->7*: a b c d X f g
6->7* edit4 : a b c d X f g
6->7  edit4*: a b c d X f g
edit5* 6->7 : a b c d e X g
edit5  6->7*: a b c d e X g
6->7* edit5 : a b c d e X g
6->7  edit5*: a b c d e X g
edit6* 6->7 : a b c d e f X
edit6  6->7*: a b c d e f X
6->7* edit6 : a b c d e f X
6->7  edit6*: a b c d e f X''';

const expectedTestTransformMoveSet = '''
set0* 0->0 : X b c d e f g
set0  0->0*: X b c d e f g
0->0* set0 : X b c d e f g
0->0  set0*: X b c d e f g
set1* 0->0 : a X c d e f g
set1  0->0*: a X c d e f g
0->0* set1 : a X c d e f g
0->0  set1*: a X c d e f g
set2* 0->0 : a b X d e f g
set2  0->0*: a b X d e f g
0->0* set2 : a b X d e f g
0->0  set2*: a b X d e f g
set3* 0->0 : a b c X e f g
set3  0->0*: a b c X e f g
0->0* set3 : a b c X e f g
0->0  set3*: a b c X e f g
set4* 0->0 : a b c d X f g
set4  0->0*: a b c d X f g
0->0* set4 : a b c d X f g
0->0  set4*: a b c d X f g
set5* 0->0 : a b c d e X g
set5  0->0*: a b c d e X g
0->0* set5 : a b c d e X g
0->0  set5*: a b c d e X g
set6* 0->0 : a b c d e f X
set6  0->0*: a b c d e f X
0->0* set6 : a b c d e f X
0->0  set6*: a b c d e f X
set0* 0->1 : X b c d e f g
set0  0->1*: X b c d e f g
0->1* set0 : X b c d e f g
0->1  set0*: X b c d e f g
set1* 0->1 : a X c d e f g
set1  0->1*: a X c d e f g
0->1* set1 : a X c d e f g
0->1  set1*: a X c d e f g
set2* 0->1 : a b X d e f g
set2  0->1*: a b X d e f g
0->1* set2 : a b X d e f g
0->1  set2*: a b X d e f g
set3* 0->1 : a b c X e f g
set3  0->1*: a b c X e f g
0->1* set3 : a b c X e f g
0->1  set3*: a b c X e f g
set4* 0->1 : a b c d X f g
set4  0->1*: a b c d X f g
0->1* set4 : a b c d X f g
0->1  set4*: a b c d X f g
set5* 0->1 : a b c d e X g
set5  0->1*: a b c d e X g
0->1* set5 : a b c d e X g
0->1  set5*: a b c d e X g
set6* 0->1 : a b c d e f X
set6  0->1*: a b c d e f X
0->1* set6 : a b c d e f X
0->1  set6*: a b c d e f X
set0* 0->2 : b X c d e f g
set0  0->2*: b X c d e f g
0->2* set0 : b X c d e f g
0->2  set0*: b X c d e f g
set1* 0->2 : X a c d e f g
set1  0->2*: X a c d e f g
0->2* set1 : X a c d e f g
0->2  set1*: X a c d e f g
set2* 0->2 : b a X d e f g
set2  0->2*: b a X d e f g
0->2* set2 : b a X d e f g
0->2  set2*: b a X d e f g
set3* 0->2 : b a c X e f g
set3  0->2*: b a c X e f g
0->2* set3 : b a c X e f g
0->2  set3*: b a c X e f g
set4* 0->2 : b a c d X f g
set4  0->2*: b a c d X f g
0->2* set4 : b a c d X f g
0->2  set4*: b a c d X f g
set5* 0->2 : b a c d e X g
set5  0->2*: b a c d e X g
0->2* set5 : b a c d e X g
0->2  set5*: b a c d e X g
set6* 0->2 : b a c d e f X
set6  0->2*: b a c d e f X
0->2* set6 : b a c d e f X
0->2  set6*: b a c d e f X
set0* 0->3 : b c X d e f g
set0  0->3*: b c X d e f g
0->3* set0 : b c X d e f g
0->3  set0*: b c X d e f g
set1* 0->3 : X c a d e f g
set1  0->3*: X c a d e f g
0->3* set1 : X c a d e f g
0->3  set1*: X c a d e f g
set2* 0->3 : b X a d e f g
set2  0->3*: b X a d e f g
0->3* set2 : b X a d e f g
0->3  set2*: b X a d e f g
set3* 0->3 : b c a X e f g
set3  0->3*: b c a X e f g
0->3* set3 : b c a X e f g
0->3  set3*: b c a X e f g
set4* 0->3 : b c a d X f g
set4  0->3*: b c a d X f g
0->3* set4 : b c a d X f g
0->3  set4*: b c a d X f g
set5* 0->3 : b c a d e X g
set5  0->3*: b c a d e X g
0->3* set5 : b c a d e X g
0->3  set5*: b c a d e X g
set6* 0->3 : b c a d e f X
set6  0->3*: b c a d e f X
0->3* set6 : b c a d e f X
0->3  set6*: b c a d e f X
set0* 0->4 : b c d X e f g
set0  0->4*: b c d X e f g
0->4* set0 : b c d X e f g
0->4  set0*: b c d X e f g
set1* 0->4 : X c d a e f g
set1  0->4*: X c d a e f g
0->4* set1 : X c d a e f g
0->4  set1*: X c d a e f g
set2* 0->4 : b X d a e f g
set2  0->4*: b X d a e f g
0->4* set2 : b X d a e f g
0->4  set2*: b X d a e f g
set3* 0->4 : b c X a e f g
set3  0->4*: b c X a e f g
0->4* set3 : b c X a e f g
0->4  set3*: b c X a e f g
set4* 0->4 : b c d a X f g
set4  0->4*: b c d a X f g
0->4* set4 : b c d a X f g
0->4  set4*: b c d a X f g
set5* 0->4 : b c d a e X g
set5  0->4*: b c d a e X g
0->4* set5 : b c d a e X g
0->4  set5*: b c d a e X g
set6* 0->4 : b c d a e f X
set6  0->4*: b c d a e f X
0->4* set6 : b c d a e f X
0->4  set6*: b c d a e f X
set0* 0->5 : b c d e X f g
set0  0->5*: b c d e X f g
0->5* set0 : b c d e X f g
0->5  set0*: b c d e X f g
set1* 0->5 : X c d e a f g
set1  0->5*: X c d e a f g
0->5* set1 : X c d e a f g
0->5  set1*: X c d e a f g
set2* 0->5 : b X d e a f g
set2  0->5*: b X d e a f g
0->5* set2 : b X d e a f g
0->5  set2*: b X d e a f g
set3* 0->5 : b c X e a f g
set3  0->5*: b c X e a f g
0->5* set3 : b c X e a f g
0->5  set3*: b c X e a f g
set4* 0->5 : b c d X a f g
set4  0->5*: b c d X a f g
0->5* set4 : b c d X a f g
0->5  set4*: b c d X a f g
set5* 0->5 : b c d e a X g
set5  0->5*: b c d e a X g
0->5* set5 : b c d e a X g
0->5  set5*: b c d e a X g
set6* 0->5 : b c d e a f X
set6  0->5*: b c d e a f X
0->5* set6 : b c d e a f X
0->5  set6*: b c d e a f X
set0* 0->6 : b c d e f X g
set0  0->6*: b c d e f X g
0->6* set0 : b c d e f X g
0->6  set0*: b c d e f X g
set1* 0->6 : X c d e f a g
set1  0->6*: X c d e f a g
0->6* set1 : X c d e f a g
0->6  set1*: X c d e f a g
set2* 0->6 : b X d e f a g
set2  0->6*: b X d e f a g
0->6* set2 : b X d e f a g
0->6  set2*: b X d e f a g
set3* 0->6 : b c X e f a g
set3  0->6*: b c X e f a g
0->6* set3 : b c X e f a g
0->6  set3*: b c X e f a g
set4* 0->6 : b c d X f a g
set4  0->6*: b c d X f a g
0->6* set4 : b c d X f a g
0->6  set4*: b c d X f a g
set5* 0->6 : b c d e X a g
set5  0->6*: b c d e X a g
0->6* set5 : b c d e X a g
0->6  set5*: b c d e X a g
set6* 0->6 : b c d e f a X
set6  0->6*: b c d e f a X
0->6* set6 : b c d e f a X
0->6  set6*: b c d e f a X
set0* 0->7 : b c d e f g X
set0  0->7*: b c d e f g X
0->7* set0 : b c d e f g X
0->7  set0*: b c d e f g X
set1* 0->7 : X c d e f g a
set1  0->7*: X c d e f g a
0->7* set1 : X c d e f g a
0->7  set1*: X c d e f g a
set2* 0->7 : b X d e f g a
set2  0->7*: b X d e f g a
0->7* set2 : b X d e f g a
0->7  set2*: b X d e f g a
set3* 0->7 : b c X e f g a
set3  0->7*: b c X e f g a
0->7* set3 : b c X e f g a
0->7  set3*: b c X e f g a
set4* 0->7 : b c d X f g a
set4  0->7*: b c d X f g a
0->7* set4 : b c d X f g a
0->7  set4*: b c d X f g a
set5* 0->7 : b c d e X g a
set5  0->7*: b c d e X g a
0->7* set5 : b c d e X g a
0->7  set5*: b c d e X g a
set6* 0->7 : b c d e f X a
set6  0->7*: b c d e f X a
0->7* set6 : b c d e f X a
0->7  set6*: b c d e f X a
set0* 1->0 : b X c d e f g
set0  1->0*: b X c d e f g
1->0* set0 : b X c d e f g
1->0  set0*: b X c d e f g
set1* 1->0 : X a c d e f g
set1  1->0*: X a c d e f g
1->0* set1 : X a c d e f g
1->0  set1*: X a c d e f g
set2* 1->0 : b a X d e f g
set2  1->0*: b a X d e f g
1->0* set2 : b a X d e f g
1->0  set2*: b a X d e f g
set3* 1->0 : b a c X e f g
set3  1->0*: b a c X e f g
1->0* set3 : b a c X e f g
1->0  set3*: b a c X e f g
set4* 1->0 : b a c d X f g
set4  1->0*: b a c d X f g
1->0* set4 : b a c d X f g
1->0  set4*: b a c d X f g
set5* 1->0 : b a c d e X g
set5  1->0*: b a c d e X g
1->0* set5 : b a c d e X g
1->0  set5*: b a c d e X g
set6* 1->0 : b a c d e f X
set6  1->0*: b a c d e f X
1->0* set6 : b a c d e f X
1->0  set6*: b a c d e f X
set0* 1->1 : X b c d e f g
set0  1->1*: X b c d e f g
1->1* set0 : X b c d e f g
1->1  set0*: X b c d e f g
set1* 1->1 : a X c d e f g
set1  1->1*: a X c d e f g
1->1* set1 : a X c d e f g
1->1  set1*: a X c d e f g
set2* 1->1 : a b X d e f g
set2  1->1*: a b X d e f g
1->1* set2 : a b X d e f g
1->1  set2*: a b X d e f g
set3* 1->1 : a b c X e f g
set3  1->1*: a b c X e f g
1->1* set3 : a b c X e f g
1->1  set3*: a b c X e f g
set4* 1->1 : a b c d X f g
set4  1->1*: a b c d X f g
1->1* set4 : a b c d X f g
1->1  set4*: a b c d X f g
set5* 1->1 : a b c d e X g
set5  1->1*: a b c d e X g
1->1* set5 : a b c d e X g
1->1  set5*: a b c d e X g
set6* 1->1 : a b c d e f X
set6  1->1*: a b c d e f X
1->1* set6 : a b c d e f X
1->1  set6*: a b c d e f X
set0* 1->2 : X b c d e f g
set0  1->2*: X b c d e f g
1->2* set0 : X b c d e f g
1->2  set0*: X b c d e f g
set1* 1->2 : a X c d e f g
set1  1->2*: a X c d e f g
1->2* set1 : a X c d e f g
1->2  set1*: a X c d e f g
set2* 1->2 : a b X d e f g
set2  1->2*: a b X d e f g
1->2* set2 : a b X d e f g
1->2  set2*: a b X d e f g
set3* 1->2 : a b c X e f g
set3  1->2*: a b c X e f g
1->2* set3 : a b c X e f g
1->2  set3*: a b c X e f g
set4* 1->2 : a b c d X f g
set4  1->2*: a b c d X f g
1->2* set4 : a b c d X f g
1->2  set4*: a b c d X f g
set5* 1->2 : a b c d e X g
set5  1->2*: a b c d e X g
1->2* set5 : a b c d e X g
1->2  set5*: a b c d e X g
set6* 1->2 : a b c d e f X
set6  1->2*: a b c d e f X
1->2* set6 : a b c d e f X
1->2  set6*: a b c d e f X
set0* 1->3 : X c b d e f g
set0  1->3*: X c b d e f g
1->3* set0 : X c b d e f g
1->3  set0*: X c b d e f g
set1* 1->3 : a c X d e f g
set1  1->3*: a c X d e f g
1->3* set1 : a c X d e f g
1->3  set1*: a c X d e f g
set2* 1->3 : a X b d e f g
set2  1->3*: a X b d e f g
1->3* set2 : a X b d e f g
1->3  set2*: a X b d e f g
set3* 1->3 : a c b X e f g
set3  1->3*: a c b X e f g
1->3* set3 : a c b X e f g
1->3  set3*: a c b X e f g
set4* 1->3 : a c b d X f g
set4  1->3*: a c b d X f g
1->3* set4 : a c b d X f g
1->3  set4*: a c b d X f g
set5* 1->3 : a c b d e X g
set5  1->3*: a c b d e X g
1->3* set5 : a c b d e X g
1->3  set5*: a c b d e X g
set6* 1->3 : a c b d e f X
set6  1->3*: a c b d e f X
1->3* set6 : a c b d e f X
1->3  set6*: a c b d e f X
set0* 1->4 : X c d b e f g
set0  1->4*: X c d b e f g
1->4* set0 : X c d b e f g
1->4  set0*: X c d b e f g
set1* 1->4 : a c d X e f g
set1  1->4*: a c d X e f g
1->4* set1 : a c d X e f g
1->4  set1*: a c d X e f g
set2* 1->4 : a X d b e f g
set2  1->4*: a X d b e f g
1->4* set2 : a X d b e f g
1->4  set2*: a X d b e f g
set3* 1->4 : a c X b e f g
set3  1->4*: a c X b e f g
1->4* set3 : a c X b e f g
1->4  set3*: a c X b e f g
set4* 1->4 : a c d b X f g
set4  1->4*: a c d b X f g
1->4* set4 : a c d b X f g
1->4  set4*: a c d b X f g
set5* 1->4 : a c d b e X g
set5  1->4*: a c d b e X g
1->4* set5 : a c d b e X g
1->4  set5*: a c d b e X g
set6* 1->4 : a c d b e f X
set6  1->4*: a c d b e f X
1->4* set6 : a c d b e f X
1->4  set6*: a c d b e f X
set0* 1->5 : X c d e b f g
set0  1->5*: X c d e b f g
1->5* set0 : X c d e b f g
1->5  set0*: X c d e b f g
set1* 1->5 : a c d e X f g
set1  1->5*: a c d e X f g
1->5* set1 : a c d e X f g
1->5  set1*: a c d e X f g
set2* 1->5 : a X d e b f g
set2  1->5*: a X d e b f g
1->5* set2 : a X d e b f g
1->5  set2*: a X d e b f g
set3* 1->5 : a c X e b f g
set3  1->5*: a c X e b f g
1->5* set3 : a c X e b f g
1->5  set3*: a c X e b f g
set4* 1->5 : a c d X b f g
set4  1->5*: a c d X b f g
1->5* set4 : a c d X b f g
1->5  set4*: a c d X b f g
set5* 1->5 : a c d e b X g
set5  1->5*: a c d e b X g
1->5* set5 : a c d e b X g
1->5  set5*: a c d e b X g
set6* 1->5 : a c d e b f X
set6  1->5*: a c d e b f X
1->5* set6 : a c d e b f X
1->5  set6*: a c d e b f X
set0* 1->6 : X c d e f b g
set0  1->6*: X c d e f b g
1->6* set0 : X c d e f b g
1->6  set0*: X c d e f b g
set1* 1->6 : a c d e f X g
set1  1->6*: a c d e f X g
1->6* set1 : a c d e f X g
1->6  set1*: a c d e f X g
set2* 1->6 : a X d e f b g
set2  1->6*: a X d e f b g
1->6* set2 : a X d e f b g
1->6  set2*: a X d e f b g
set3* 1->6 : a c X e f b g
set3  1->6*: a c X e f b g
1->6* set3 : a c X e f b g
1->6  set3*: a c X e f b g
set4* 1->6 : a c d X f b g
set4  1->6*: a c d X f b g
1->6* set4 : a c d X f b g
1->6  set4*: a c d X f b g
set5* 1->6 : a c d e X b g
set5  1->6*: a c d e X b g
1->6* set5 : a c d e X b g
1->6  set5*: a c d e X b g
set6* 1->6 : a c d e f b X
set6  1->6*: a c d e f b X
1->6* set6 : a c d e f b X
1->6  set6*: a c d e f b X
set0* 1->7 : X c d e f g b
set0  1->7*: X c d e f g b
1->7* set0 : X c d e f g b
1->7  set0*: X c d e f g b
set1* 1->7 : a c d e f g X
set1  1->7*: a c d e f g X
1->7* set1 : a c d e f g X
1->7  set1*: a c d e f g X
set2* 1->7 : a X d e f g b
set2  1->7*: a X d e f g b
1->7* set2 : a X d e f g b
1->7  set2*: a X d e f g b
set3* 1->7 : a c X e f g b
set3  1->7*: a c X e f g b
1->7* set3 : a c X e f g b
1->7  set3*: a c X e f g b
set4* 1->7 : a c d X f g b
set4  1->7*: a c d X f g b
1->7* set4 : a c d X f g b
1->7  set4*: a c d X f g b
set5* 1->7 : a c d e X g b
set5  1->7*: a c d e X g b
1->7* set5 : a c d e X g b
1->7  set5*: a c d e X g b
set6* 1->7 : a c d e f X b
set6  1->7*: a c d e f X b
1->7* set6 : a c d e f X b
1->7  set6*: a c d e f X b
set0* 2->0 : c X b d e f g
set0  2->0*: c X b d e f g
2->0* set0 : c X b d e f g
2->0  set0*: c X b d e f g
set1* 2->0 : c a X d e f g
set1  2->0*: c a X d e f g
2->0* set1 : c a X d e f g
2->0  set1*: c a X d e f g
set2* 2->0 : X a b d e f g
set2  2->0*: X a b d e f g
2->0* set2 : X a b d e f g
2->0  set2*: X a b d e f g
set3* 2->0 : c a b X e f g
set3  2->0*: c a b X e f g
2->0* set3 : c a b X e f g
2->0  set3*: c a b X e f g
set4* 2->0 : c a b d X f g
set4  2->0*: c a b d X f g
2->0* set4 : c a b d X f g
2->0  set4*: c a b d X f g
set5* 2->0 : c a b d e X g
set5  2->0*: c a b d e X g
2->0* set5 : c a b d e X g
2->0  set5*: c a b d e X g
set6* 2->0 : c a b d e f X
set6  2->0*: c a b d e f X
2->0* set6 : c a b d e f X
2->0  set6*: c a b d e f X
set0* 2->1 : X c b d e f g
set0  2->1*: X c b d e f g
2->1* set0 : X c b d e f g
2->1  set0*: X c b d e f g
set1* 2->1 : a c X d e f g
set1  2->1*: a c X d e f g
2->1* set1 : a c X d e f g
2->1  set1*: a c X d e f g
set2* 2->1 : a X b d e f g
set2  2->1*: a X b d e f g
2->1* set2 : a X b d e f g
2->1  set2*: a X b d e f g
set3* 2->1 : a c b X e f g
set3  2->1*: a c b X e f g
2->1* set3 : a c b X e f g
2->1  set3*: a c b X e f g
set4* 2->1 : a c b d X f g
set4  2->1*: a c b d X f g
2->1* set4 : a c b d X f g
2->1  set4*: a c b d X f g
set5* 2->1 : a c b d e X g
set5  2->1*: a c b d e X g
2->1* set5 : a c b d e X g
2->1  set5*: a c b d e X g
set6* 2->1 : a c b d e f X
set6  2->1*: a c b d e f X
2->1* set6 : a c b d e f X
2->1  set6*: a c b d e f X
set0* 2->2 : X b c d e f g
set0  2->2*: X b c d e f g
2->2* set0 : X b c d e f g
2->2  set0*: X b c d e f g
set1* 2->2 : a X c d e f g
set1  2->2*: a X c d e f g
2->2* set1 : a X c d e f g
2->2  set1*: a X c d e f g
set2* 2->2 : a b X d e f g
set2  2->2*: a b X d e f g
2->2* set2 : a b X d e f g
2->2  set2*: a b X d e f g
set3* 2->2 : a b c X e f g
set3  2->2*: a b c X e f g
2->2* set3 : a b c X e f g
2->2  set3*: a b c X e f g
set4* 2->2 : a b c d X f g
set4  2->2*: a b c d X f g
2->2* set4 : a b c d X f g
2->2  set4*: a b c d X f g
set5* 2->2 : a b c d e X g
set5  2->2*: a b c d e X g
2->2* set5 : a b c d e X g
2->2  set5*: a b c d e X g
set6* 2->2 : a b c d e f X
set6  2->2*: a b c d e f X
2->2* set6 : a b c d e f X
2->2  set6*: a b c d e f X
set0* 2->3 : X b c d e f g
set0  2->3*: X b c d e f g
2->3* set0 : X b c d e f g
2->3  set0*: X b c d e f g
set1* 2->3 : a X c d e f g
set1  2->3*: a X c d e f g
2->3* set1 : a X c d e f g
2->3  set1*: a X c d e f g
set2* 2->3 : a b X d e f g
set2  2->3*: a b X d e f g
2->3* set2 : a b X d e f g
2->3  set2*: a b X d e f g
set3* 2->3 : a b c X e f g
set3  2->3*: a b c X e f g
2->3* set3 : a b c X e f g
2->3  set3*: a b c X e f g
set4* 2->3 : a b c d X f g
set4  2->3*: a b c d X f g
2->3* set4 : a b c d X f g
2->3  set4*: a b c d X f g
set5* 2->3 : a b c d e X g
set5  2->3*: a b c d e X g
2->3* set5 : a b c d e X g
2->3  set5*: a b c d e X g
set6* 2->3 : a b c d e f X
set6  2->3*: a b c d e f X
2->3* set6 : a b c d e f X
2->3  set6*: a b c d e f X
set0* 2->4 : X b d c e f g
set0  2->4*: X b d c e f g
2->4* set0 : X b d c e f g
2->4  set0*: X b d c e f g
set1* 2->4 : a X d c e f g
set1  2->4*: a X d c e f g
2->4* set1 : a X d c e f g
2->4  set1*: a X d c e f g
set2* 2->4 : a b d X e f g
set2  2->4*: a b d X e f g
2->4* set2 : a b d X e f g
2->4  set2*: a b d X e f g
set3* 2->4 : a b X c e f g
set3  2->4*: a b X c e f g
2->4* set3 : a b X c e f g
2->4  set3*: a b X c e f g
set4* 2->4 : a b d c X f g
set4  2->4*: a b d c X f g
2->4* set4 : a b d c X f g
2->4  set4*: a b d c X f g
set5* 2->4 : a b d c e X g
set5  2->4*: a b d c e X g
2->4* set5 : a b d c e X g
2->4  set5*: a b d c e X g
set6* 2->4 : a b d c e f X
set6  2->4*: a b d c e f X
2->4* set6 : a b d c e f X
2->4  set6*: a b d c e f X
set0* 2->5 : X b d e c f g
set0  2->5*: X b d e c f g
2->5* set0 : X b d e c f g
2->5  set0*: X b d e c f g
set1* 2->5 : a X d e c f g
set1  2->5*: a X d e c f g
2->5* set1 : a X d e c f g
2->5  set1*: a X d e c f g
set2* 2->5 : a b d e X f g
set2  2->5*: a b d e X f g
2->5* set2 : a b d e X f g
2->5  set2*: a b d e X f g
set3* 2->5 : a b X e c f g
set3  2->5*: a b X e c f g
2->5* set3 : a b X e c f g
2->5  set3*: a b X e c f g
set4* 2->5 : a b d X c f g
set4  2->5*: a b d X c f g
2->5* set4 : a b d X c f g
2->5  set4*: a b d X c f g
set5* 2->5 : a b d e c X g
set5  2->5*: a b d e c X g
2->5* set5 : a b d e c X g
2->5  set5*: a b d e c X g
set6* 2->5 : a b d e c f X
set6  2->5*: a b d e c f X
2->5* set6 : a b d e c f X
2->5  set6*: a b d e c f X
set0* 2->6 : X b d e f c g
set0  2->6*: X b d e f c g
2->6* set0 : X b d e f c g
2->6  set0*: X b d e f c g
set1* 2->6 : a X d e f c g
set1  2->6*: a X d e f c g
2->6* set1 : a X d e f c g
2->6  set1*: a X d e f c g
set2* 2->6 : a b d e f X g
set2  2->6*: a b d e f X g
2->6* set2 : a b d e f X g
2->6  set2*: a b d e f X g
set3* 2->6 : a b X e f c g
set3  2->6*: a b X e f c g
2->6* set3 : a b X e f c g
2->6  set3*: a b X e f c g
set4* 2->6 : a b d X f c g
set4  2->6*: a b d X f c g
2->6* set4 : a b d X f c g
2->6  set4*: a b d X f c g
set5* 2->6 : a b d e X c g
set5  2->6*: a b d e X c g
2->6* set5 : a b d e X c g
2->6  set5*: a b d e X c g
set6* 2->6 : a b d e f c X
set6  2->6*: a b d e f c X
2->6* set6 : a b d e f c X
2->6  set6*: a b d e f c X
set0* 2->7 : X b d e f g c
set0  2->7*: X b d e f g c
2->7* set0 : X b d e f g c
2->7  set0*: X b d e f g c
set1* 2->7 : a X d e f g c
set1  2->7*: a X d e f g c
2->7* set1 : a X d e f g c
2->7  set1*: a X d e f g c
set2* 2->7 : a b d e f g X
set2  2->7*: a b d e f g X
2->7* set2 : a b d e f g X
2->7  set2*: a b d e f g X
set3* 2->7 : a b X e f g c
set3  2->7*: a b X e f g c
2->7* set3 : a b X e f g c
2->7  set3*: a b X e f g c
set4* 2->7 : a b d X f g c
set4  2->7*: a b d X f g c
2->7* set4 : a b d X f g c
2->7  set4*: a b d X f g c
set5* 2->7 : a b d e X g c
set5  2->7*: a b d e X g c
2->7* set5 : a b d e X g c
2->7  set5*: a b d e X g c
set6* 2->7 : a b d e f X c
set6  2->7*: a b d e f X c
2->7* set6 : a b d e f X c
2->7  set6*: a b d e f X c
set0* 3->0 : d X b c e f g
set0  3->0*: d X b c e f g
3->0* set0 : d X b c e f g
3->0  set0*: d X b c e f g
set1* 3->0 : d a X c e f g
set1  3->0*: d a X c e f g
3->0* set1 : d a X c e f g
3->0  set1*: d a X c e f g
set2* 3->0 : d a b X e f g
set2  3->0*: d a b X e f g
3->0* set2 : d a b X e f g
3->0  set2*: d a b X e f g
set3* 3->0 : X a b c e f g
set3  3->0*: X a b c e f g
3->0* set3 : X a b c e f g
3->0  set3*: X a b c e f g
set4* 3->0 : d a b c X f g
set4  3->0*: d a b c X f g
3->0* set4 : d a b c X f g
3->0  set4*: d a b c X f g
set5* 3->0 : d a b c e X g
set5  3->0*: d a b c e X g
3->0* set5 : d a b c e X g
3->0  set5*: d a b c e X g
set6* 3->0 : d a b c e f X
set6  3->0*: d a b c e f X
3->0* set6 : d a b c e f X
3->0  set6*: d a b c e f X
set0* 3->1 : X d b c e f g
set0  3->1*: X d b c e f g
3->1* set0 : X d b c e f g
3->1  set0*: X d b c e f g
set1* 3->1 : a d X c e f g
set1  3->1*: a d X c e f g
3->1* set1 : a d X c e f g
3->1  set1*: a d X c e f g
set2* 3->1 : a d b X e f g
set2  3->1*: a d b X e f g
3->1* set2 : a d b X e f g
3->1  set2*: a d b X e f g
set3* 3->1 : a X b c e f g
set3  3->1*: a X b c e f g
3->1* set3 : a X b c e f g
3->1  set3*: a X b c e f g
set4* 3->1 : a d b c X f g
set4  3->1*: a d b c X f g
3->1* set4 : a d b c X f g
3->1  set4*: a d b c X f g
set5* 3->1 : a d b c e X g
set5  3->1*: a d b c e X g
3->1* set5 : a d b c e X g
3->1  set5*: a d b c e X g
set6* 3->1 : a d b c e f X
set6  3->1*: a d b c e f X
3->1* set6 : a d b c e f X
3->1  set6*: a d b c e f X
set0* 3->2 : X b d c e f g
set0  3->2*: X b d c e f g
3->2* set0 : X b d c e f g
3->2  set0*: X b d c e f g
set1* 3->2 : a X d c e f g
set1  3->2*: a X d c e f g
3->2* set1 : a X d c e f g
3->2  set1*: a X d c e f g
set2* 3->2 : a b d X e f g
set2  3->2*: a b d X e f g
3->2* set2 : a b d X e f g
3->2  set2*: a b d X e f g
set3* 3->2 : a b X c e f g
set3  3->2*: a b X c e f g
3->2* set3 : a b X c e f g
3->2  set3*: a b X c e f g
set4* 3->2 : a b d c X f g
set4  3->2*: a b d c X f g
3->2* set4 : a b d c X f g
3->2  set4*: a b d c X f g
set5* 3->2 : a b d c e X g
set5  3->2*: a b d c e X g
3->2* set5 : a b d c e X g
3->2  set5*: a b d c e X g
set6* 3->2 : a b d c e f X
set6  3->2*: a b d c e f X
3->2* set6 : a b d c e f X
3->2  set6*: a b d c e f X
set0* 3->3 : X b c d e f g
set0  3->3*: X b c d e f g
3->3* set0 : X b c d e f g
3->3  set0*: X b c d e f g
set1* 3->3 : a X c d e f g
set1  3->3*: a X c d e f g
3->3* set1 : a X c d e f g
3->3  set1*: a X c d e f g
set2* 3->3 : a b X d e f g
set2  3->3*: a b X d e f g
3->3* set2 : a b X d e f g
3->3  set2*: a b X d e f g
set3* 3->3 : a b c X e f g
set3  3->3*: a b c X e f g
3->3* set3 : a b c X e f g
3->3  set3*: a b c X e f g
set4* 3->3 : a b c d X f g
set4  3->3*: a b c d X f g
3->3* set4 : a b c d X f g
3->3  set4*: a b c d X f g
set5* 3->3 : a b c d e X g
set5  3->3*: a b c d e X g
3->3* set5 : a b c d e X g
3->3  set5*: a b c d e X g
set6* 3->3 : a b c d e f X
set6  3->3*: a b c d e f X
3->3* set6 : a b c d e f X
3->3  set6*: a b c d e f X
set0* 3->4 : X b c d e f g
set0  3->4*: X b c d e f g
3->4* set0 : X b c d e f g
3->4  set0*: X b c d e f g
set1* 3->4 : a X c d e f g
set1  3->4*: a X c d e f g
3->4* set1 : a X c d e f g
3->4  set1*: a X c d e f g
set2* 3->4 : a b X d e f g
set2  3->4*: a b X d e f g
3->4* set2 : a b X d e f g
3->4  set2*: a b X d e f g
set3* 3->4 : a b c X e f g
set3  3->4*: a b c X e f g
3->4* set3 : a b c X e f g
3->4  set3*: a b c X e f g
set4* 3->4 : a b c d X f g
set4  3->4*: a b c d X f g
3->4* set4 : a b c d X f g
3->4  set4*: a b c d X f g
set5* 3->4 : a b c d e X g
set5  3->4*: a b c d e X g
3->4* set5 : a b c d e X g
3->4  set5*: a b c d e X g
set6* 3->4 : a b c d e f X
set6  3->4*: a b c d e f X
3->4* set6 : a b c d e f X
3->4  set6*: a b c d e f X
set0* 3->5 : X b c e d f g
set0  3->5*: X b c e d f g
3->5* set0 : X b c e d f g
3->5  set0*: X b c e d f g
set1* 3->5 : a X c e d f g
set1  3->5*: a X c e d f g
3->5* set1 : a X c e d f g
3->5  set1*: a X c e d f g
set2* 3->5 : a b X e d f g
set2  3->5*: a b X e d f g
3->5* set2 : a b X e d f g
3->5  set2*: a b X e d f g
set3* 3->5 : a b c e X f g
set3  3->5*: a b c e X f g
3->5* set3 : a b c e X f g
3->5  set3*: a b c e X f g
set4* 3->5 : a b c X d f g
set4  3->5*: a b c X d f g
3->5* set4 : a b c X d f g
3->5  set4*: a b c X d f g
set5* 3->5 : a b c e d X g
set5  3->5*: a b c e d X g
3->5* set5 : a b c e d X g
3->5  set5*: a b c e d X g
set6* 3->5 : a b c e d f X
set6  3->5*: a b c e d f X
3->5* set6 : a b c e d f X
3->5  set6*: a b c e d f X
set0* 3->6 : X b c e f d g
set0  3->6*: X b c e f d g
3->6* set0 : X b c e f d g
3->6  set0*: X b c e f d g
set1* 3->6 : a X c e f d g
set1  3->6*: a X c e f d g
3->6* set1 : a X c e f d g
3->6  set1*: a X c e f d g
set2* 3->6 : a b X e f d g
set2  3->6*: a b X e f d g
3->6* set2 : a b X e f d g
3->6  set2*: a b X e f d g
set3* 3->6 : a b c e f X g
set3  3->6*: a b c e f X g
3->6* set3 : a b c e f X g
3->6  set3*: a b c e f X g
set4* 3->6 : a b c X f d g
set4  3->6*: a b c X f d g
3->6* set4 : a b c X f d g
3->6  set4*: a b c X f d g
set5* 3->6 : a b c e X d g
set5  3->6*: a b c e X d g
3->6* set5 : a b c e X d g
3->6  set5*: a b c e X d g
set6* 3->6 : a b c e f d X
set6  3->6*: a b c e f d X
3->6* set6 : a b c e f d X
3->6  set6*: a b c e f d X
set0* 3->7 : X b c e f g d
set0  3->7*: X b c e f g d
3->7* set0 : X b c e f g d
3->7  set0*: X b c e f g d
set1* 3->7 : a X c e f g d
set1  3->7*: a X c e f g d
3->7* set1 : a X c e f g d
3->7  set1*: a X c e f g d
set2* 3->7 : a b X e f g d
set2  3->7*: a b X e f g d
3->7* set2 : a b X e f g d
3->7  set2*: a b X e f g d
set3* 3->7 : a b c e f g X
set3  3->7*: a b c e f g X
3->7* set3 : a b c e f g X
3->7  set3*: a b c e f g X
set4* 3->7 : a b c X f g d
set4  3->7*: a b c X f g d
3->7* set4 : a b c X f g d
3->7  set4*: a b c X f g d
set5* 3->7 : a b c e X g d
set5  3->7*: a b c e X g d
3->7* set5 : a b c e X g d
3->7  set5*: a b c e X g d
set6* 3->7 : a b c e f X d
set6  3->7*: a b c e f X d
3->7* set6 : a b c e f X d
3->7  set6*: a b c e f X d
set0* 4->0 : e X b c d f g
set0  4->0*: e X b c d f g
4->0* set0 : e X b c d f g
4->0  set0*: e X b c d f g
set1* 4->0 : e a X c d f g
set1  4->0*: e a X c d f g
4->0* set1 : e a X c d f g
4->0  set1*: e a X c d f g
set2* 4->0 : e a b X d f g
set2  4->0*: e a b X d f g
4->0* set2 : e a b X d f g
4->0  set2*: e a b X d f g
set3* 4->0 : e a b c X f g
set3  4->0*: e a b c X f g
4->0* set3 : e a b c X f g
4->0  set3*: e a b c X f g
set4* 4->0 : X a b c d f g
set4  4->0*: X a b c d f g
4->0* set4 : X a b c d f g
4->0  set4*: X a b c d f g
set5* 4->0 : e a b c d X g
set5  4->0*: e a b c d X g
4->0* set5 : e a b c d X g
4->0  set5*: e a b c d X g
set6* 4->0 : e a b c d f X
set6  4->0*: e a b c d f X
4->0* set6 : e a b c d f X
4->0  set6*: e a b c d f X
set0* 4->1 : X e b c d f g
set0  4->1*: X e b c d f g
4->1* set0 : X e b c d f g
4->1  set0*: X e b c d f g
set1* 4->1 : a e X c d f g
set1  4->1*: a e X c d f g
4->1* set1 : a e X c d f g
4->1  set1*: a e X c d f g
set2* 4->1 : a e b X d f g
set2  4->1*: a e b X d f g
4->1* set2 : a e b X d f g
4->1  set2*: a e b X d f g
set3* 4->1 : a e b c X f g
set3  4->1*: a e b c X f g
4->1* set3 : a e b c X f g
4->1  set3*: a e b c X f g
set4* 4->1 : a X b c d f g
set4  4->1*: a X b c d f g
4->1* set4 : a X b c d f g
4->1  set4*: a X b c d f g
set5* 4->1 : a e b c d X g
set5  4->1*: a e b c d X g
4->1* set5 : a e b c d X g
4->1  set5*: a e b c d X g
set6* 4->1 : a e b c d f X
set6  4->1*: a e b c d f X
4->1* set6 : a e b c d f X
4->1  set6*: a e b c d f X
set0* 4->2 : X b e c d f g
set0  4->2*: X b e c d f g
4->2* set0 : X b e c d f g
4->2  set0*: X b e c d f g
set1* 4->2 : a X e c d f g
set1  4->2*: a X e c d f g
4->2* set1 : a X e c d f g
4->2  set1*: a X e c d f g
set2* 4->2 : a b e X d f g
set2  4->2*: a b e X d f g
4->2* set2 : a b e X d f g
4->2  set2*: a b e X d f g
set3* 4->2 : a b e c X f g
set3  4->2*: a b e c X f g
4->2* set3 : a b e c X f g
4->2  set3*: a b e c X f g
set4* 4->2 : a b X c d f g
set4  4->2*: a b X c d f g
4->2* set4 : a b X c d f g
4->2  set4*: a b X c d f g
set5* 4->2 : a b e c d X g
set5  4->2*: a b e c d X g
4->2* set5 : a b e c d X g
4->2  set5*: a b e c d X g
set6* 4->2 : a b e c d f X
set6  4->2*: a b e c d f X
4->2* set6 : a b e c d f X
4->2  set6*: a b e c d f X
set0* 4->3 : X b c e d f g
set0  4->3*: X b c e d f g
4->3* set0 : X b c e d f g
4->3  set0*: X b c e d f g
set1* 4->3 : a X c e d f g
set1  4->3*: a X c e d f g
4->3* set1 : a X c e d f g
4->3  set1*: a X c e d f g
set2* 4->3 : a b X e d f g
set2  4->3*: a b X e d f g
4->3* set2 : a b X e d f g
4->3  set2*: a b X e d f g
set3* 4->3 : a b c e X f g
set3  4->3*: a b c e X f g
4->3* set3 : a b c e X f g
4->3  set3*: a b c e X f g
set4* 4->3 : a b c X d f g
set4  4->3*: a b c X d f g
4->3* set4 : a b c X d f g
4->3  set4*: a b c X d f g
set5* 4->3 : a b c e d X g
set5  4->3*: a b c e d X g
4->3* set5 : a b c e d X g
4->3  set5*: a b c e d X g
set6* 4->3 : a b c e d f X
set6  4->3*: a b c e d f X
4->3* set6 : a b c e d f X
4->3  set6*: a b c e d f X
set0* 4->4 : X b c d e f g
set0  4->4*: X b c d e f g
4->4* set0 : X b c d e f g
4->4  set0*: X b c d e f g
set1* 4->4 : a X c d e f g
set1  4->4*: a X c d e f g
4->4* set1 : a X c d e f g
4->4  set1*: a X c d e f g
set2* 4->4 : a b X d e f g
set2  4->4*: a b X d e f g
4->4* set2 : a b X d e f g
4->4  set2*: a b X d e f g
set3* 4->4 : a b c X e f g
set3  4->4*: a b c X e f g
4->4* set3 : a b c X e f g
4->4  set3*: a b c X e f g
set4* 4->4 : a b c d X f g
set4  4->4*: a b c d X f g
4->4* set4 : a b c d X f g
4->4  set4*: a b c d X f g
set5* 4->4 : a b c d e X g
set5  4->4*: a b c d e X g
4->4* set5 : a b c d e X g
4->4  set5*: a b c d e X g
set6* 4->4 : a b c d e f X
set6  4->4*: a b c d e f X
4->4* set6 : a b c d e f X
4->4  set6*: a b c d e f X
set0* 4->5 : X b c d e f g
set0  4->5*: X b c d e f g
4->5* set0 : X b c d e f g
4->5  set0*: X b c d e f g
set1* 4->5 : a X c d e f g
set1  4->5*: a X c d e f g
4->5* set1 : a X c d e f g
4->5  set1*: a X c d e f g
set2* 4->5 : a b X d e f g
set2  4->5*: a b X d e f g
4->5* set2 : a b X d e f g
4->5  set2*: a b X d e f g
set3* 4->5 : a b c X e f g
set3  4->5*: a b c X e f g
4->5* set3 : a b c X e f g
4->5  set3*: a b c X e f g
set4* 4->5 : a b c d X f g
set4  4->5*: a b c d X f g
4->5* set4 : a b c d X f g
4->5  set4*: a b c d X f g
set5* 4->5 : a b c d e X g
set5  4->5*: a b c d e X g
4->5* set5 : a b c d e X g
4->5  set5*: a b c d e X g
set6* 4->5 : a b c d e f X
set6  4->5*: a b c d e f X
4->5* set6 : a b c d e f X
4->5  set6*: a b c d e f X
set0* 4->6 : X b c d f e g
set0  4->6*: X b c d f e g
4->6* set0 : X b c d f e g
4->6  set0*: X b c d f e g
set1* 4->6 : a X c d f e g
set1  4->6*: a X c d f e g
4->6* set1 : a X c d f e g
4->6  set1*: a X c d f e g
set2* 4->6 : a b X d f e g
set2  4->6*: a b X d f e g
4->6* set2 : a b X d f e g
4->6  set2*: a b X d f e g
set3* 4->6 : a b c X f e g
set3  4->6*: a b c X f e g
4->6* set3 : a b c X f e g
4->6  set3*: a b c X f e g
set4* 4->6 : a b c d f X g
set4  4->6*: a b c d f X g
4->6* set4 : a b c d f X g
4->6  set4*: a b c d f X g
set5* 4->6 : a b c d X e g
set5  4->6*: a b c d X e g
4->6* set5 : a b c d X e g
4->6  set5*: a b c d X e g
set6* 4->6 : a b c d f e X
set6  4->6*: a b c d f e X
4->6* set6 : a b c d f e X
4->6  set6*: a b c d f e X
set0* 4->7 : X b c d f g e
set0  4->7*: X b c d f g e
4->7* set0 : X b c d f g e
4->7  set0*: X b c d f g e
set1* 4->7 : a X c d f g e
set1  4->7*: a X c d f g e
4->7* set1 : a X c d f g e
4->7  set1*: a X c d f g e
set2* 4->7 : a b X d f g e
set2  4->7*: a b X d f g e
4->7* set2 : a b X d f g e
4->7  set2*: a b X d f g e
set3* 4->7 : a b c X f g e
set3  4->7*: a b c X f g e
4->7* set3 : a b c X f g e
4->7  set3*: a b c X f g e
set4* 4->7 : a b c d f g X
set4  4->7*: a b c d f g X
4->7* set4 : a b c d f g X
4->7  set4*: a b c d f g X
set5* 4->7 : a b c d X g e
set5  4->7*: a b c d X g e
4->7* set5 : a b c d X g e
4->7  set5*: a b c d X g e
set6* 4->7 : a b c d f X e
set6  4->7*: a b c d f X e
4->7* set6 : a b c d f X e
4->7  set6*: a b c d f X e
set0* 5->0 : f X b c d e g
set0  5->0*: f X b c d e g
5->0* set0 : f X b c d e g
5->0  set0*: f X b c d e g
set1* 5->0 : f a X c d e g
set1  5->0*: f a X c d e g
5->0* set1 : f a X c d e g
5->0  set1*: f a X c d e g
set2* 5->0 : f a b X d e g
set2  5->0*: f a b X d e g
5->0* set2 : f a b X d e g
5->0  set2*: f a b X d e g
set3* 5->0 : f a b c X e g
set3  5->0*: f a b c X e g
5->0* set3 : f a b c X e g
5->0  set3*: f a b c X e g
set4* 5->0 : f a b c d X g
set4  5->0*: f a b c d X g
5->0* set4 : f a b c d X g
5->0  set4*: f a b c d X g
set5* 5->0 : X a b c d e g
set5  5->0*: X a b c d e g
5->0* set5 : X a b c d e g
5->0  set5*: X a b c d e g
set6* 5->0 : f a b c d e X
set6  5->0*: f a b c d e X
5->0* set6 : f a b c d e X
5->0  set6*: f a b c d e X
set0* 5->1 : X f b c d e g
set0  5->1*: X f b c d e g
5->1* set0 : X f b c d e g
5->1  set0*: X f b c d e g
set1* 5->1 : a f X c d e g
set1  5->1*: a f X c d e g
5->1* set1 : a f X c d e g
5->1  set1*: a f X c d e g
set2* 5->1 : a f b X d e g
set2  5->1*: a f b X d e g
5->1* set2 : a f b X d e g
5->1  set2*: a f b X d e g
set3* 5->1 : a f b c X e g
set3  5->1*: a f b c X e g
5->1* set3 : a f b c X e g
5->1  set3*: a f b c X e g
set4* 5->1 : a f b c d X g
set4  5->1*: a f b c d X g
5->1* set4 : a f b c d X g
5->1  set4*: a f b c d X g
set5* 5->1 : a X b c d e g
set5  5->1*: a X b c d e g
5->1* set5 : a X b c d e g
5->1  set5*: a X b c d e g
set6* 5->1 : a f b c d e X
set6  5->1*: a f b c d e X
5->1* set6 : a f b c d e X
5->1  set6*: a f b c d e X
set0* 5->2 : X b f c d e g
set0  5->2*: X b f c d e g
5->2* set0 : X b f c d e g
5->2  set0*: X b f c d e g
set1* 5->2 : a X f c d e g
set1  5->2*: a X f c d e g
5->2* set1 : a X f c d e g
5->2  set1*: a X f c d e g
set2* 5->2 : a b f X d e g
set2  5->2*: a b f X d e g
5->2* set2 : a b f X d e g
5->2  set2*: a b f X d e g
set3* 5->2 : a b f c X e g
set3  5->2*: a b f c X e g
5->2* set3 : a b f c X e g
5->2  set3*: a b f c X e g
set4* 5->2 : a b f c d X g
set4  5->2*: a b f c d X g
5->2* set4 : a b f c d X g
5->2  set4*: a b f c d X g
set5* 5->2 : a b X c d e g
set5  5->2*: a b X c d e g
5->2* set5 : a b X c d e g
5->2  set5*: a b X c d e g
set6* 5->2 : a b f c d e X
set6  5->2*: a b f c d e X
5->2* set6 : a b f c d e X
5->2  set6*: a b f c d e X
set0* 5->3 : X b c f d e g
set0  5->3*: X b c f d e g
5->3* set0 : X b c f d e g
5->3  set0*: X b c f d e g
set1* 5->3 : a X c f d e g
set1  5->3*: a X c f d e g
5->3* set1 : a X c f d e g
5->3  set1*: a X c f d e g
set2* 5->3 : a b X f d e g
set2  5->3*: a b X f d e g
5->3* set2 : a b X f d e g
5->3  set2*: a b X f d e g
set3* 5->3 : a b c f X e g
set3  5->3*: a b c f X e g
5->3* set3 : a b c f X e g
5->3  set3*: a b c f X e g
set4* 5->3 : a b c f d X g
set4  5->3*: a b c f d X g
5->3* set4 : a b c f d X g
5->3  set4*: a b c f d X g
set5* 5->3 : a b c X d e g
set5  5->3*: a b c X d e g
5->3* set5 : a b c X d e g
5->3  set5*: a b c X d e g
set6* 5->3 : a b c f d e X
set6  5->3*: a b c f d e X
5->3* set6 : a b c f d e X
5->3  set6*: a b c f d e X
set0* 5->4 : X b c d f e g
set0  5->4*: X b c d f e g
5->4* set0 : X b c d f e g
5->4  set0*: X b c d f e g
set1* 5->4 : a X c d f e g
set1  5->4*: a X c d f e g
5->4* set1 : a X c d f e g
5->4  set1*: a X c d f e g
set2* 5->4 : a b X d f e g
set2  5->4*: a b X d f e g
5->4* set2 : a b X d f e g
5->4  set2*: a b X d f e g
set3* 5->4 : a b c X f e g
set3  5->4*: a b c X f e g
5->4* set3 : a b c X f e g
5->4  set3*: a b c X f e g
set4* 5->4 : a b c d f X g
set4  5->4*: a b c d f X g
5->4* set4 : a b c d f X g
5->4  set4*: a b c d f X g
set5* 5->4 : a b c d X e g
set5  5->4*: a b c d X e g
5->4* set5 : a b c d X e g
5->4  set5*: a b c d X e g
set6* 5->4 : a b c d f e X
set6  5->4*: a b c d f e X
5->4* set6 : a b c d f e X
5->4  set6*: a b c d f e X
set0* 5->5 : X b c d e f g
set0  5->5*: X b c d e f g
5->5* set0 : X b c d e f g
5->5  set0*: X b c d e f g
set1* 5->5 : a X c d e f g
set1  5->5*: a X c d e f g
5->5* set1 : a X c d e f g
5->5  set1*: a X c d e f g
set2* 5->5 : a b X d e f g
set2  5->5*: a b X d e f g
5->5* set2 : a b X d e f g
5->5  set2*: a b X d e f g
set3* 5->5 : a b c X e f g
set3  5->5*: a b c X e f g
5->5* set3 : a b c X e f g
5->5  set3*: a b c X e f g
set4* 5->5 : a b c d X f g
set4  5->5*: a b c d X f g
5->5* set4 : a b c d X f g
5->5  set4*: a b c d X f g
set5* 5->5 : a b c d e X g
set5  5->5*: a b c d e X g
5->5* set5 : a b c d e X g
5->5  set5*: a b c d e X g
set6* 5->5 : a b c d e f X
set6  5->5*: a b c d e f X
5->5* set6 : a b c d e f X
5->5  set6*: a b c d e f X
set0* 5->6 : X b c d e f g
set0  5->6*: X b c d e f g
5->6* set0 : X b c d e f g
5->6  set0*: X b c d e f g
set1* 5->6 : a X c d e f g
set1  5->6*: a X c d e f g
5->6* set1 : a X c d e f g
5->6  set1*: a X c d e f g
set2* 5->6 : a b X d e f g
set2  5->6*: a b X d e f g
5->6* set2 : a b X d e f g
5->6  set2*: a b X d e f g
set3* 5->6 : a b c X e f g
set3  5->6*: a b c X e f g
5->6* set3 : a b c X e f g
5->6  set3*: a b c X e f g
set4* 5->6 : a b c d X f g
set4  5->6*: a b c d X f g
5->6* set4 : a b c d X f g
5->6  set4*: a b c d X f g
set5* 5->6 : a b c d e X g
set5  5->6*: a b c d e X g
5->6* set5 : a b c d e X g
5->6  set5*: a b c d e X g
set6* 5->6 : a b c d e f X
set6  5->6*: a b c d e f X
5->6* set6 : a b c d e f X
5->6  set6*: a b c d e f X
set0* 5->7 : X b c d e g f
set0  5->7*: X b c d e g f
5->7* set0 : X b c d e g f
5->7  set0*: X b c d e g f
set1* 5->7 : a X c d e g f
set1  5->7*: a X c d e g f
5->7* set1 : a X c d e g f
5->7  set1*: a X c d e g f
set2* 5->7 : a b X d e g f
set2  5->7*: a b X d e g f
5->7* set2 : a b X d e g f
5->7  set2*: a b X d e g f
set3* 5->7 : a b c X e g f
set3  5->7*: a b c X e g f
5->7* set3 : a b c X e g f
5->7  set3*: a b c X e g f
set4* 5->7 : a b c d X g f
set4  5->7*: a b c d X g f
5->7* set4 : a b c d X g f
5->7  set4*: a b c d X g f
set5* 5->7 : a b c d e g X
set5  5->7*: a b c d e g X
5->7* set5 : a b c d e g X
5->7  set5*: a b c d e g X
set6* 5->7 : a b c d e X f
set6  5->7*: a b c d e X f
5->7* set6 : a b c d e X f
5->7  set6*: a b c d e X f
set0* 6->0 : g X b c d e f
set0  6->0*: g X b c d e f
6->0* set0 : g X b c d e f
6->0  set0*: g X b c d e f
set1* 6->0 : g a X c d e f
set1  6->0*: g a X c d e f
6->0* set1 : g a X c d e f
6->0  set1*: g a X c d e f
set2* 6->0 : g a b X d e f
set2  6->0*: g a b X d e f
6->0* set2 : g a b X d e f
6->0  set2*: g a b X d e f
set3* 6->0 : g a b c X e f
set3  6->0*: g a b c X e f
6->0* set3 : g a b c X e f
6->0  set3*: g a b c X e f
set4* 6->0 : g a b c d X f
set4  6->0*: g a b c d X f
6->0* set4 : g a b c d X f
6->0  set4*: g a b c d X f
set5* 6->0 : g a b c d e X
set5  6->0*: g a b c d e X
6->0* set5 : g a b c d e X
6->0  set5*: g a b c d e X
set6* 6->0 : X a b c d e f
set6  6->0*: X a b c d e f
6->0* set6 : X a b c d e f
6->0  set6*: X a b c d e f
set0* 6->1 : X g b c d e f
set0  6->1*: X g b c d e f
6->1* set0 : X g b c d e f
6->1  set0*: X g b c d e f
set1* 6->1 : a g X c d e f
set1  6->1*: a g X c d e f
6->1* set1 : a g X c d e f
6->1  set1*: a g X c d e f
set2* 6->1 : a g b X d e f
set2  6->1*: a g b X d e f
6->1* set2 : a g b X d e f
6->1  set2*: a g b X d e f
set3* 6->1 : a g b c X e f
set3  6->1*: a g b c X e f
6->1* set3 : a g b c X e f
6->1  set3*: a g b c X e f
set4* 6->1 : a g b c d X f
set4  6->1*: a g b c d X f
6->1* set4 : a g b c d X f
6->1  set4*: a g b c d X f
set5* 6->1 : a g b c d e X
set5  6->1*: a g b c d e X
6->1* set5 : a g b c d e X
6->1  set5*: a g b c d e X
set6* 6->1 : a X b c d e f
set6  6->1*: a X b c d e f
6->1* set6 : a X b c d e f
6->1  set6*: a X b c d e f
set0* 6->2 : X b g c d e f
set0  6->2*: X b g c d e f
6->2* set0 : X b g c d e f
6->2  set0*: X b g c d e f
set1* 6->2 : a X g c d e f
set1  6->2*: a X g c d e f
6->2* set1 : a X g c d e f
6->2  set1*: a X g c d e f
set2* 6->2 : a b g X d e f
set2  6->2*: a b g X d e f
6->2* set2 : a b g X d e f
6->2  set2*: a b g X d e f
set3* 6->2 : a b g c X e f
set3  6->2*: a b g c X e f
6->2* set3 : a b g c X e f
6->2  set3*: a b g c X e f
set4* 6->2 : a b g c d X f
set4  6->2*: a b g c d X f
6->2* set4 : a b g c d X f
6->2  set4*: a b g c d X f
set5* 6->2 : a b g c d e X
set5  6->2*: a b g c d e X
6->2* set5 : a b g c d e X
6->2  set5*: a b g c d e X
set6* 6->2 : a b X c d e f
set6  6->2*: a b X c d e f
6->2* set6 : a b X c d e f
6->2  set6*: a b X c d e f
set0* 6->3 : X b c g d e f
set0  6->3*: X b c g d e f
6->3* set0 : X b c g d e f
6->3  set0*: X b c g d e f
set1* 6->3 : a X c g d e f
set1  6->3*: a X c g d e f
6->3* set1 : a X c g d e f
6->3  set1*: a X c g d e f
set2* 6->3 : a b X g d e f
set2  6->3*: a b X g d e f
6->3* set2 : a b X g d e f
6->3  set2*: a b X g d e f
set3* 6->3 : a b c g X e f
set3  6->3*: a b c g X e f
6->3* set3 : a b c g X e f
6->3  set3*: a b c g X e f
set4* 6->3 : a b c g d X f
set4  6->3*: a b c g d X f
6->3* set4 : a b c g d X f
6->3  set4*: a b c g d X f
set5* 6->3 : a b c g d e X
set5  6->3*: a b c g d e X
6->3* set5 : a b c g d e X
6->3  set5*: a b c g d e X
set6* 6->3 : a b c X d e f
set6  6->3*: a b c X d e f
6->3* set6 : a b c X d e f
6->3  set6*: a b c X d e f
set0* 6->4 : X b c d g e f
set0  6->4*: X b c d g e f
6->4* set0 : X b c d g e f
6->4  set0*: X b c d g e f
set1* 6->4 : a X c d g e f
set1  6->4*: a X c d g e f
6->4* set1 : a X c d g e f
6->4  set1*: a X c d g e f
set2* 6->4 : a b X d g e f
set2  6->4*: a b X d g e f
6->4* set2 : a b X d g e f
6->4  set2*: a b X d g e f
set3* 6->4 : a b c X g e f
set3  6->4*: a b c X g e f
6->4* set3 : a b c X g e f
6->4  set3*: a b c X g e f
set4* 6->4 : a b c d g X f
set4  6->4*: a b c d g X f
6->4* set4 : a b c d g X f
6->4  set4*: a b c d g X f
set5* 6->4 : a b c d g e X
set5  6->4*: a b c d g e X
6->4* set5 : a b c d g e X
6->4  set5*: a b c d g e X
set6* 6->4 : a b c d X e f
set6  6->4*: a b c d X e f
6->4* set6 : a b c d X e f
6->4  set6*: a b c d X e f
set0* 6->5 : X b c d e g f
set0  6->5*: X b c d e g f
6->5* set0 : X b c d e g f
6->5  set0*: X b c d e g f
set1* 6->5 : a X c d e g f
set1  6->5*: a X c d e g f
6->5* set1 : a X c d e g f
6->5  set1*: a X c d e g f
set2* 6->5 : a b X d e g f
set2  6->5*: a b X d e g f
6->5* set2 : a b X d e g f
6->5  set2*: a b X d e g f
set3* 6->5 : a b c X e g f
set3  6->5*: a b c X e g f
6->5* set3 : a b c X e g f
6->5  set3*: a b c X e g f
set4* 6->5 : a b c d X g f
set4  6->5*: a b c d X g f
6->5* set4 : a b c d X g f
6->5  set4*: a b c d X g f
set5* 6->5 : a b c d e g X
set5  6->5*: a b c d e g X
6->5* set5 : a b c d e g X
6->5  set5*: a b c d e g X
set6* 6->5 : a b c d e X f
set6  6->5*: a b c d e X f
6->5* set6 : a b c d e X f
6->5  set6*: a b c d e X f
set0* 6->6 : X b c d e f g
set0  6->6*: X b c d e f g
6->6* set0 : X b c d e f g
6->6  set0*: X b c d e f g
set1* 6->6 : a X c d e f g
set1  6->6*: a X c d e f g
6->6* set1 : a X c d e f g
6->6  set1*: a X c d e f g
set2* 6->6 : a b X d e f g
set2  6->6*: a b X d e f g
6->6* set2 : a b X d e f g
6->6  set2*: a b X d e f g
set3* 6->6 : a b c X e f g
set3  6->6*: a b c X e f g
6->6* set3 : a b c X e f g
6->6  set3*: a b c X e f g
set4* 6->6 : a b c d X f g
set4  6->6*: a b c d X f g
6->6* set4 : a b c d X f g
6->6  set4*: a b c d X f g
set5* 6->6 : a b c d e X g
set5  6->6*: a b c d e X g
6->6* set5 : a b c d e X g
6->6  set5*: a b c d e X g
set6* 6->6 : a b c d e f X
set6  6->6*: a b c d e f X
6->6* set6 : a b c d e f X
6->6  set6*: a b c d e f X
set0* 6->7 : X b c d e f g
set0  6->7*: X b c d e f g
6->7* set0 : X b c d e f g
6->7  set0*: X b c d e f g
set1* 6->7 : a X c d e f g
set1  6->7*: a X c d e f g
6->7* set1 : a X c d e f g
6->7  set1*: a X c d e f g
set2* 6->7 : a b X d e f g
set2  6->7*: a b X d e f g
6->7* set2 : a b X d e f g
6->7  set2*: a b X d e f g
set3* 6->7 : a b c X e f g
set3  6->7*: a b c X e f g
6->7* set3 : a b c X e f g
6->7  set3*: a b c X e f g
set4* 6->7 : a b c d X f g
set4  6->7*: a b c d X f g
6->7* set4 : a b c d X f g
6->7  set4*: a b c d X f g
set5* 6->7 : a b c d e X g
set5  6->7*: a b c d e X g
6->7* set5 : a b c d e X g
6->7  set5*: a b c d e X g
set6* 6->7 : a b c d e f X
set6  6->7*: a b c d e f X
6->7* set6 : a b c d e f X
6->7  set6*: a b c d e f X''';

const expectedTestTransformMoveDelete = '''
del0* 0->0 : b c d e f g
del0  0->0*: b c d e f g
0->0* del0 : b c d e f g
0->0  del0*: b c d e f g
del1* 0->0 : a c d e f g
del1  0->0*: a c d e f g
0->0* del1 : a c d e f g
0->0  del1*: a c d e f g
del2* 0->0 : a b d e f g
del2  0->0*: a b d e f g
0->0* del2 : a b d e f g
0->0  del2*: a b d e f g
del3* 0->0 : a b c e f g
del3  0->0*: a b c e f g
0->0* del3 : a b c e f g
0->0  del3*: a b c e f g
del4* 0->0 : a b c d f g
del4  0->0*: a b c d f g
0->0* del4 : a b c d f g
0->0  del4*: a b c d f g
del5* 0->0 : a b c d e g
del5  0->0*: a b c d e g
0->0* del5 : a b c d e g
0->0  del5*: a b c d e g
del6* 0->0 : a b c d e f
del6  0->0*: a b c d e f
0->0* del6 : a b c d e f
0->0  del6*: a b c d e f
del0* 0->1 : b c d e f g
del0  0->1*: b c d e f g
0->1* del0 : b c d e f g
0->1  del0*: b c d e f g
del1* 0->1 : a c d e f g
del1  0->1*: a c d e f g
0->1* del1 : a c d e f g
0->1  del1*: a c d e f g
del2* 0->1 : a b d e f g
del2  0->1*: a b d e f g
0->1* del2 : a b d e f g
0->1  del2*: a b d e f g
del3* 0->1 : a b c e f g
del3  0->1*: a b c e f g
0->1* del3 : a b c e f g
0->1  del3*: a b c e f g
del4* 0->1 : a b c d f g
del4  0->1*: a b c d f g
0->1* del4 : a b c d f g
0->1  del4*: a b c d f g
del5* 0->1 : a b c d e g
del5  0->1*: a b c d e g
0->1* del5 : a b c d e g
0->1  del5*: a b c d e g
del6* 0->1 : a b c d e f
del6  0->1*: a b c d e f
0->1* del6 : a b c d e f
0->1  del6*: a b c d e f
del0* 0->2 : b c d e f g
del0  0->2*: b c d e f g
0->2* del0 : b c d e f g
0->2  del0*: b c d e f g
del1* 0->2 : a c d e f g
del1  0->2*: a c d e f g
0->2* del1 : a c d e f g
0->2  del1*: a c d e f g
del2* 0->2 : b a d e f g
del2  0->2*: b a d e f g
0->2* del2 : b a d e f g
0->2  del2*: b a d e f g
del3* 0->2 : b a c e f g
del3  0->2*: b a c e f g
0->2* del3 : b a c e f g
0->2  del3*: b a c e f g
del4* 0->2 : b a c d f g
del4  0->2*: b a c d f g
0->2* del4 : b a c d f g
0->2  del4*: b a c d f g
del5* 0->2 : b a c d e g
del5  0->2*: b a c d e g
0->2* del5 : b a c d e g
0->2  del5*: b a c d e g
del6* 0->2 : b a c d e f
del6  0->2*: b a c d e f
0->2* del6 : b a c d e f
0->2  del6*: b a c d e f
del0* 0->3 : b c d e f g
del0  0->3*: b c d e f g
0->3* del0 : b c d e f g
0->3  del0*: b c d e f g
del1* 0->3 : c a d e f g
del1  0->3*: c a d e f g
0->3* del1 : c a d e f g
0->3  del1*: c a d e f g
del2* 0->3 : b a d e f g
del2  0->3*: b a d e f g
0->3* del2 : b a d e f g
0->3  del2*: b a d e f g
del3* 0->3 : b c a e f g
del3  0->3*: b c a e f g
0->3* del3 : b c a e f g
0->3  del3*: b c a e f g
del4* 0->3 : b c a d f g
del4  0->3*: b c a d f g
0->3* del4 : b c a d f g
0->3  del4*: b c a d f g
del5* 0->3 : b c a d e g
del5  0->3*: b c a d e g
0->3* del5 : b c a d e g
0->3  del5*: b c a d e g
del6* 0->3 : b c a d e f
del6  0->3*: b c a d e f
0->3* del6 : b c a d e f
0->3  del6*: b c a d e f
del0* 0->4 : b c d e f g
del0  0->4*: b c d e f g
0->4* del0 : b c d e f g
0->4  del0*: b c d e f g
del1* 0->4 : c d a e f g
del1  0->4*: c d a e f g
0->4* del1 : c d a e f g
0->4  del1*: c d a e f g
del2* 0->4 : b d a e f g
del2  0->4*: b d a e f g
0->4* del2 : b d a e f g
0->4  del2*: b d a e f g
del3* 0->4 : b c a e f g
del3  0->4*: b c a e f g
0->4* del3 : b c a e f g
0->4  del3*: b c a e f g
del4* 0->4 : b c d a f g
del4  0->4*: b c d a f g
0->4* del4 : b c d a f g
0->4  del4*: b c d a f g
del5* 0->4 : b c d a e g
del5  0->4*: b c d a e g
0->4* del5 : b c d a e g
0->4  del5*: b c d a e g
del6* 0->4 : b c d a e f
del6  0->4*: b c d a e f
0->4* del6 : b c d a e f
0->4  del6*: b c d a e f
del0* 0->5 : b c d e f g
del0  0->5*: b c d e f g
0->5* del0 : b c d e f g
0->5  del0*: b c d e f g
del1* 0->5 : c d e a f g
del1  0->5*: c d e a f g
0->5* del1 : c d e a f g
0->5  del1*: c d e a f g
del2* 0->5 : b d e a f g
del2  0->5*: b d e a f g
0->5* del2 : b d e a f g
0->5  del2*: b d e a f g
del3* 0->5 : b c e a f g
del3  0->5*: b c e a f g
0->5* del3 : b c e a f g
0->5  del3*: b c e a f g
del4* 0->5 : b c d a f g
del4  0->5*: b c d a f g
0->5* del4 : b c d a f g
0->5  del4*: b c d a f g
del5* 0->5 : b c d e a g
del5  0->5*: b c d e a g
0->5* del5 : b c d e a g
0->5  del5*: b c d e a g
del6* 0->5 : b c d e a f
del6  0->5*: b c d e a f
0->5* del6 : b c d e a f
0->5  del6*: b c d e a f
del0* 0->6 : b c d e f g
del0  0->6*: b c d e f g
0->6* del0 : b c d e f g
0->6  del0*: b c d e f g
del1* 0->6 : c d e f a g
del1  0->6*: c d e f a g
0->6* del1 : c d e f a g
0->6  del1*: c d e f a g
del2* 0->6 : b d e f a g
del2  0->6*: b d e f a g
0->6* del2 : b d e f a g
0->6  del2*: b d e f a g
del3* 0->6 : b c e f a g
del3  0->6*: b c e f a g
0->6* del3 : b c e f a g
0->6  del3*: b c e f a g
del4* 0->6 : b c d f a g
del4  0->6*: b c d f a g
0->6* del4 : b c d f a g
0->6  del4*: b c d f a g
del5* 0->6 : b c d e a g
del5  0->6*: b c d e a g
0->6* del5 : b c d e a g
0->6  del5*: b c d e a g
del6* 0->6 : b c d e f a
del6  0->6*: b c d e f a
0->6* del6 : b c d e f a
0->6  del6*: b c d e f a
del0* 0->7 : b c d e f g
del0  0->7*: b c d e f g
0->7* del0 : b c d e f g
0->7  del0*: b c d e f g
del1* 0->7 : c d e f g a
del1  0->7*: c d e f g a
0->7* del1 : c d e f g a
0->7  del1*: c d e f g a
del2* 0->7 : b d e f g a
del2  0->7*: b d e f g a
0->7* del2 : b d e f g a
0->7  del2*: b d e f g a
del3* 0->7 : b c e f g a
del3  0->7*: b c e f g a
0->7* del3 : b c e f g a
0->7  del3*: b c e f g a
del4* 0->7 : b c d f g a
del4  0->7*: b c d f g a
0->7* del4 : b c d f g a
0->7  del4*: b c d f g a
del5* 0->7 : b c d e g a
del5  0->7*: b c d e g a
0->7* del5 : b c d e g a
0->7  del5*: b c d e g a
del6* 0->7 : b c d e f a
del6  0->7*: b c d e f a
0->7* del6 : b c d e f a
0->7  del6*: b c d e f a
del0* 1->0 : b c d e f g
del0  1->0*: b c d e f g
1->0* del0 : b c d e f g
1->0  del0*: b c d e f g
del1* 1->0 : a c d e f g
del1  1->0*: a c d e f g
1->0* del1 : a c d e f g
1->0  del1*: a c d e f g
del2* 1->0 : b a d e f g
del2  1->0*: b a d e f g
1->0* del2 : b a d e f g
1->0  del2*: b a d e f g
del3* 1->0 : b a c e f g
del3  1->0*: b a c e f g
1->0* del3 : b a c e f g
1->0  del3*: b a c e f g
del4* 1->0 : b a c d f g
del4  1->0*: b a c d f g
1->0* del4 : b a c d f g
1->0  del4*: b a c d f g
del5* 1->0 : b a c d e g
del5  1->0*: b a c d e g
1->0* del5 : b a c d e g
1->0  del5*: b a c d e g
del6* 1->0 : b a c d e f
del6  1->0*: b a c d e f
1->0* del6 : b a c d e f
1->0  del6*: b a c d e f
del0* 1->1 : b c d e f g
del0  1->1*: b c d e f g
1->1* del0 : b c d e f g
1->1  del0*: b c d e f g
del1* 1->1 : a c d e f g
del1  1->1*: a c d e f g
1->1* del1 : a c d e f g
1->1  del1*: a c d e f g
del2* 1->1 : a b d e f g
del2  1->1*: a b d e f g
1->1* del2 : a b d e f g
1->1  del2*: a b d e f g
del3* 1->1 : a b c e f g
del3  1->1*: a b c e f g
1->1* del3 : a b c e f g
1->1  del3*: a b c e f g
del4* 1->1 : a b c d f g
del4  1->1*: a b c d f g
1->1* del4 : a b c d f g
1->1  del4*: a b c d f g
del5* 1->1 : a b c d e g
del5  1->1*: a b c d e g
1->1* del5 : a b c d e g
1->1  del5*: a b c d e g
del6* 1->1 : a b c d e f
del6  1->1*: a b c d e f
1->1* del6 : a b c d e f
1->1  del6*: a b c d e f
del0* 1->2 : b c d e f g
del0  1->2*: b c d e f g
1->2* del0 : b c d e f g
1->2  del0*: b c d e f g
del1* 1->2 : a c d e f g
del1  1->2*: a c d e f g
1->2* del1 : a c d e f g
1->2  del1*: a c d e f g
del2* 1->2 : a b d e f g
del2  1->2*: a b d e f g
1->2* del2 : a b d e f g
1->2  del2*: a b d e f g
del3* 1->2 : a b c e f g
del3  1->2*: a b c e f g
1->2* del3 : a b c e f g
1->2  del3*: a b c e f g
del4* 1->2 : a b c d f g
del4  1->2*: a b c d f g
1->2* del4 : a b c d f g
1->2  del4*: a b c d f g
del5* 1->2 : a b c d e g
del5  1->2*: a b c d e g
1->2* del5 : a b c d e g
1->2  del5*: a b c d e g
del6* 1->2 : a b c d e f
del6  1->2*: a b c d e f
1->2* del6 : a b c d e f
1->2  del6*: a b c d e f
del0* 1->3 : c b d e f g
del0  1->3*: c b d e f g
1->3* del0 : c b d e f g
1->3  del0*: c b d e f g
del1* 1->3 : a c d e f g
del1  1->3*: a c d e f g
1->3* del1 : a c d e f g
1->3  del1*: a c d e f g
del2* 1->3 : a b d e f g
del2  1->3*: a b d e f g
1->3* del2 : a b d e f g
1->3  del2*: a b d e f g
del3* 1->3 : a c b e f g
del3  1->3*: a c b e f g
1->3* del3 : a c b e f g
1->3  del3*: a c b e f g
del4* 1->3 : a c b d f g
del4  1->3*: a c b d f g
1->3* del4 : a c b d f g
1->3  del4*: a c b d f g
del5* 1->3 : a c b d e g
del5  1->3*: a c b d e g
1->3* del5 : a c b d e g
1->3  del5*: a c b d e g
del6* 1->3 : a c b d e f
del6  1->3*: a c b d e f
1->3* del6 : a c b d e f
1->3  del6*: a c b d e f
del0* 1->4 : c d b e f g
del0  1->4*: c d b e f g
1->4* del0 : c d b e f g
1->4  del0*: c d b e f g
del1* 1->4 : a c d e f g
del1  1->4*: a c d e f g
1->4* del1 : a c d e f g
1->4  del1*: a c d e f g
del2* 1->4 : a d b e f g
del2  1->4*: a d b e f g
1->4* del2 : a d b e f g
1->4  del2*: a d b e f g
del3* 1->4 : a c b e f g
del3  1->4*: a c b e f g
1->4* del3 : a c b e f g
1->4  del3*: a c b e f g
del4* 1->4 : a c d b f g
del4  1->4*: a c d b f g
1->4* del4 : a c d b f g
1->4  del4*: a c d b f g
del5* 1->4 : a c d b e g
del5  1->4*: a c d b e g
1->4* del5 : a c d b e g
1->4  del5*: a c d b e g
del6* 1->4 : a c d b e f
del6  1->4*: a c d b e f
1->4* del6 : a c d b e f
1->4  del6*: a c d b e f
del0* 1->5 : c d e b f g
del0  1->5*: c d e b f g
1->5* del0 : c d e b f g
1->5  del0*: c d e b f g
del1* 1->5 : a c d e f g
del1  1->5*: a c d e f g
1->5* del1 : a c d e f g
1->5  del1*: a c d e f g
del2* 1->5 : a d e b f g
del2  1->5*: a d e b f g
1->5* del2 : a d e b f g
1->5  del2*: a d e b f g
del3* 1->5 : a c e b f g
del3  1->5*: a c e b f g
1->5* del3 : a c e b f g
1->5  del3*: a c e b f g
del4* 1->5 : a c d b f g
del4  1->5*: a c d b f g
1->5* del4 : a c d b f g
1->5  del4*: a c d b f g
del5* 1->5 : a c d e b g
del5  1->5*: a c d e b g
1->5* del5 : a c d e b g
1->5  del5*: a c d e b g
del6* 1->5 : a c d e b f
del6  1->5*: a c d e b f
1->5* del6 : a c d e b f
1->5  del6*: a c d e b f
del0* 1->6 : c d e f b g
del0  1->6*: c d e f b g
1->6* del0 : c d e f b g
1->6  del0*: c d e f b g
del1* 1->6 : a c d e f g
del1  1->6*: a c d e f g
1->6* del1 : a c d e f g
1->6  del1*: a c d e f g
del2* 1->6 : a d e f b g
del2  1->6*: a d e f b g
1->6* del2 : a d e f b g
1->6  del2*: a d e f b g
del3* 1->6 : a c e f b g
del3  1->6*: a c e f b g
1->6* del3 : a c e f b g
1->6  del3*: a c e f b g
del4* 1->6 : a c d f b g
del4  1->6*: a c d f b g
1->6* del4 : a c d f b g
1->6  del4*: a c d f b g
del5* 1->6 : a c d e b g
del5  1->6*: a c d e b g
1->6* del5 : a c d e b g
1->6  del5*: a c d e b g
del6* 1->6 : a c d e f b
del6  1->6*: a c d e f b
1->6* del6 : a c d e f b
1->6  del6*: a c d e f b
del0* 1->7 : c d e f g b
del0  1->7*: c d e f g b
1->7* del0 : c d e f g b
1->7  del0*: c d e f g b
del1* 1->7 : a c d e f g
del1  1->7*: a c d e f g
1->7* del1 : a c d e f g
1->7  del1*: a c d e f g
del2* 1->7 : a d e f g b
del2  1->7*: a d e f g b
1->7* del2 : a d e f g b
1->7  del2*: a d e f g b
del3* 1->7 : a c e f g b
del3  1->7*: a c e f g b
1->7* del3 : a c e f g b
1->7  del3*: a c e f g b
del4* 1->7 : a c d f g b
del4  1->7*: a c d f g b
1->7* del4 : a c d f g b
1->7  del4*: a c d f g b
del5* 1->7 : a c d e g b
del5  1->7*: a c d e g b
1->7* del5 : a c d e g b
1->7  del5*: a c d e g b
del6* 1->7 : a c d e f b
del6  1->7*: a c d e f b
1->7* del6 : a c d e f b
1->7  del6*: a c d e f b
del0* 2->0 : c b d e f g
del0  2->0*: c b d e f g
2->0* del0 : c b d e f g
2->0  del0*: c b d e f g
del1* 2->0 : c a d e f g
del1  2->0*: c a d e f g
2->0* del1 : c a d e f g
2->0  del1*: c a d e f g
del2* 2->0 : a b d e f g
del2  2->0*: a b d e f g
2->0* del2 : a b d e f g
2->0  del2*: a b d e f g
del3* 2->0 : c a b e f g
del3  2->0*: c a b e f g
2->0* del3 : c a b e f g
2->0  del3*: c a b e f g
del4* 2->0 : c a b d f g
del4  2->0*: c a b d f g
2->0* del4 : c a b d f g
2->0  del4*: c a b d f g
del5* 2->0 : c a b d e g
del5  2->0*: c a b d e g
2->0* del5 : c a b d e g
2->0  del5*: c a b d e g
del6* 2->0 : c a b d e f
del6  2->0*: c a b d e f
2->0* del6 : c a b d e f
2->0  del6*: c a b d e f
del0* 2->1 : c b d e f g
del0  2->1*: c b d e f g
2->1* del0 : c b d e f g
2->1  del0*: c b d e f g
del1* 2->1 : a c d e f g
del1  2->1*: a c d e f g
2->1* del1 : a c d e f g
2->1  del1*: a c d e f g
del2* 2->1 : a b d e f g
del2  2->1*: a b d e f g
2->1* del2 : a b d e f g
2->1  del2*: a b d e f g
del3* 2->1 : a c b e f g
del3  2->1*: a c b e f g
2->1* del3 : a c b e f g
2->1  del3*: a c b e f g
del4* 2->1 : a c b d f g
del4  2->1*: a c b d f g
2->1* del4 : a c b d f g
2->1  del4*: a c b d f g
del5* 2->1 : a c b d e g
del5  2->1*: a c b d e g
2->1* del5 : a c b d e g
2->1  del5*: a c b d e g
del6* 2->1 : a c b d e f
del6  2->1*: a c b d e f
2->1* del6 : a c b d e f
2->1  del6*: a c b d e f
del0* 2->2 : b c d e f g
del0  2->2*: b c d e f g
2->2* del0 : b c d e f g
2->2  del0*: b c d e f g
del1* 2->2 : a c d e f g
del1  2->2*: a c d e f g
2->2* del1 : a c d e f g
2->2  del1*: a c d e f g
del2* 2->2 : a b d e f g
del2  2->2*: a b d e f g
2->2* del2 : a b d e f g
2->2  del2*: a b d e f g
del3* 2->2 : a b c e f g
del3  2->2*: a b c e f g
2->2* del3 : a b c e f g
2->2  del3*: a b c e f g
del4* 2->2 : a b c d f g
del4  2->2*: a b c d f g
2->2* del4 : a b c d f g
2->2  del4*: a b c d f g
del5* 2->2 : a b c d e g
del5  2->2*: a b c d e g
2->2* del5 : a b c d e g
2->2  del5*: a b c d e g
del6* 2->2 : a b c d e f
del6  2->2*: a b c d e f
2->2* del6 : a b c d e f
2->2  del6*: a b c d e f
del0* 2->3 : b c d e f g
del0  2->3*: b c d e f g
2->3* del0 : b c d e f g
2->3  del0*: b c d e f g
del1* 2->3 : a c d e f g
del1  2->3*: a c d e f g
2->3* del1 : a c d e f g
2->3  del1*: a c d e f g
del2* 2->3 : a b d e f g
del2  2->3*: a b d e f g
2->3* del2 : a b d e f g
2->3  del2*: a b d e f g
del3* 2->3 : a b c e f g
del3  2->3*: a b c e f g
2->3* del3 : a b c e f g
2->3  del3*: a b c e f g
del4* 2->3 : a b c d f g
del4  2->3*: a b c d f g
2->3* del4 : a b c d f g
2->3  del4*: a b c d f g
del5* 2->3 : a b c d e g
del5  2->3*: a b c d e g
2->3* del5 : a b c d e g
2->3  del5*: a b c d e g
del6* 2->3 : a b c d e f
del6  2->3*: a b c d e f
2->3* del6 : a b c d e f
2->3  del6*: a b c d e f
del0* 2->4 : b d c e f g
del0  2->4*: b d c e f g
2->4* del0 : b d c e f g
2->4  del0*: b d c e f g
del1* 2->4 : a d c e f g
del1  2->4*: a d c e f g
2->4* del1 : a d c e f g
2->4  del1*: a d c e f g
del2* 2->4 : a b d e f g
del2  2->4*: a b d e f g
2->4* del2 : a b d e f g
2->4  del2*: a b d e f g
del3* 2->4 : a b c e f g
del3  2->4*: a b c e f g
2->4* del3 : a b c e f g
2->4  del3*: a b c e f g
del4* 2->4 : a b d c f g
del4  2->4*: a b d c f g
2->4* del4 : a b d c f g
2->4  del4*: a b d c f g
del5* 2->4 : a b d c e g
del5  2->4*: a b d c e g
2->4* del5 : a b d c e g
2->4  del5*: a b d c e g
del6* 2->4 : a b d c e f
del6  2->4*: a b d c e f
2->4* del6 : a b d c e f
2->4  del6*: a b d c e f
del0* 2->5 : b d e c f g
del0  2->5*: b d e c f g
2->5* del0 : b d e c f g
2->5  del0*: b d e c f g
del1* 2->5 : a d e c f g
del1  2->5*: a d e c f g
2->5* del1 : a d e c f g
2->5  del1*: a d e c f g
del2* 2->5 : a b d e f g
del2  2->5*: a b d e f g
2->5* del2 : a b d e f g
2->5  del2*: a b d e f g
del3* 2->5 : a b e c f g
del3  2->5*: a b e c f g
2->5* del3 : a b e c f g
2->5  del3*: a b e c f g
del4* 2->5 : a b d c f g
del4  2->5*: a b d c f g
2->5* del4 : a b d c f g
2->5  del4*: a b d c f g
del5* 2->5 : a b d e c g
del5  2->5*: a b d e c g
2->5* del5 : a b d e c g
2->5  del5*: a b d e c g
del6* 2->5 : a b d e c f
del6  2->5*: a b d e c f
2->5* del6 : a b d e c f
2->5  del6*: a b d e c f
del0* 2->6 : b d e f c g
del0  2->6*: b d e f c g
2->6* del0 : b d e f c g
2->6  del0*: b d e f c g
del1* 2->6 : a d e f c g
del1  2->6*: a d e f c g
2->6* del1 : a d e f c g
2->6  del1*: a d e f c g
del2* 2->6 : a b d e f g
del2  2->6*: a b d e f g
2->6* del2 : a b d e f g
2->6  del2*: a b d e f g
del3* 2->6 : a b e f c g
del3  2->6*: a b e f c g
2->6* del3 : a b e f c g
2->6  del3*: a b e f c g
del4* 2->6 : a b d f c g
del4  2->6*: a b d f c g
2->6* del4 : a b d f c g
2->6  del4*: a b d f c g
del5* 2->6 : a b d e c g
del5  2->6*: a b d e c g
2->6* del5 : a b d e c g
2->6  del5*: a b d e c g
del6* 2->6 : a b d e f c
del6  2->6*: a b d e f c
2->6* del6 : a b d e f c
2->6  del6*: a b d e f c
del0* 2->7 : b d e f g c
del0  2->7*: b d e f g c
2->7* del0 : b d e f g c
2->7  del0*: b d e f g c
del1* 2->7 : a d e f g c
del1  2->7*: a d e f g c
2->7* del1 : a d e f g c
2->7  del1*: a d e f g c
del2* 2->7 : a b d e f g
del2  2->7*: a b d e f g
2->7* del2 : a b d e f g
2->7  del2*: a b d e f g
del3* 2->7 : a b e f g c
del3  2->7*: a b e f g c
2->7* del3 : a b e f g c
2->7  del3*: a b e f g c
del4* 2->7 : a b d f g c
del4  2->7*: a b d f g c
2->7* del4 : a b d f g c
2->7  del4*: a b d f g c
del5* 2->7 : a b d e g c
del5  2->7*: a b d e g c
2->7* del5 : a b d e g c
2->7  del5*: a b d e g c
del6* 2->7 : a b d e f c
del6  2->7*: a b d e f c
2->7* del6 : a b d e f c
2->7  del6*: a b d e f c
del0* 3->0 : d b c e f g
del0  3->0*: d b c e f g
3->0* del0 : d b c e f g
3->0  del0*: d b c e f g
del1* 3->0 : d a c e f g
del1  3->0*: d a c e f g
3->0* del1 : d a c e f g
3->0  del1*: d a c e f g
del2* 3->0 : d a b e f g
del2  3->0*: d a b e f g
3->0* del2 : d a b e f g
3->0  del2*: d a b e f g
del3* 3->0 : a b c e f g
del3  3->0*: a b c e f g
3->0* del3 : a b c e f g
3->0  del3*: a b c e f g
del4* 3->0 : d a b c f g
del4  3->0*: d a b c f g
3->0* del4 : d a b c f g
3->0  del4*: d a b c f g
del5* 3->0 : d a b c e g
del5  3->0*: d a b c e g
3->0* del5 : d a b c e g
3->0  del5*: d a b c e g
del6* 3->0 : d a b c e f
del6  3->0*: d a b c e f
3->0* del6 : d a b c e f
3->0  del6*: d a b c e f
del0* 3->1 : d b c e f g
del0  3->1*: d b c e f g
3->1* del0 : d b c e f g
3->1  del0*: d b c e f g
del1* 3->1 : a d c e f g
del1  3->1*: a d c e f g
3->1* del1 : a d c e f g
3->1  del1*: a d c e f g
del2* 3->1 : a d b e f g
del2  3->1*: a d b e f g
3->1* del2 : a d b e f g
3->1  del2*: a d b e f g
del3* 3->1 : a b c e f g
del3  3->1*: a b c e f g
3->1* del3 : a b c e f g
3->1  del3*: a b c e f g
del4* 3->1 : a d b c f g
del4  3->1*: a d b c f g
3->1* del4 : a d b c f g
3->1  del4*: a d b c f g
del5* 3->1 : a d b c e g
del5  3->1*: a d b c e g
3->1* del5 : a d b c e g
3->1  del5*: a d b c e g
del6* 3->1 : a d b c e f
del6  3->1*: a d b c e f
3->1* del6 : a d b c e f
3->1  del6*: a d b c e f
del0* 3->2 : b d c e f g
del0  3->2*: b d c e f g
3->2* del0 : b d c e f g
3->2  del0*: b d c e f g
del1* 3->2 : a d c e f g
del1  3->2*: a d c e f g
3->2* del1 : a d c e f g
3->2  del1*: a d c e f g
del2* 3->2 : a b d e f g
del2  3->2*: a b d e f g
3->2* del2 : a b d e f g
3->2  del2*: a b d e f g
del3* 3->2 : a b c e f g
del3  3->2*: a b c e f g
3->2* del3 : a b c e f g
3->2  del3*: a b c e f g
del4* 3->2 : a b d c f g
del4  3->2*: a b d c f g
3->2* del4 : a b d c f g
3->2  del4*: a b d c f g
del5* 3->2 : a b d c e g
del5  3->2*: a b d c e g
3->2* del5 : a b d c e g
3->2  del5*: a b d c e g
del6* 3->2 : a b d c e f
del6  3->2*: a b d c e f
3->2* del6 : a b d c e f
3->2  del6*: a b d c e f
del0* 3->3 : b c d e f g
del0  3->3*: b c d e f g
3->3* del0 : b c d e f g
3->3  del0*: b c d e f g
del1* 3->3 : a c d e f g
del1  3->3*: a c d e f g
3->3* del1 : a c d e f g
3->3  del1*: a c d e f g
del2* 3->3 : a b d e f g
del2  3->3*: a b d e f g
3->3* del2 : a b d e f g
3->3  del2*: a b d e f g
del3* 3->3 : a b c e f g
del3  3->3*: a b c e f g
3->3* del3 : a b c e f g
3->3  del3*: a b c e f g
del4* 3->3 : a b c d f g
del4  3->3*: a b c d f g
3->3* del4 : a b c d f g
3->3  del4*: a b c d f g
del5* 3->3 : a b c d e g
del5  3->3*: a b c d e g
3->3* del5 : a b c d e g
3->3  del5*: a b c d e g
del6* 3->3 : a b c d e f
del6  3->3*: a b c d e f
3->3* del6 : a b c d e f
3->3  del6*: a b c d e f
del0* 3->4 : b c d e f g
del0  3->4*: b c d e f g
3->4* del0 : b c d e f g
3->4  del0*: b c d e f g
del1* 3->4 : a c d e f g
del1  3->4*: a c d e f g
3->4* del1 : a c d e f g
3->4  del1*: a c d e f g
del2* 3->4 : a b d e f g
del2  3->4*: a b d e f g
3->4* del2 : a b d e f g
3->4  del2*: a b d e f g
del3* 3->4 : a b c e f g
del3  3->4*: a b c e f g
3->4* del3 : a b c e f g
3->4  del3*: a b c e f g
del4* 3->4 : a b c d f g
del4  3->4*: a b c d f g
3->4* del4 : a b c d f g
3->4  del4*: a b c d f g
del5* 3->4 : a b c d e g
del5  3->4*: a b c d e g
3->4* del5 : a b c d e g
3->4  del5*: a b c d e g
del6* 3->4 : a b c d e f
del6  3->4*: a b c d e f
3->4* del6 : a b c d e f
3->4  del6*: a b c d e f
del0* 3->5 : b c e d f g
del0  3->5*: b c e d f g
3->5* del0 : b c e d f g
3->5  del0*: b c e d f g
del1* 3->5 : a c e d f g
del1  3->5*: a c e d f g
3->5* del1 : a c e d f g
3->5  del1*: a c e d f g
del2* 3->5 : a b e d f g
del2  3->5*: a b e d f g
3->5* del2 : a b e d f g
3->5  del2*: a b e d f g
del3* 3->5 : a b c e f g
del3  3->5*: a b c e f g
3->5* del3 : a b c e f g
3->5  del3*: a b c e f g
del4* 3->5 : a b c d f g
del4  3->5*: a b c d f g
3->5* del4 : a b c d f g
3->5  del4*: a b c d f g
del5* 3->5 : a b c e d g
del5  3->5*: a b c e d g
3->5* del5 : a b c e d g
3->5  del5*: a b c e d g
del6* 3->5 : a b c e d f
del6  3->5*: a b c e d f
3->5* del6 : a b c e d f
3->5  del6*: a b c e d f
del0* 3->6 : b c e f d g
del0  3->6*: b c e f d g
3->6* del0 : b c e f d g
3->6  del0*: b c e f d g
del1* 3->6 : a c e f d g
del1  3->6*: a c e f d g
3->6* del1 : a c e f d g
3->6  del1*: a c e f d g
del2* 3->6 : a b e f d g
del2  3->6*: a b e f d g
3->6* del2 : a b e f d g
3->6  del2*: a b e f d g
del3* 3->6 : a b c e f g
del3  3->6*: a b c e f g
3->6* del3 : a b c e f g
3->6  del3*: a b c e f g
del4* 3->6 : a b c f d g
del4  3->6*: a b c f d g
3->6* del4 : a b c f d g
3->6  del4*: a b c f d g
del5* 3->6 : a b c e d g
del5  3->6*: a b c e d g
3->6* del5 : a b c e d g
3->6  del5*: a b c e d g
del6* 3->6 : a b c e f d
del6  3->6*: a b c e f d
3->6* del6 : a b c e f d
3->6  del6*: a b c e f d
del0* 3->7 : b c e f g d
del0  3->7*: b c e f g d
3->7* del0 : b c e f g d
3->7  del0*: b c e f g d
del1* 3->7 : a c e f g d
del1  3->7*: a c e f g d
3->7* del1 : a c e f g d
3->7  del1*: a c e f g d
del2* 3->7 : a b e f g d
del2  3->7*: a b e f g d
3->7* del2 : a b e f g d
3->7  del2*: a b e f g d
del3* 3->7 : a b c e f g
del3  3->7*: a b c e f g
3->7* del3 : a b c e f g
3->7  del3*: a b c e f g
del4* 3->7 : a b c f g d
del4  3->7*: a b c f g d
3->7* del4 : a b c f g d
3->7  del4*: a b c f g d
del5* 3->7 : a b c e g d
del5  3->7*: a b c e g d
3->7* del5 : a b c e g d
3->7  del5*: a b c e g d
del6* 3->7 : a b c e f d
del6  3->7*: a b c e f d
3->7* del6 : a b c e f d
3->7  del6*: a b c e f d
del0* 4->0 : e b c d f g
del0  4->0*: e b c d f g
4->0* del0 : e b c d f g
4->0  del0*: e b c d f g
del1* 4->0 : e a c d f g
del1  4->0*: e a c d f g
4->0* del1 : e a c d f g
4->0  del1*: e a c d f g
del2* 4->0 : e a b d f g
del2  4->0*: e a b d f g
4->0* del2 : e a b d f g
4->0  del2*: e a b d f g
del3* 4->0 : e a b c f g
del3  4->0*: e a b c f g
4->0* del3 : e a b c f g
4->0  del3*: e a b c f g
del4* 4->0 : a b c d f g
del4  4->0*: a b c d f g
4->0* del4 : a b c d f g
4->0  del4*: a b c d f g
del5* 4->0 : e a b c d g
del5  4->0*: e a b c d g
4->0* del5 : e a b c d g
4->0  del5*: e a b c d g
del6* 4->0 : e a b c d f
del6  4->0*: e a b c d f
4->0* del6 : e a b c d f
4->0  del6*: e a b c d f
del0* 4->1 : e b c d f g
del0  4->1*: e b c d f g
4->1* del0 : e b c d f g
4->1  del0*: e b c d f g
del1* 4->1 : a e c d f g
del1  4->1*: a e c d f g
4->1* del1 : a e c d f g
4->1  del1*: a e c d f g
del2* 4->1 : a e b d f g
del2  4->1*: a e b d f g
4->1* del2 : a e b d f g
4->1  del2*: a e b d f g
del3* 4->1 : a e b c f g
del3  4->1*: a e b c f g
4->1* del3 : a e b c f g
4->1  del3*: a e b c f g
del4* 4->1 : a b c d f g
del4  4->1*: a b c d f g
4->1* del4 : a b c d f g
4->1  del4*: a b c d f g
del5* 4->1 : a e b c d g
del5  4->1*: a e b c d g
4->1* del5 : a e b c d g
4->1  del5*: a e b c d g
del6* 4->1 : a e b c d f
del6  4->1*: a e b c d f
4->1* del6 : a e b c d f
4->1  del6*: a e b c d f
del0* 4->2 : b e c d f g
del0  4->2*: b e c d f g
4->2* del0 : b e c d f g
4->2  del0*: b e c d f g
del1* 4->2 : a e c d f g
del1  4->2*: a e c d f g
4->2* del1 : a e c d f g
4->2  del1*: a e c d f g
del2* 4->2 : a b e d f g
del2  4->2*: a b e d f g
4->2* del2 : a b e d f g
4->2  del2*: a b e d f g
del3* 4->2 : a b e c f g
del3  4->2*: a b e c f g
4->2* del3 : a b e c f g
4->2  del3*: a b e c f g
del4* 4->2 : a b c d f g
del4  4->2*: a b c d f g
4->2* del4 : a b c d f g
4->2  del4*: a b c d f g
del5* 4->2 : a b e c d g
del5  4->2*: a b e c d g
4->2* del5 : a b e c d g
4->2  del5*: a b e c d g
del6* 4->2 : a b e c d f
del6  4->2*: a b e c d f
4->2* del6 : a b e c d f
4->2  del6*: a b e c d f
del0* 4->3 : b c e d f g
del0  4->3*: b c e d f g
4->3* del0 : b c e d f g
4->3  del0*: b c e d f g
del1* 4->3 : a c e d f g
del1  4->3*: a c e d f g
4->3* del1 : a c e d f g
4->3  del1*: a c e d f g
del2* 4->3 : a b e d f g
del2  4->3*: a b e d f g
4->3* del2 : a b e d f g
4->3  del2*: a b e d f g
del3* 4->3 : a b c e f g
del3  4->3*: a b c e f g
4->3* del3 : a b c e f g
4->3  del3*: a b c e f g
del4* 4->3 : a b c d f g
del4  4->3*: a b c d f g
4->3* del4 : a b c d f g
4->3  del4*: a b c d f g
del5* 4->3 : a b c e d g
del5  4->3*: a b c e d g
4->3* del5 : a b c e d g
4->3  del5*: a b c e d g
del6* 4->3 : a b c e d f
del6  4->3*: a b c e d f
4->3* del6 : a b c e d f
4->3  del6*: a b c e d f
del0* 4->4 : b c d e f g
del0  4->4*: b c d e f g
4->4* del0 : b c d e f g
4->4  del0*: b c d e f g
del1* 4->4 : a c d e f g
del1  4->4*: a c d e f g
4->4* del1 : a c d e f g
4->4  del1*: a c d e f g
del2* 4->4 : a b d e f g
del2  4->4*: a b d e f g
4->4* del2 : a b d e f g
4->4  del2*: a b d e f g
del3* 4->4 : a b c e f g
del3  4->4*: a b c e f g
4->4* del3 : a b c e f g
4->4  del3*: a b c e f g
del4* 4->4 : a b c d f g
del4  4->4*: a b c d f g
4->4* del4 : a b c d f g
4->4  del4*: a b c d f g
del5* 4->4 : a b c d e g
del5  4->4*: a b c d e g
4->4* del5 : a b c d e g
4->4  del5*: a b c d e g
del6* 4->4 : a b c d e f
del6  4->4*: a b c d e f
4->4* del6 : a b c d e f
4->4  del6*: a b c d e f
del0* 4->5 : b c d e f g
del0  4->5*: b c d e f g
4->5* del0 : b c d e f g
4->5  del0*: b c d e f g
del1* 4->5 : a c d e f g
del1  4->5*: a c d e f g
4->5* del1 : a c d e f g
4->5  del1*: a c d e f g
del2* 4->5 : a b d e f g
del2  4->5*: a b d e f g
4->5* del2 : a b d e f g
4->5  del2*: a b d e f g
del3* 4->5 : a b c e f g
del3  4->5*: a b c e f g
4->5* del3 : a b c e f g
4->5  del3*: a b c e f g
del4* 4->5 : a b c d f g
del4  4->5*: a b c d f g
4->5* del4 : a b c d f g
4->5  del4*: a b c d f g
del5* 4->5 : a b c d e g
del5  4->5*: a b c d e g
4->5* del5 : a b c d e g
4->5  del5*: a b c d e g
del6* 4->5 : a b c d e f
del6  4->5*: a b c d e f
4->5* del6 : a b c d e f
4->5  del6*: a b c d e f
del0* 4->6 : b c d f e g
del0  4->6*: b c d f e g
4->6* del0 : b c d f e g
4->6  del0*: b c d f e g
del1* 4->6 : a c d f e g
del1  4->6*: a c d f e g
4->6* del1 : a c d f e g
4->6  del1*: a c d f e g
del2* 4->6 : a b d f e g
del2  4->6*: a b d f e g
4->6* del2 : a b d f e g
4->6  del2*: a b d f e g
del3* 4->6 : a b c f e g
del3  4->6*: a b c f e g
4->6* del3 : a b c f e g
4->6  del3*: a b c f e g
del4* 4->6 : a b c d f g
del4  4->6*: a b c d f g
4->6* del4 : a b c d f g
4->6  del4*: a b c d f g
del5* 4->6 : a b c d e g
del5  4->6*: a b c d e g
4->6* del5 : a b c d e g
4->6  del5*: a b c d e g
del6* 4->6 : a b c d f e
del6  4->6*: a b c d f e
4->6* del6 : a b c d f e
4->6  del6*: a b c d f e
del0* 4->7 : b c d f g e
del0  4->7*: b c d f g e
4->7* del0 : b c d f g e
4->7  del0*: b c d f g e
del1* 4->7 : a c d f g e
del1  4->7*: a c d f g e
4->7* del1 : a c d f g e
4->7  del1*: a c d f g e
del2* 4->7 : a b d f g e
del2  4->7*: a b d f g e
4->7* del2 : a b d f g e
4->7  del2*: a b d f g e
del3* 4->7 : a b c f g e
del3  4->7*: a b c f g e
4->7* del3 : a b c f g e
4->7  del3*: a b c f g e
del4* 4->7 : a b c d f g
del4  4->7*: a b c d f g
4->7* del4 : a b c d f g
4->7  del4*: a b c d f g
del5* 4->7 : a b c d g e
del5  4->7*: a b c d g e
4->7* del5 : a b c d g e
4->7  del5*: a b c d g e
del6* 4->7 : a b c d f e
del6  4->7*: a b c d f e
4->7* del6 : a b c d f e
4->7  del6*: a b c d f e
del0* 5->0 : f b c d e g
del0  5->0*: f b c d e g
5->0* del0 : f b c d e g
5->0  del0*: f b c d e g
del1* 5->0 : f a c d e g
del1  5->0*: f a c d e g
5->0* del1 : f a c d e g
5->0  del1*: f a c d e g
del2* 5->0 : f a b d e g
del2  5->0*: f a b d e g
5->0* del2 : f a b d e g
5->0  del2*: f a b d e g
del3* 5->0 : f a b c e g
del3  5->0*: f a b c e g
5->0* del3 : f a b c e g
5->0  del3*: f a b c e g
del4* 5->0 : f a b c d g
del4  5->0*: f a b c d g
5->0* del4 : f a b c d g
5->0  del4*: f a b c d g
del5* 5->0 : a b c d e g
del5  5->0*: a b c d e g
5->0* del5 : a b c d e g
5->0  del5*: a b c d e g
del6* 5->0 : f a b c d e
del6  5->0*: f a b c d e
5->0* del6 : f a b c d e
5->0  del6*: f a b c d e
del0* 5->1 : f b c d e g
del0  5->1*: f b c d e g
5->1* del0 : f b c d e g
5->1  del0*: f b c d e g
del1* 5->1 : a f c d e g
del1  5->1*: a f c d e g
5->1* del1 : a f c d e g
5->1  del1*: a f c d e g
del2* 5->1 : a f b d e g
del2  5->1*: a f b d e g
5->1* del2 : a f b d e g
5->1  del2*: a f b d e g
del3* 5->1 : a f b c e g
del3  5->1*: a f b c e g
5->1* del3 : a f b c e g
5->1  del3*: a f b c e g
del4* 5->1 : a f b c d g
del4  5->1*: a f b c d g
5->1* del4 : a f b c d g
5->1  del4*: a f b c d g
del5* 5->1 : a b c d e g
del5  5->1*: a b c d e g
5->1* del5 : a b c d e g
5->1  del5*: a b c d e g
del6* 5->1 : a f b c d e
del6  5->1*: a f b c d e
5->1* del6 : a f b c d e
5->1  del6*: a f b c d e
del0* 5->2 : b f c d e g
del0  5->2*: b f c d e g
5->2* del0 : b f c d e g
5->2  del0*: b f c d e g
del1* 5->2 : a f c d e g
del1  5->2*: a f c d e g
5->2* del1 : a f c d e g
5->2  del1*: a f c d e g
del2* 5->2 : a b f d e g
del2  5->2*: a b f d e g
5->2* del2 : a b f d e g
5->2  del2*: a b f d e g
del3* 5->2 : a b f c e g
del3  5->2*: a b f c e g
5->2* del3 : a b f c e g
5->2  del3*: a b f c e g
del4* 5->2 : a b f c d g
del4  5->2*: a b f c d g
5->2* del4 : a b f c d g
5->2  del4*: a b f c d g
del5* 5->2 : a b c d e g
del5  5->2*: a b c d e g
5->2* del5 : a b c d e g
5->2  del5*: a b c d e g
del6* 5->2 : a b f c d e
del6  5->2*: a b f c d e
5->2* del6 : a b f c d e
5->2  del6*: a b f c d e
del0* 5->3 : b c f d e g
del0  5->3*: b c f d e g
5->3* del0 : b c f d e g
5->3  del0*: b c f d e g
del1* 5->3 : a c f d e g
del1  5->3*: a c f d e g
5->3* del1 : a c f d e g
5->3  del1*: a c f d e g
del2* 5->3 : a b f d e g
del2  5->3*: a b f d e g
5->3* del2 : a b f d e g
5->3  del2*: a b f d e g
del3* 5->3 : a b c f e g
del3  5->3*: a b c f e g
5->3* del3 : a b c f e g
5->3  del3*: a b c f e g
del4* 5->3 : a b c f d g
del4  5->3*: a b c f d g
5->3* del4 : a b c f d g
5->3  del4*: a b c f d g
del5* 5->3 : a b c d e g
del5  5->3*: a b c d e g
5->3* del5 : a b c d e g
5->3  del5*: a b c d e g
del6* 5->3 : a b c f d e
del6  5->3*: a b c f d e
5->3* del6 : a b c f d e
5->3  del6*: a b c f d e
del0* 5->4 : b c d f e g
del0  5->4*: b c d f e g
5->4* del0 : b c d f e g
5->4  del0*: b c d f e g
del1* 5->4 : a c d f e g
del1  5->4*: a c d f e g
5->4* del1 : a c d f e g
5->4  del1*: a c d f e g
del2* 5->4 : a b d f e g
del2  5->4*: a b d f e g
5->4* del2 : a b d f e g
5->4  del2*: a b d f e g
del3* 5->4 : a b c f e g
del3  5->4*: a b c f e g
5->4* del3 : a b c f e g
5->4  del3*: a b c f e g
del4* 5->4 : a b c d f g
del4  5->4*: a b c d f g
5->4* del4 : a b c d f g
5->4  del4*: a b c d f g
del5* 5->4 : a b c d e g
del5  5->4*: a b c d e g
5->4* del5 : a b c d e g
5->4  del5*: a b c d e g
del6* 5->4 : a b c d f e
del6  5->4*: a b c d f e
5->4* del6 : a b c d f e
5->4  del6*: a b c d f e
del0* 5->5 : b c d e f g
del0  5->5*: b c d e f g
5->5* del0 : b c d e f g
5->5  del0*: b c d e f g
del1* 5->5 : a c d e f g
del1  5->5*: a c d e f g
5->5* del1 : a c d e f g
5->5  del1*: a c d e f g
del2* 5->5 : a b d e f g
del2  5->5*: a b d e f g
5->5* del2 : a b d e f g
5->5  del2*: a b d e f g
del3* 5->5 : a b c e f g
del3  5->5*: a b c e f g
5->5* del3 : a b c e f g
5->5  del3*: a b c e f g
del4* 5->5 : a b c d f g
del4  5->5*: a b c d f g
5->5* del4 : a b c d f g
5->5  del4*: a b c d f g
del5* 5->5 : a b c d e g
del5  5->5*: a b c d e g
5->5* del5 : a b c d e g
5->5  del5*: a b c d e g
del6* 5->5 : a b c d e f
del6  5->5*: a b c d e f
5->5* del6 : a b c d e f
5->5  del6*: a b c d e f
del0* 5->6 : b c d e f g
del0  5->6*: b c d e f g
5->6* del0 : b c d e f g
5->6  del0*: b c d e f g
del1* 5->6 : a c d e f g
del1  5->6*: a c d e f g
5->6* del1 : a c d e f g
5->6  del1*: a c d e f g
del2* 5->6 : a b d e f g
del2  5->6*: a b d e f g
5->6* del2 : a b d e f g
5->6  del2*: a b d e f g
del3* 5->6 : a b c e f g
del3  5->6*: a b c e f g
5->6* del3 : a b c e f g
5->6  del3*: a b c e f g
del4* 5->6 : a b c d f g
del4  5->6*: a b c d f g
5->6* del4 : a b c d f g
5->6  del4*: a b c d f g
del5* 5->6 : a b c d e g
del5  5->6*: a b c d e g
5->6* del5 : a b c d e g
5->6  del5*: a b c d e g
del6* 5->6 : a b c d e f
del6  5->6*: a b c d e f
5->6* del6 : a b c d e f
5->6  del6*: a b c d e f
del0* 5->7 : b c d e g f
del0  5->7*: b c d e g f
5->7* del0 : b c d e g f
5->7  del0*: b c d e g f
del1* 5->7 : a c d e g f
del1  5->7*: a c d e g f
5->7* del1 : a c d e g f
5->7  del1*: a c d e g f
del2* 5->7 : a b d e g f
del2  5->7*: a b d e g f
5->7* del2 : a b d e g f
5->7  del2*: a b d e g f
del3* 5->7 : a b c e g f
del3  5->7*: a b c e g f
5->7* del3 : a b c e g f
5->7  del3*: a b c e g f
del4* 5->7 : a b c d g f
del4  5->7*: a b c d g f
5->7* del4 : a b c d g f
5->7  del4*: a b c d g f
del5* 5->7 : a b c d e g
del5  5->7*: a b c d e g
5->7* del5 : a b c d e g
5->7  del5*: a b c d e g
del6* 5->7 : a b c d e f
del6  5->7*: a b c d e f
5->7* del6 : a b c d e f
5->7  del6*: a b c d e f
del0* 6->0 : g b c d e f
del0  6->0*: g b c d e f
6->0* del0 : g b c d e f
6->0  del0*: g b c d e f
del1* 6->0 : g a c d e f
del1  6->0*: g a c d e f
6->0* del1 : g a c d e f
6->0  del1*: g a c d e f
del2* 6->0 : g a b d e f
del2  6->0*: g a b d e f
6->0* del2 : g a b d e f
6->0  del2*: g a b d e f
del3* 6->0 : g a b c e f
del3  6->0*: g a b c e f
6->0* del3 : g a b c e f
6->0  del3*: g a b c e f
del4* 6->0 : g a b c d f
del4  6->0*: g a b c d f
6->0* del4 : g a b c d f
6->0  del4*: g a b c d f
del5* 6->0 : g a b c d e
del5  6->0*: g a b c d e
6->0* del5 : g a b c d e
6->0  del5*: g a b c d e
del6* 6->0 : a b c d e f
del6  6->0*: a b c d e f
6->0* del6 : a b c d e f
6->0  del6*: a b c d e f
del0* 6->1 : g b c d e f
del0  6->1*: g b c d e f
6->1* del0 : g b c d e f
6->1  del0*: g b c d e f
del1* 6->1 : a g c d e f
del1  6->1*: a g c d e f
6->1* del1 : a g c d e f
6->1  del1*: a g c d e f
del2* 6->1 : a g b d e f
del2  6->1*: a g b d e f
6->1* del2 : a g b d e f
6->1  del2*: a g b d e f
del3* 6->1 : a g b c e f
del3  6->1*: a g b c e f
6->1* del3 : a g b c e f
6->1  del3*: a g b c e f
del4* 6->1 : a g b c d f
del4  6->1*: a g b c d f
6->1* del4 : a g b c d f
6->1  del4*: a g b c d f
del5* 6->1 : a g b c d e
del5  6->1*: a g b c d e
6->1* del5 : a g b c d e
6->1  del5*: a g b c d e
del6* 6->1 : a b c d e f
del6  6->1*: a b c d e f
6->1* del6 : a b c d e f
6->1  del6*: a b c d e f
del0* 6->2 : b g c d e f
del0  6->2*: b g c d e f
6->2* del0 : b g c d e f
6->2  del0*: b g c d e f
del1* 6->2 : a g c d e f
del1  6->2*: a g c d e f
6->2* del1 : a g c d e f
6->2  del1*: a g c d e f
del2* 6->2 : a b g d e f
del2  6->2*: a b g d e f
6->2* del2 : a b g d e f
6->2  del2*: a b g d e f
del3* 6->2 : a b g c e f
del3  6->2*: a b g c e f
6->2* del3 : a b g c e f
6->2  del3*: a b g c e f
del4* 6->2 : a b g c d f
del4  6->2*: a b g c d f
6->2* del4 : a b g c d f
6->2  del4*: a b g c d f
del5* 6->2 : a b g c d e
del5  6->2*: a b g c d e
6->2* del5 : a b g c d e
6->2  del5*: a b g c d e
del6* 6->2 : a b c d e f
del6  6->2*: a b c d e f
6->2* del6 : a b c d e f
6->2  del6*: a b c d e f
del0* 6->3 : b c g d e f
del0  6->3*: b c g d e f
6->3* del0 : b c g d e f
6->3  del0*: b c g d e f
del1* 6->3 : a c g d e f
del1  6->3*: a c g d e f
6->3* del1 : a c g d e f
6->3  del1*: a c g d e f
del2* 6->3 : a b g d e f
del2  6->3*: a b g d e f
6->3* del2 : a b g d e f
6->3  del2*: a b g d e f
del3* 6->3 : a b c g e f
del3  6->3*: a b c g e f
6->3* del3 : a b c g e f
6->3  del3*: a b c g e f
del4* 6->3 : a b c g d f
del4  6->3*: a b c g d f
6->3* del4 : a b c g d f
6->3  del4*: a b c g d f
del5* 6->3 : a b c g d e
del5  6->3*: a b c g d e
6->3* del5 : a b c g d e
6->3  del5*: a b c g d e
del6* 6->3 : a b c d e f
del6  6->3*: a b c d e f
6->3* del6 : a b c d e f
6->3  del6*: a b c d e f
del0* 6->4 : b c d g e f
del0  6->4*: b c d g e f
6->4* del0 : b c d g e f
6->4  del0*: b c d g e f
del1* 6->4 : a c d g e f
del1  6->4*: a c d g e f
6->4* del1 : a c d g e f
6->4  del1*: a c d g e f
del2* 6->4 : a b d g e f
del2  6->4*: a b d g e f
6->4* del2 : a b d g e f
6->4  del2*: a b d g e f
del3* 6->4 : a b c g e f
del3  6->4*: a b c g e f
6->4* del3 : a b c g e f
6->4  del3*: a b c g e f
del4* 6->4 : a b c d g f
del4  6->4*: a b c d g f
6->4* del4 : a b c d g f
6->4  del4*: a b c d g f
del5* 6->4 : a b c d g e
del5  6->4*: a b c d g e
6->4* del5 : a b c d g e
6->4  del5*: a b c d g e
del6* 6->4 : a b c d e f
del6  6->4*: a b c d e f
6->4* del6 : a b c d e f
6->4  del6*: a b c d e f
del0* 6->5 : b c d e g f
del0  6->5*: b c d e g f
6->5* del0 : b c d e g f
6->5  del0*: b c d e g f
del1* 6->5 : a c d e g f
del1  6->5*: a c d e g f
6->5* del1 : a c d e g f
6->5  del1*: a c d e g f
del2* 6->5 : a b d e g f
del2  6->5*: a b d e g f
6->5* del2 : a b d e g f
6->5  del2*: a b d e g f
del3* 6->5 : a b c e g f
del3  6->5*: a b c e g f
6->5* del3 : a b c e g f
6->5  del3*: a b c e g f
del4* 6->5 : a b c d g f
del4  6->5*: a b c d g f
6->5* del4 : a b c d g f
6->5  del4*: a b c d g f
del5* 6->5 : a b c d e g
del5  6->5*: a b c d e g
6->5* del5 : a b c d e g
6->5  del5*: a b c d e g
del6* 6->5 : a b c d e f
del6  6->5*: a b c d e f
6->5* del6 : a b c d e f
6->5  del6*: a b c d e f
del0* 6->6 : b c d e f g
del0  6->6*: b c d e f g
6->6* del0 : b c d e f g
6->6  del0*: b c d e f g
del1* 6->6 : a c d e f g
del1  6->6*: a c d e f g
6->6* del1 : a c d e f g
6->6  del1*: a c d e f g
del2* 6->6 : a b d e f g
del2  6->6*: a b d e f g
6->6* del2 : a b d e f g
6->6  del2*: a b d e f g
del3* 6->6 : a b c e f g
del3  6->6*: a b c e f g
6->6* del3 : a b c e f g
6->6  del3*: a b c e f g
del4* 6->6 : a b c d f g
del4  6->6*: a b c d f g
6->6* del4 : a b c d f g
6->6  del4*: a b c d f g
del5* 6->6 : a b c d e g
del5  6->6*: a b c d e g
6->6* del5 : a b c d e g
6->6  del5*: a b c d e g
del6* 6->6 : a b c d e f
del6  6->6*: a b c d e f
6->6* del6 : a b c d e f
6->6  del6*: a b c d e f
del0* 6->7 : b c d e f g
del0  6->7*: b c d e f g
6->7* del0 : b c d e f g
6->7  del0*: b c d e f g
del1* 6->7 : a c d e f g
del1  6->7*: a c d e f g
6->7* del1 : a c d e f g
6->7  del1*: a c d e f g
del2* 6->7 : a b d e f g
del2  6->7*: a b d e f g
6->7* del2 : a b d e f g
6->7  del2*: a b d e f g
del3* 6->7 : a b c e f g
del3  6->7*: a b c e f g
6->7* del3 : a b c e f g
6->7  del3*: a b c e f g
del4* 6->7 : a b c d f g
del4  6->7*: a b c d f g
6->7* del4 : a b c d f g
6->7  del4*: a b c d f g
del5* 6->7 : a b c d e g
del5  6->7*: a b c d e g
6->7* del5 : a b c d e g
6->7  del5*: a b c d e g
del6* 6->7 : a b c d e f
del6  6->7*: a b c d e f
6->7* del6 : a b c d e f
6->7  del6*: a b c d e f''';

const expectedTestTransformInsertInsert = '''
ins0* ins0 : X Y a b c d
ins0  ins0*: Y X a b c d
ins0* ins1 : X a Y b c d
ins0  ins1*: X a Y b c d
ins0* ins2 : X a b Y c d
ins0  ins2*: X a b Y c d
ins0* ins3 : X a b c Y d
ins0  ins3*: X a b c Y d
ins0* ins4 : X a b c d Y
ins0  ins4*: X a b c d Y
ins1* ins0 : Y a X b c d
ins1  ins0*: Y a X b c d
ins1* ins1 : a X Y b c d
ins1  ins1*: a Y X b c d
ins1* ins2 : a X b Y c d
ins1  ins2*: a X b Y c d
ins1* ins3 : a X b c Y d
ins1  ins3*: a X b c Y d
ins1* ins4 : a X b c d Y
ins1  ins4*: a X b c d Y
ins2* ins0 : Y a b X c d
ins2  ins0*: Y a b X c d
ins2* ins1 : a Y b X c d
ins2  ins1*: a Y b X c d
ins2* ins2 : a b X Y c d
ins2  ins2*: a b Y X c d
ins2* ins3 : a b X c Y d
ins2  ins3*: a b X c Y d
ins2* ins4 : a b X c d Y
ins2  ins4*: a b X c d Y
ins3* ins0 : Y a b c X d
ins3  ins0*: Y a b c X d
ins3* ins1 : a Y b c X d
ins3  ins1*: a Y b c X d
ins3* ins2 : a b Y c X d
ins3  ins2*: a b Y c X d
ins3* ins3 : a b c X Y d
ins3  ins3*: a b c Y X d
ins3* ins4 : a b c X d Y
ins3  ins4*: a b c X d Y
ins4* ins0 : Y a b c d X
ins4  ins0*: Y a b c d X
ins4* ins1 : a Y b c d X
ins4  ins1*: a Y b c d X
ins4* ins2 : a b Y c d X
ins4  ins2*: a b Y c d X
ins4* ins3 : a b c Y d X
ins4  ins3*: a b c Y d X
ins4* ins4 : a b c d X Y
ins4  ins4*: a b c d Y X''';

const expectedTestTransformMoveInsert = '''
0->0* ins0 : X a b c d e
0->0  ins0*: X a b c d e
ins0* 0->0 : X a b c d e
ins0  0->0*: X a b c d e
0->0* ins1 : a X b c d e
0->0  ins1*: a X b c d e
ins1* 0->0 : a X b c d e
ins1  0->0*: a X b c d e
0->0* ins2 : a b X c d e
0->0  ins2*: a b X c d e
ins2* 0->0 : a b X c d e
ins2  0->0*: a b X c d e
0->0* ins3 : a b c X d e
0->0  ins3*: a b c X d e
ins3* 0->0 : a b c X d e
ins3  0->0*: a b c X d e
0->0* ins4 : a b c d X e
0->0  ins4*: a b c d X e
ins4* 0->0 : a b c d X e
ins4  0->0*: a b c d X e
0->0* ins5 : a b c d e X
0->0  ins5*: a b c d e X
ins5* 0->0 : a b c d e X
ins5  0->0*: a b c d e X
0->1* ins0 : X a b c d e
0->1  ins0*: X a b c d e
ins0* 0->1 : X a b c d e
ins0  0->1*: X a b c d e
0->1* ins1 : a X b c d e
0->1  ins1*: a X b c d e
ins1* 0->1 : a X b c d e
ins1  0->1*: a X b c d e
0->1* ins2 : a b X c d e
0->1  ins2*: a b X c d e
ins2* 0->1 : a b X c d e
ins2  0->1*: a b X c d e
0->1* ins3 : a b c X d e
0->1  ins3*: a b c X d e
ins3* 0->1 : a b c X d e
ins3  0->1*: a b c X d e
0->1* ins4 : a b c d X e
0->1  ins4*: a b c d X e
ins4* 0->1 : a b c d X e
ins4  0->1*: a b c d X e
0->1* ins5 : a b c d e X
0->1  ins5*: a b c d e X
ins5* 0->1 : a b c d e X
ins5  0->1*: a b c d e X
0->2* ins0 : X b a c d e
0->2  ins0*: X b a c d e
ins0* 0->2 : X b a c d e
ins0  0->2*: X b a c d e
0->2* ins1 : X b a c d e
0->2  ins1*: X b a c d e
ins1* 0->2 : X b a c d e
ins1  0->2*: X b a c d e
0->2* ins2 : b a X c d e
0->2  ins2*: b X a c d e
ins2* 0->2 : b X a c d e
ins2  0->2*: b a X c d e
0->2* ins3 : b a c X d e
0->2  ins3*: b a c X d e
ins3* 0->2 : b a c X d e
ins3  0->2*: b a c X d e
0->2* ins4 : b a c d X e
0->2  ins4*: b a c d X e
ins4* 0->2 : b a c d X e
ins4  0->2*: b a c d X e
0->2* ins5 : b a c d e X
0->2  ins5*: b a c d e X
ins5* 0->2 : b a c d e X
ins5  0->2*: b a c d e X
0->3* ins0 : X b c a d e
0->3  ins0*: X b c a d e
ins0* 0->3 : X b c a d e
ins0  0->3*: X b c a d e
0->3* ins1 : X b c a d e
0->3  ins1*: X b c a d e
ins1* 0->3 : X b c a d e
ins1  0->3*: X b c a d e
0->3* ins2 : b X c a d e
0->3  ins2*: b X c a d e
ins2* 0->3 : b X c a d e
ins2  0->3*: b X c a d e
0->3* ins3 : b c a X d e
0->3  ins3*: b c X a d e
ins3* 0->3 : b c X a d e
ins3  0->3*: b c a X d e
0->3* ins4 : b c a d X e
0->3  ins4*: b c a d X e
ins4* 0->3 : b c a d X e
ins4  0->3*: b c a d X e
0->3* ins5 : b c a d e X
0->3  ins5*: b c a d e X
ins5* 0->3 : b c a d e X
ins5  0->3*: b c a d e X
0->4* ins0 : X b c d a e
0->4  ins0*: X b c d a e
ins0* 0->4 : X b c d a e
ins0  0->4*: X b c d a e
0->4* ins1 : X b c d a e
0->4  ins1*: X b c d a e
ins1* 0->4 : X b c d a e
ins1  0->4*: X b c d a e
0->4* ins2 : b X c d a e
0->4  ins2*: b X c d a e
ins2* 0->4 : b X c d a e
ins2  0->4*: b X c d a e
0->4* ins3 : b c X d a e
0->4  ins3*: b c X d a e
ins3* 0->4 : b c X d a e
ins3  0->4*: b c X d a e
0->4* ins4 : b c d a X e
0->4  ins4*: b c d X a e
ins4* 0->4 : b c d X a e
ins4  0->4*: b c d a X e
0->4* ins5 : b c d a e X
0->4  ins5*: b c d a e X
ins5* 0->4 : b c d a e X
ins5  0->4*: b c d a e X
0->5* ins0 : X b c d e a
0->5  ins0*: X b c d e a
ins0* 0->5 : X b c d e a
ins0  0->5*: X b c d e a
0->5* ins1 : X b c d e a
0->5  ins1*: X b c d e a
ins1* 0->5 : X b c d e a
ins1  0->5*: X b c d e a
0->5* ins2 : b X c d e a
0->5  ins2*: b X c d e a
ins2* 0->5 : b X c d e a
ins2  0->5*: b X c d e a
0->5* ins3 : b c X d e a
0->5  ins3*: b c X d e a
ins3* 0->5 : b c X d e a
ins3  0->5*: b c X d e a
0->5* ins4 : b c d X e a
0->5  ins4*: b c d X e a
ins4* 0->5 : b c d X e a
ins4  0->5*: b c d X e a
0->5* ins5 : b c d e a X
0->5  ins5*: b c d e X a
ins5* 0->5 : b c d e X a
ins5  0->5*: b c d e a X
1->0* ins0 : b X a c d e
1->0  ins0*: X b a c d e
ins0* 1->0 : X b a c d e
ins0  1->0*: b X a c d e
1->0* ins1 : b a X c d e
1->0  ins1*: b a X c d e
ins1* 1->0 : b a X c d e
ins1  1->0*: b a X c d e
1->0* ins2 : b a X c d e
1->0  ins2*: b a X c d e
ins2* 1->0 : b a X c d e
ins2  1->0*: b a X c d e
1->0* ins3 : b a c X d e
1->0  ins3*: b a c X d e
ins3* 1->0 : b a c X d e
ins3  1->0*: b a c X d e
1->0* ins4 : b a c d X e
1->0  ins4*: b a c d X e
ins4* 1->0 : b a c d X e
ins4  1->0*: b a c d X e
1->0* ins5 : b a c d e X
1->0  ins5*: b a c d e X
ins5* 1->0 : b a c d e X
ins5  1->0*: b a c d e X
1->1* ins0 : X a b c d e
1->1  ins0*: X a b c d e
ins0* 1->1 : X a b c d e
ins0  1->1*: X a b c d e
1->1* ins1 : a X b c d e
1->1  ins1*: a X b c d e
ins1* 1->1 : a X b c d e
ins1  1->1*: a X b c d e
1->1* ins2 : a b X c d e
1->1  ins2*: a b X c d e
ins2* 1->1 : a b X c d e
ins2  1->1*: a b X c d e
1->1* ins3 : a b c X d e
1->1  ins3*: a b c X d e
ins3* 1->1 : a b c X d e
ins3  1->1*: a b c X d e
1->1* ins4 : a b c d X e
1->1  ins4*: a b c d X e
ins4* 1->1 : a b c d X e
ins4  1->1*: a b c d X e
1->1* ins5 : a b c d e X
1->1  ins5*: a b c d e X
ins5* 1->1 : a b c d e X
ins5  1->1*: a b c d e X
1->2* ins0 : X a b c d e
1->2  ins0*: X a b c d e
ins0* 1->2 : X a b c d e
ins0  1->2*: X a b c d e
1->2* ins1 : a X b c d e
1->2  ins1*: a X b c d e
ins1* 1->2 : a X b c d e
ins1  1->2*: a X b c d e
1->2* ins2 : a b X c d e
1->2  ins2*: a b X c d e
ins2* 1->2 : a b X c d e
ins2  1->2*: a b X c d e
1->2* ins3 : a b c X d e
1->2  ins3*: a b c X d e
ins3* 1->2 : a b c X d e
ins3  1->2*: a b c X d e
1->2* ins4 : a b c d X e
1->2  ins4*: a b c d X e
ins4* 1->2 : a b c d X e
ins4  1->2*: a b c d X e
1->2* ins5 : a b c d e X
1->2  ins5*: a b c d e X
ins5* 1->2 : a b c d e X
ins5  1->2*: a b c d e X
1->3* ins0 : X a c b d e
1->3  ins0*: X a c b d e
ins0* 1->3 : X a c b d e
ins0  1->3*: X a c b d e
1->3* ins1 : a X c b d e
1->3  ins1*: a X c b d e
ins1* 1->3 : a X c b d e
ins1  1->3*: a X c b d e
1->3* ins2 : a X c b d e
1->3  ins2*: a X c b d e
ins2* 1->3 : a X c b d e
ins2  1->3*: a X c b d e
1->3* ins3 : a c b X d e
1->3  ins3*: a c X b d e
ins3* 1->3 : a c X b d e
ins3  1->3*: a c b X d e
1->3* ins4 : a c b d X e
1->3  ins4*: a c b d X e
ins4* 1->3 : a c b d X e
ins4  1->3*: a c b d X e
1->3* ins5 : a c b d e X
1->3  ins5*: a c b d e X
ins5* 1->3 : a c b d e X
ins5  1->3*: a c b d e X
1->4* ins0 : X a c d b e
1->4  ins0*: X a c d b e
ins0* 1->4 : X a c d b e
ins0  1->4*: X a c d b e
1->4* ins1 : a X c d b e
1->4  ins1*: a X c d b e
ins1* 1->4 : a X c d b e
ins1  1->4*: a X c d b e
1->4* ins2 : a X c d b e
1->4  ins2*: a X c d b e
ins2* 1->4 : a X c d b e
ins2  1->4*: a X c d b e
1->4* ins3 : a c X d b e
1->4  ins3*: a c X d b e
ins3* 1->4 : a c X d b e
ins3  1->4*: a c X d b e
1->4* ins4 : a c d b X e
1->4  ins4*: a c d X b e
ins4* 1->4 : a c d X b e
ins4  1->4*: a c d b X e
1->4* ins5 : a c d b e X
1->4  ins5*: a c d b e X
ins5* 1->4 : a c d b e X
ins5  1->4*: a c d b e X
1->5* ins0 : X a c d e b
1->5  ins0*: X a c d e b
ins0* 1->5 : X a c d e b
ins0  1->5*: X a c d e b
1->5* ins1 : a X c d e b
1->5  ins1*: a X c d e b
ins1* 1->5 : a X c d e b
ins1  1->5*: a X c d e b
1->5* ins2 : a X c d e b
1->5  ins2*: a X c d e b
ins2* 1->5 : a X c d e b
ins2  1->5*: a X c d e b
1->5* ins3 : a c X d e b
1->5  ins3*: a c X d e b
ins3* 1->5 : a c X d e b
ins3  1->5*: a c X d e b
1->5* ins4 : a c d X e b
1->5  ins4*: a c d X e b
ins4* 1->5 : a c d X e b
ins4  1->5*: a c d X e b
1->5* ins5 : a c d e b X
1->5  ins5*: a c d e X b
ins5* 1->5 : a c d e X b
ins5  1->5*: a c d e b X
2->0* ins0 : c X a b d e
2->0  ins0*: X c a b d e
ins0* 2->0 : X c a b d e
ins0  2->0*: c X a b d e
2->0* ins1 : c a X b d e
2->0  ins1*: c a X b d e
ins1* 2->0 : c a X b d e
ins1  2->0*: c a X b d e
2->0* ins2 : c a b X d e
2->0  ins2*: c a b X d e
ins2* 2->0 : c a b X d e
ins2  2->0*: c a b X d e
2->0* ins3 : c a b X d e
2->0  ins3*: c a b X d e
ins3* 2->0 : c a b X d e
ins3  2->0*: c a b X d e
2->0* ins4 : c a b d X e
2->0  ins4*: c a b d X e
ins4* 2->0 : c a b d X e
ins4  2->0*: c a b d X e
2->0* ins5 : c a b d e X
2->0  ins5*: c a b d e X
ins5* 2->0 : c a b d e X
ins5  2->0*: c a b d e X
2->1* ins0 : X a c b d e
2->1  ins0*: X a c b d e
ins0* 2->1 : X a c b d e
ins0  2->1*: X a c b d e
2->1* ins1 : a c X b d e
2->1  ins1*: a X c b d e
ins1* 2->1 : a X c b d e
ins1  2->1*: a c X b d e
2->1* ins2 : a c b X d e
2->1  ins2*: a c b X d e
ins2* 2->1 : a c b X d e
ins2  2->1*: a c b X d e
2->1* ins3 : a c b X d e
2->1  ins3*: a c b X d e
ins3* 2->1 : a c b X d e
ins3  2->1*: a c b X d e
2->1* ins4 : a c b d X e
2->1  ins4*: a c b d X e
ins4* 2->1 : a c b d X e
ins4  2->1*: a c b d X e
2->1* ins5 : a c b d e X
2->1  ins5*: a c b d e X
ins5* 2->1 : a c b d e X
ins5  2->1*: a c b d e X
2->2* ins0 : X a b c d e
2->2  ins0*: X a b c d e
ins0* 2->2 : X a b c d e
ins0  2->2*: X a b c d e
2->2* ins1 : a X b c d e
2->2  ins1*: a X b c d e
ins1* 2->2 : a X b c d e
ins1  2->2*: a X b c d e
2->2* ins2 : a b X c d e
2->2  ins2*: a b X c d e
ins2* 2->2 : a b X c d e
ins2  2->2*: a b X c d e
2->2* ins3 : a b c X d e
2->2  ins3*: a b c X d e
ins3* 2->2 : a b c X d e
ins3  2->2*: a b c X d e
2->2* ins4 : a b c d X e
2->2  ins4*: a b c d X e
ins4* 2->2 : a b c d X e
ins4  2->2*: a b c d X e
2->2* ins5 : a b c d e X
2->2  ins5*: a b c d e X
ins5* 2->2 : a b c d e X
ins5  2->2*: a b c d e X
2->3* ins0 : X a b c d e
2->3  ins0*: X a b c d e
ins0* 2->3 : X a b c d e
ins0  2->3*: X a b c d e
2->3* ins1 : a X b c d e
2->3  ins1*: a X b c d e
ins1* 2->3 : a X b c d e
ins1  2->3*: a X b c d e
2->3* ins2 : a b X c d e
2->3  ins2*: a b X c d e
ins2* 2->3 : a b X c d e
ins2  2->3*: a b X c d e
2->3* ins3 : a b c X d e
2->3  ins3*: a b c X d e
ins3* 2->3 : a b c X d e
ins3  2->3*: a b c X d e
2->3* ins4 : a b c d X e
2->3  ins4*: a b c d X e
ins4* 2->3 : a b c d X e
ins4  2->3*: a b c d X e
2->3* ins5 : a b c d e X
2->3  ins5*: a b c d e X
ins5* 2->3 : a b c d e X
ins5  2->3*: a b c d e X
2->4* ins0 : X a b d c e
2->4  ins0*: X a b d c e
ins0* 2->4 : X a b d c e
ins0  2->4*: X a b d c e
2->4* ins1 : a X b d c e
2->4  ins1*: a X b d c e
ins1* 2->4 : a X b d c e
ins1  2->4*: a X b d c e
2->4* ins2 : a b X d c e
2->4  ins2*: a b X d c e
ins2* 2->4 : a b X d c e
ins2  2->4*: a b X d c e
2->4* ins3 : a b X d c e
2->4  ins3*: a b X d c e
ins3* 2->4 : a b X d c e
ins3  2->4*: a b X d c e
2->4* ins4 : a b d c X e
2->4  ins4*: a b d X c e
ins4* 2->4 : a b d X c e
ins4  2->4*: a b d c X e
2->4* ins5 : a b d c e X
2->4  ins5*: a b d c e X
ins5* 2->4 : a b d c e X
ins5  2->4*: a b d c e X
2->5* ins0 : X a b d e c
2->5  ins0*: X a b d e c
ins0* 2->5 : X a b d e c
ins0  2->5*: X a b d e c
2->5* ins1 : a X b d e c
2->5  ins1*: a X b d e c
ins1* 2->5 : a X b d e c
ins1  2->5*: a X b d e c
2->5* ins2 : a b X d e c
2->5  ins2*: a b X d e c
ins2* 2->5 : a b X d e c
ins2  2->5*: a b X d e c
2->5* ins3 : a b X d e c
2->5  ins3*: a b X d e c
ins3* 2->5 : a b X d e c
ins3  2->5*: a b X d e c
2->5* ins4 : a b d X e c
2->5  ins4*: a b d X e c
ins4* 2->5 : a b d X e c
ins4  2->5*: a b d X e c
2->5* ins5 : a b d e c X
2->5  ins5*: a b d e X c
ins5* 2->5 : a b d e X c
ins5  2->5*: a b d e c X
3->0* ins0 : d X a b c e
3->0  ins0*: X d a b c e
ins0* 3->0 : X d a b c e
ins0  3->0*: d X a b c e
3->0* ins1 : d a X b c e
3->0  ins1*: d a X b c e
ins1* 3->0 : d a X b c e
ins1  3->0*: d a X b c e
3->0* ins2 : d a b X c e
3->0  ins2*: d a b X c e
ins2* 3->0 : d a b X c e
ins2  3->0*: d a b X c e
3->0* ins3 : d a b c X e
3->0  ins3*: d a b c X e
ins3* 3->0 : d a b c X e
ins3  3->0*: d a b c X e
3->0* ins4 : d a b c X e
3->0  ins4*: d a b c X e
ins4* 3->0 : d a b c X e
ins4  3->0*: d a b c X e
3->0* ins5 : d a b c e X
3->0  ins5*: d a b c e X
ins5* 3->0 : d a b c e X
ins5  3->0*: d a b c e X
3->1* ins0 : X a d b c e
3->1  ins0*: X a d b c e
ins0* 3->1 : X a d b c e
ins0  3->1*: X a d b c e
3->1* ins1 : a d X b c e
3->1  ins1*: a X d b c e
ins1* 3->1 : a X d b c e
ins1  3->1*: a d X b c e
3->1* ins2 : a d b X c e
3->1  ins2*: a d b X c e
ins2* 3->1 : a d b X c e
ins2  3->1*: a d b X c e
3->1* ins3 : a d b c X e
3->1  ins3*: a d b c X e
ins3* 3->1 : a d b c X e
ins3  3->1*: a d b c X e
3->1* ins4 : a d b c X e
3->1  ins4*: a d b c X e
ins4* 3->1 : a d b c X e
ins4  3->1*: a d b c X e
3->1* ins5 : a d b c e X
3->1  ins5*: a d b c e X
ins5* 3->1 : a d b c e X
ins5  3->1*: a d b c e X
3->2* ins0 : X a b d c e
3->2  ins0*: X a b d c e
ins0* 3->2 : X a b d c e
ins0  3->2*: X a b d c e
3->2* ins1 : a X b d c e
3->2  ins1*: a X b d c e
ins1* 3->2 : a X b d c e
ins1  3->2*: a X b d c e
3->2* ins2 : a b d X c e
3->2  ins2*: a b X d c e
ins2* 3->2 : a b X d c e
ins2  3->2*: a b d X c e
3->2* ins3 : a b d c X e
3->2  ins3*: a b d c X e
ins3* 3->2 : a b d c X e
ins3  3->2*: a b d c X e
3->2* ins4 : a b d c X e
3->2  ins4*: a b d c X e
ins4* 3->2 : a b d c X e
ins4  3->2*: a b d c X e
3->2* ins5 : a b d c e X
3->2  ins5*: a b d c e X
ins5* 3->2 : a b d c e X
ins5  3->2*: a b d c e X
3->3* ins0 : X a b c d e
3->3  ins0*: X a b c d e
ins0* 3->3 : X a b c d e
ins0  3->3*: X a b c d e
3->3* ins1 : a X b c d e
3->3  ins1*: a X b c d e
ins1* 3->3 : a X b c d e
ins1  3->3*: a X b c d e
3->3* ins2 : a b X c d e
3->3  ins2*: a b X c d e
ins2* 3->3 : a b X c d e
ins2  3->3*: a b X c d e
3->3* ins3 : a b c X d e
3->3  ins3*: a b c X d e
ins3* 3->3 : a b c X d e
ins3  3->3*: a b c X d e
3->3* ins4 : a b c d X e
3->3  ins4*: a b c d X e
ins4* 3->3 : a b c d X e
ins4  3->3*: a b c d X e
3->3* ins5 : a b c d e X
3->3  ins5*: a b c d e X
ins5* 3->3 : a b c d e X
ins5  3->3*: a b c d e X
3->4* ins0 : X a b c d e
3->4  ins0*: X a b c d e
ins0* 3->4 : X a b c d e
ins0  3->4*: X a b c d e
3->4* ins1 : a X b c d e
3->4  ins1*: a X b c d e
ins1* 3->4 : a X b c d e
ins1  3->4*: a X b c d e
3->4* ins2 : a b X c d e
3->4  ins2*: a b X c d e
ins2* 3->4 : a b X c d e
ins2  3->4*: a b X c d e
3->4* ins3 : a b c X d e
3->4  ins3*: a b c X d e
ins3* 3->4 : a b c X d e
ins3  3->4*: a b c X d e
3->4* ins4 : a b c d X e
3->4  ins4*: a b c d X e
ins4* 3->4 : a b c d X e
ins4  3->4*: a b c d X e
3->4* ins5 : a b c d e X
3->4  ins5*: a b c d e X
ins5* 3->4 : a b c d e X
ins5  3->4*: a b c d e X
3->5* ins0 : X a b c e d
3->5  ins0*: X a b c e d
ins0* 3->5 : X a b c e d
ins0  3->5*: X a b c e d
3->5* ins1 : a X b c e d
3->5  ins1*: a X b c e d
ins1* 3->5 : a X b c e d
ins1  3->5*: a X b c e d
3->5* ins2 : a b X c e d
3->5  ins2*: a b X c e d
ins2* 3->5 : a b X c e d
ins2  3->5*: a b X c e d
3->5* ins3 : a b c X e d
3->5  ins3*: a b c X e d
ins3* 3->5 : a b c X e d
ins3  3->5*: a b c X e d
3->5* ins4 : a b c X e d
3->5  ins4*: a b c X e d
ins4* 3->5 : a b c X e d
ins4  3->5*: a b c X e d
3->5* ins5 : a b c e d X
3->5  ins5*: a b c e X d
ins5* 3->5 : a b c e X d
ins5  3->5*: a b c e d X
4->0* ins0 : e X a b c d
4->0  ins0*: X e a b c d
ins0* 4->0 : X e a b c d
ins0  4->0*: e X a b c d
4->0* ins1 : e a X b c d
4->0  ins1*: e a X b c d
ins1* 4->0 : e a X b c d
ins1  4->0*: e a X b c d
4->0* ins2 : e a b X c d
4->0  ins2*: e a b X c d
ins2* 4->0 : e a b X c d
ins2  4->0*: e a b X c d
4->0* ins3 : e a b c X d
4->0  ins3*: e a b c X d
ins3* 4->0 : e a b c X d
ins3  4->0*: e a b c X d
4->0* ins4 : e a b c d X
4->0  ins4*: e a b c d X
ins4* 4->0 : e a b c d X
ins4  4->0*: e a b c d X
4->0* ins5 : e a b c d X
4->0  ins5*: e a b c d X
ins5* 4->0 : e a b c d X
ins5  4->0*: e a b c d X
4->1* ins0 : X a e b c d
4->1  ins0*: X a e b c d
ins0* 4->1 : X a e b c d
ins0  4->1*: X a e b c d
4->1* ins1 : a e X b c d
4->1  ins1*: a X e b c d
ins1* 4->1 : a X e b c d
ins1  4->1*: a e X b c d
4->1* ins2 : a e b X c d
4->1  ins2*: a e b X c d
ins2* 4->1 : a e b X c d
ins2  4->1*: a e b X c d
4->1* ins3 : a e b c X d
4->1  ins3*: a e b c X d
ins3* 4->1 : a e b c X d
ins3  4->1*: a e b c X d
4->1* ins4 : a e b c d X
4->1  ins4*: a e b c d X
ins4* 4->1 : a e b c d X
ins4  4->1*: a e b c d X
4->1* ins5 : a e b c d X
4->1  ins5*: a e b c d X
ins5* 4->1 : a e b c d X
ins5  4->1*: a e b c d X
4->2* ins0 : X a b e c d
4->2  ins0*: X a b e c d
ins0* 4->2 : X a b e c d
ins0  4->2*: X a b e c d
4->2* ins1 : a X b e c d
4->2  ins1*: a X b e c d
ins1* 4->2 : a X b e c d
ins1  4->2*: a X b e c d
4->2* ins2 : a b e X c d
4->2  ins2*: a b X e c d
ins2* 4->2 : a b X e c d
ins2  4->2*: a b e X c d
4->2* ins3 : a b e c X d
4->2  ins3*: a b e c X d
ins3* 4->2 : a b e c X d
ins3  4->2*: a b e c X d
4->2* ins4 : a b e c d X
4->2  ins4*: a b e c d X
ins4* 4->2 : a b e c d X
ins4  4->2*: a b e c d X
4->2* ins5 : a b e c d X
4->2  ins5*: a b e c d X
ins5* 4->2 : a b e c d X
ins5  4->2*: a b e c d X
4->3* ins0 : X a b c e d
4->3  ins0*: X a b c e d
ins0* 4->3 : X a b c e d
ins0  4->3*: X a b c e d
4->3* ins1 : a X b c e d
4->3  ins1*: a X b c e d
ins1* 4->3 : a X b c e d
ins1  4->3*: a X b c e d
4->3* ins2 : a b X c e d
4->3  ins2*: a b X c e d
ins2* 4->3 : a b X c e d
ins2  4->3*: a b X c e d
4->3* ins3 : a b c e X d
4->3  ins3*: a b c X e d
ins3* 4->3 : a b c X e d
ins3  4->3*: a b c e X d
4->3* ins4 : a b c e d X
4->3  ins4*: a b c e d X
ins4* 4->3 : a b c e d X
ins4  4->3*: a b c e d X
4->3* ins5 : a b c e d X
4->3  ins5*: a b c e d X
ins5* 4->3 : a b c e d X
ins5  4->3*: a b c e d X
4->4* ins0 : X a b c d e
4->4  ins0*: X a b c d e
ins0* 4->4 : X a b c d e
ins0  4->4*: X a b c d e
4->4* ins1 : a X b c d e
4->4  ins1*: a X b c d e
ins1* 4->4 : a X b c d e
ins1  4->4*: a X b c d e
4->4* ins2 : a b X c d e
4->4  ins2*: a b X c d e
ins2* 4->4 : a b X c d e
ins2  4->4*: a b X c d e
4->4* ins3 : a b c X d e
4->4  ins3*: a b c X d e
ins3* 4->4 : a b c X d e
ins3  4->4*: a b c X d e
4->4* ins4 : a b c d X e
4->4  ins4*: a b c d X e
ins4* 4->4 : a b c d X e
ins4  4->4*: a b c d X e
4->4* ins5 : a b c d e X
4->4  ins5*: a b c d e X
ins5* 4->4 : a b c d e X
ins5  4->4*: a b c d e X
4->5* ins0 : X a b c d e
4->5  ins0*: X a b c d e
ins0* 4->5 : X a b c d e
ins0  4->5*: X a b c d e
4->5* ins1 : a X b c d e
4->5  ins1*: a X b c d e
ins1* 4->5 : a X b c d e
ins1  4->5*: a X b c d e
4->5* ins2 : a b X c d e
4->5  ins2*: a b X c d e
ins2* 4->5 : a b X c d e
ins2  4->5*: a b X c d e
4->5* ins3 : a b c X d e
4->5  ins3*: a b c X d e
ins3* 4->5 : a b c X d e
ins3  4->5*: a b c X d e
4->5* ins4 : a b c d X e
4->5  ins4*: a b c d X e
ins4* 4->5 : a b c d X e
ins4  4->5*: a b c d X e
4->5* ins5 : a b c d e X
4->5  ins5*: a b c d e X
ins5* 4->5 : a b c d e X
ins5  4->5*: a b c d e X''';

const expectedTestTransformDeleteDeleteIndex = '''
del0* del0 : b c d
del0  del0*: b c d
del0* del1 : c d
del0  del1*: c d
del0* del2 : b d
del0  del2*: b d
del0* del3 : b c
del0  del3*: b c
del1* del0 : c d
del1  del0*: c d
del1* del1 : a c d
del1  del1*: a c d
del1* del2 : a d
del1  del2*: a d
del1* del3 : a c
del1  del3*: a c
del2* del0 : b d
del2  del0*: b d
del2* del1 : a d
del2  del1*: a d
del2* del2 : a b d
del2  del2*: a b d
del2* del3 : a b
del2  del3*: a b
del3* del0 : b c
del3  del0*: b c
del3* del1 : a c
del3  del1*: a c
del3* del2 : a b
del3  del2*: a b
del3* del3 : a b c
del3  del3*: a b c''';

const expectedTestTransformInsertDelete = '''
ins0* del0 : X b c d
ins0  del0*: X b c d
del0* ins0 : X b c d
del0  ins0*: X b c d
ins0* del1 : X a c d
ins0  del1*: X a c d
del1* ins0 : X a c d
del1  ins0*: X a c d
ins0* del2 : X a b d
ins0  del2*: X a b d
del2* ins0 : X a b d
del2  ins0*: X a b d
ins0* del3 : X a b c
ins0  del3*: X a b c
del3* ins0 : X a b c
del3  ins0*: X a b c
ins1* del0 : X b c d
ins1  del0*: X b c d
del0* ins1 : X b c d
del0  ins1*: X b c d
ins1* del1 : a X c d
ins1  del1*: a X c d
del1* ins1 : a X c d
del1  ins1*: a X c d
ins1* del2 : a X b d
ins1  del2*: a X b d
del2* ins1 : a X b d
del2  ins1*: a X b d
ins1* del3 : a X b c
ins1  del3*: a X b c
del3* ins1 : a X b c
del3  ins1*: a X b c
ins2* del0 : b X c d
ins2  del0*: b X c d
del0* ins2 : b X c d
del0  ins2*: b X c d
ins2* del1 : a X c d
ins2  del1*: a X c d
del1* ins2 : a X c d
del1  ins2*: a X c d
ins2* del2 : a b X d
ins2  del2*: a b X d
del2* ins2 : a b X d
del2  ins2*: a b X d
ins2* del3 : a b X c
ins2  del3*: a b X c
del3* ins2 : a b X c
del3  ins2*: a b X c
ins3* del0 : b c X d
ins3  del0*: b c X d
del0* ins3 : b c X d
del0  ins3*: b c X d
ins3* del1 : a c X d
ins3  del1*: a c X d
del1* ins3 : a c X d
del1  ins3*: a c X d
ins3* del2 : a b X d
ins3  del2*: a b X d
del2* ins3 : a b X d
del2  ins3*: a b X d
ins3* del3 : a b c X
ins3  del3*: a b c X
del3* ins3 : a b c X
del3  ins3*: a b c X
ins4* del0 : b c d X
ins4  del0*: b c d X
del0* ins4 : b c d X
del0  ins4*: b c d X
ins4* del1 : a c d X
ins4  del1*: a c d X
del1* ins4 : a c d X
del1  ins4*: a c d X
ins4* del2 : a b d X
ins4  del2*: a b d X
del2* ins4 : a b d X
del2  ins4*: a b d X
ins4* del3 : a b c X
ins4  del3*: a b c X
del3* ins4 : a b c X
del3  ins4*: a b c X''';

const expectedTestTransformSetDeleteIndex = '''
set0* del0 : b c d
set0  del0*: b c d
del0* set0 : b c d
del0  set0*: b c d
set0* del1 : X c d
set0  del1*: X c d
del1* set0 : X c d
del1  set0*: X c d
set0* del2 : X b d
set0  del2*: X b d
del2* set0 : X b d
del2  set0*: X b d
set0* del3 : X b c
set0  del3*: X b c
del3* set0 : X b c
del3  set0*: X b c
set1* del0 : X c d
set1  del0*: X c d
del0* set1 : X c d
del0  set1*: X c d
set1* del1 : a c d
set1  del1*: a c d
del1* set1 : a c d
del1  set1*: a c d
set1* del2 : a X d
set1  del2*: a X d
del2* set1 : a X d
del2  set1*: a X d
set1* del3 : a X c
set1  del3*: a X c
del3* set1 : a X c
del3  set1*: a X c
set2* del0 : b X d
set2  del0*: b X d
del0* set2 : b X d
del0  set2*: b X d
set2* del1 : a X d
set2  del1*: a X d
del1* set2 : a X d
del1  set2*: a X d
set2* del2 : a b d
set2  del2*: a b d
del2* set2 : a b d
del2  set2*: a b d
set2* del3 : a b X
set2  del3*: a b X
del3* set2 : a b X
del3  set2*: a b X
set3* del0 : b c X
set3  del0*: b c X
del0* set3 : b c X
del0  set3*: b c X
set3* del1 : a c X
set3  del1*: a c X
del1* set3 : a c X
del1  set3*: a c X
set3* del2 : a b X
set3  del2*: a b X
del2* set3 : a b X
del2  set3*: a b X
set3* del3 : a b c
set3  del3*: a b c
del3* set3 : a b c
del3  set3*: a b c''';

const expectedTestTransformSetInsert = '''
set0* ins0 : Y X b c d
set0  ins0*: Y X b c d
ins0* set0 : Y X b c d
ins0  set0*: Y X b c d
set0* ins1 : X Y b c d
set0  ins1*: X Y b c d
ins1* set0 : X Y b c d
ins1  set0*: X Y b c d
set0* ins2 : X b Y c d
set0  ins2*: X b Y c d
ins2* set0 : X b Y c d
ins2  set0*: X b Y c d
set0* ins3 : X b c Y d
set0  ins3*: X b c Y d
ins3* set0 : X b c Y d
ins3  set0*: X b c Y d
set0* ins4 : X b c d Y
set0  ins4*: X b c d Y
ins4* set0 : X b c d Y
ins4  set0*: X b c d Y
set1* ins0 : Y a X c d
set1  ins0*: Y a X c d
ins0* set1 : Y a X c d
ins0  set1*: Y a X c d
set1* ins1 : a Y X c d
set1  ins1*: a Y X c d
ins1* set1 : a Y X c d
ins1  set1*: a Y X c d
set1* ins2 : a X Y c d
set1  ins2*: a X Y c d
ins2* set1 : a X Y c d
ins2  set1*: a X Y c d
set1* ins3 : a X c Y d
set1  ins3*: a X c Y d
ins3* set1 : a X c Y d
ins3  set1*: a X c Y d
set1* ins4 : a X c d Y
set1  ins4*: a X c d Y
ins4* set1 : a X c d Y
ins4  set1*: a X c d Y
set2* ins0 : Y a b X d
set2  ins0*: Y a b X d
ins0* set2 : Y a b X d
ins0  set2*: Y a b X d
set2* ins1 : a Y b X d
set2  ins1*: a Y b X d
ins1* set2 : a Y b X d
ins1  set2*: a Y b X d
set2* ins2 : a b Y X d
set2  ins2*: a b Y X d
ins2* set2 : a b Y X d
ins2  set2*: a b Y X d
set2* ins3 : a b X Y d
set2  ins3*: a b X Y d
ins3* set2 : a b X Y d
ins3  set2*: a b X Y d
set2* ins4 : a b X d Y
set2  ins4*: a b X d Y
ins4* set2 : a b X d Y
ins4  set2*: a b X d Y
set3* ins0 : Y a b c X
set3  ins0*: Y a b c X
ins0* set3 : Y a b c X
ins0  set3*: Y a b c X
set3* ins1 : a Y b c X
set3  ins1*: a Y b c X
ins1* set3 : a Y b c X
ins1  set3*: a Y b c X
set3* ins2 : a b Y c X
set3  ins2*: a b Y c X
ins2* set3 : a b Y c X
ins2  set3*: a b Y c X
set3* ins3 : a b c Y X
set3  ins3*: a b c Y X
ins3* set3 : a b c Y X
ins3  set3*: a b c Y X
set3* ins4 : a b c X Y
set3  ins4*: a b c X Y
ins4* set3 : a b c X Y
ins4  set3*: a b c X Y''';

const expectedTestTransformEditInsert = '''
edit0* ins0 : Y X b c d
edit0  ins0*: Y X b c d
ins0* edit0 : Y X b c d
ins0  edit0*: Y X b c d
edit0* ins1 : X Y b c d
edit0  ins1*: X Y b c d
ins1* edit0 : X Y b c d
ins1  edit0*: X Y b c d
edit0* ins2 : X b Y c d
edit0  ins2*: X b Y c d
ins2* edit0 : X b Y c d
ins2  edit0*: X b Y c d
edit0* ins3 : X b c Y d
edit0  ins3*: X b c Y d
ins3* edit0 : X b c Y d
ins3  edit0*: X b c Y d
edit0* ins4 : X b c d Y
edit0  ins4*: X b c d Y
ins4* edit0 : X b c d Y
ins4  edit0*: X b c d Y
edit1* ins0 : Y a X c d
edit1  ins0*: Y a X c d
ins0* edit1 : Y a X c d
ins0  edit1*: Y a X c d
edit1* ins1 : a Y X c d
edit1  ins1*: a Y X c d
ins1* edit1 : a Y X c d
ins1  edit1*: a Y X c d
edit1* ins2 : a X Y c d
edit1  ins2*: a X Y c d
ins2* edit1 : a X Y c d
ins2  edit1*: a X Y c d
edit1* ins3 : a X c Y d
edit1  ins3*: a X c Y d
ins3* edit1 : a X c Y d
ins3  edit1*: a X c Y d
edit1* ins4 : a X c d Y
edit1  ins4*: a X c d Y
ins4* edit1 : a X c d Y
ins4  edit1*: a X c d Y
edit2* ins0 : Y a b X d
edit2  ins0*: Y a b X d
ins0* edit2 : Y a b X d
ins0  edit2*: Y a b X d
edit2* ins1 : a Y b X d
edit2  ins1*: a Y b X d
ins1* edit2 : a Y b X d
ins1  edit2*: a Y b X d
edit2* ins2 : a b Y X d
edit2  ins2*: a b Y X d
ins2* edit2 : a b Y X d
ins2  edit2*: a b Y X d
edit2* ins3 : a b X Y d
edit2  ins3*: a b X Y d
ins3* edit2 : a b X Y d
ins3  edit2*: a b X Y d
edit2* ins4 : a b X d Y
edit2  ins4*: a b X d Y
ins4* edit2 : a b X d Y
ins4  edit2*: a b X d Y
edit3* ins0 : Y a b c X
edit3  ins0*: Y a b c X
ins0* edit3 : Y a b c X
ins0  edit3*: Y a b c X
edit3* ins1 : a Y b c X
edit3  ins1*: a Y b c X
ins1* edit3 : a Y b c X
ins1  edit3*: a Y b c X
edit3* ins2 : a b Y c X
edit3  ins2*: a b Y c X
ins2* edit3 : a b Y c X
ins2  edit3*: a b Y c X
edit3* ins3 : a b c Y X
edit3  ins3*: a b c Y X
ins3* edit3 : a b c Y X
ins3  edit3*: a b c Y X
edit3* ins4 : a b c X Y
edit3  ins4*: a b c X Y
ins4* edit3 : a b c X Y
ins4  edit3*: a b c X Y''';

const expectedTestTransformSetSetIndex = '''
set0* set0 : X b c d
set0  set0*: Y b c d
set0* set1 : X Y c d
set0  set1*: X Y c d
set0* set2 : X b Y d
set0  set2*: X b Y d
set0* set3 : X b c Y
set0  set3*: X b c Y
set1* set0 : Y X c d
set1  set0*: Y X c d
set1* set1 : a X c d
set1  set1*: a Y c d
set1* set2 : a X Y d
set1  set2*: a X Y d
set1* set3 : a X c Y
set1  set3*: a X c Y
set2* set0 : Y b X d
set2  set0*: Y b X d
set2* set1 : a Y X d
set2  set1*: a Y X d
set2* set2 : a b X d
set2  set2*: a b Y d
set2* set3 : a b X Y
set2  set3*: a b X Y
set3* set0 : Y b c X
set3  set0*: Y b c X
set3* set1 : a Y c X
set3  set1*: a Y c X
set3* set2 : a b Y X
set3  set2*: a b Y X
set3* set3 : a b c X
set3  set3*: a b c Y''';

const expectedTestTransformEditDeleteIndex = '''
edit0* del0 : b c d
edit0  del0*: b c d
del0* edit0 : b c d
del0  edit0*: b c d
edit0* del1 : X c d
edit0  del1*: X c d
del1* edit0 : X c d
del1  edit0*: X c d
edit0* del2 : X b d
edit0  del2*: X b d
del2* edit0 : X b d
del2  edit0*: X b d
edit0* del3 : X b c
edit0  del3*: X b c
del3* edit0 : X b c
del3  edit0*: X b c
edit1* del0 : X c d
edit1  del0*: X c d
del0* edit1 : X c d
del0  edit1*: X c d
edit1* del1 : a c d
edit1  del1*: a c d
del1* edit1 : a c d
del1  edit1*: a c d
edit1* del2 : a X d
edit1  del2*: a X d
del2* edit1 : a X d
del2  edit1*: a X d
edit1* del3 : a X c
edit1  del3*: a X c
del3* edit1 : a X c
del3  edit1*: a X c
edit2* del0 : b X d
edit2  del0*: b X d
del0* edit2 : b X d
del0  edit2*: b X d
edit2* del1 : a X d
edit2  del1*: a X d
del1* edit2 : a X d
del1  edit2*: a X d
edit2* del2 : a b d
edit2  del2*: a b d
del2* edit2 : a b d
del2  edit2*: a b d
edit2* del3 : a b X
edit2  del3*: a b X
del3* edit2 : a b X
del3  edit2*: a b X
edit3* del0 : b c X
edit3  del0*: b c X
del0* edit3 : b c X
del0  edit3*: b c X
edit3* del1 : a c X
edit3  del1*: a c X
del1* edit3 : a c X
del1  edit3*: a c X
edit3* del2 : a b X
edit3  del2*: a b X
del2* edit3 : a b X
del2  edit3*: a b X
edit3* del3 : a b c
edit3  del3*: a b c
del3* edit3 : a b c
del3  edit3*: a b c''';

const expectedTestTransformEditEditIndex = '''
edit0* edit0 : XY b c d
edit0  edit0*: YX b c d
edit0* edit1 : X Y c d
edit0  edit1*: X Y c d
edit0* edit2 : X b Y d
edit0  edit2*: X b Y d
edit0* edit3 : X b c Y
edit0  edit3*: X b c Y
edit1* edit0 : Y X c d
edit1  edit0*: Y X c d
edit1* edit1 : a XY c d
edit1  edit1*: a YX c d
edit1* edit2 : a X Y d
edit1  edit2*: a X Y d
edit1* edit3 : a X c Y
edit1  edit3*: a X c Y
edit2* edit0 : Y b X d
edit2  edit0*: Y b X d
edit2* edit1 : a Y X d
edit2  edit1*: a Y X d
edit2* edit2 : a b XY d
edit2  edit2*: a b YX d
edit2* edit3 : a b X Y
edit2  edit3*: a b X Y
edit3* edit0 : Y b c X
edit3  edit0*: Y b c X
edit3* edit1 : a Y c X
edit3  edit1*: a Y c X
edit3* edit2 : a b Y X
edit3  edit2*: a b Y X
edit3* edit3 : a b c XY
edit3  edit3*: a b c YX''';

const expectedTestTransformEditSetIndex = '''
edit0* set0 : Y b c d
edit0  set0*: Y b c d
set0* edit0 : Y b c d
set0  edit0*: Y b c d
edit0* set1 : X Y c d
edit0  set1*: X Y c d
set1* edit0 : X Y c d
set1  edit0*: X Y c d
edit0* set2 : X b Y d
edit0  set2*: X b Y d
set2* edit0 : X b Y d
set2  edit0*: X b Y d
edit0* set3 : X b c Y
edit0  set3*: X b c Y
set3* edit0 : X b c Y
set3  edit0*: X b c Y
edit1* set0 : Y X c d
edit1  set0*: Y X c d
set0* edit1 : Y X c d
set0  edit1*: Y X c d
edit1* set1 : a Y c d
edit1  set1*: a Y c d
set1* edit1 : a Y c d
set1  edit1*: a Y c d
edit1* set2 : a X Y d
edit1  set2*: a X Y d
set2* edit1 : a X Y d
set2  edit1*: a X Y d
edit1* set3 : a X c Y
edit1  set3*: a X c Y
set3* edit1 : a X c Y
set3  edit1*: a X c Y
edit2* set0 : Y b X d
edit2  set0*: Y b X d
set0* edit2 : Y b X d
set0  edit2*: Y b X d
edit2* set1 : a Y X d
edit2  set1*: a Y X d
set1* edit2 : a Y X d
set1  edit2*: a Y X d
edit2* set2 : a b Y d
edit2  set2*: a b Y d
set2* edit2 : a b Y d
set2  edit2*: a b Y d
edit2* set3 : a b X Y
edit2  set3*: a b X Y
set3* edit2 : a b X Y
set3  edit2*: a b X Y
edit3* set0 : Y b c X
edit3  set0*: Y b c X
set0* edit3 : Y b c X
set0  edit3*: Y b c X
edit3* set1 : a Y c X
edit3  set1*: a Y c X
set1* edit3 : a Y c X
set1  edit3*: a Y c X
edit3* set2 : a b Y X
edit3  set2*: a b Y X
set2* edit3 : a b Y X
set2  edit3*: a b Y X
edit3* set3 : a b c Y
edit3  set3*: a b c Y
set3* edit3 : a b c Y
set3  edit3*: a b c Y''';

const expectedTestTransformMoveMove = '''
0->0* 0->0 : a b c d e f g
0->0  0->0*: a b c d e f g
0->0* 0->1 : a b c d e f g
0->0  0->1*: a b c d e f g
0->0* 0->2 : b a c d e f g
0->0  0->2*: b a c d e f g
0->0* 0->3 : b c a d e f g
0->0  0->3*: b c a d e f g
0->0* 0->4 : b c d a e f g
0->0  0->4*: b c d a e f g
0->0* 0->5 : b c d e a f g
0->0  0->5*: b c d e a f g
0->0* 0->6 : b c d e f a g
0->0  0->6*: b c d e f a g
0->0* 0->7 : b c d e f g a
0->0  0->7*: b c d e f g a
0->0* 1->0 : b a c d e f g
0->0  1->0*: b a c d e f g
0->0* 1->1 : a b c d e f g
0->0  1->1*: a b c d e f g
0->0* 1->2 : a b c d e f g
0->0  1->2*: a b c d e f g
0->0* 1->3 : a c b d e f g
0->0  1->3*: a c b d e f g
0->0* 1->4 : a c d b e f g
0->0  1->4*: a c d b e f g
0->0* 1->5 : a c d e b f g
0->0  1->5*: a c d e b f g
0->0* 1->6 : a c d e f b g
0->0  1->6*: a c d e f b g
0->0* 1->7 : a c d e f g b
0->0  1->7*: a c d e f g b
0->0* 2->0 : c a b d e f g
0->0  2->0*: c a b d e f g
0->0* 2->1 : a c b d e f g
0->0  2->1*: a c b d e f g
0->0* 2->2 : a b c d e f g
0->0  2->2*: a b c d e f g
0->0* 2->3 : a b c d e f g
0->0  2->3*: a b c d e f g
0->0* 2->4 : a b d c e f g
0->0  2->4*: a b d c e f g
0->0* 2->5 : a b d e c f g
0->0  2->5*: a b d e c f g
0->0* 2->6 : a b d e f c g
0->0  2->6*: a b d e f c g
0->0* 2->7 : a b d e f g c
0->0  2->7*: a b d e f g c
0->0* 3->0 : d a b c e f g
0->0  3->0*: d a b c e f g
0->0* 3->1 : a d b c e f g
0->0  3->1*: a d b c e f g
0->0* 3->2 : a b d c e f g
0->0  3->2*: a b d c e f g
0->0* 3->3 : a b c d e f g
0->0  3->3*: a b c d e f g
0->0* 3->4 : a b c d e f g
0->0  3->4*: a b c d e f g
0->0* 3->5 : a b c e d f g
0->0  3->5*: a b c e d f g
0->0* 3->6 : a b c e f d g
0->0  3->6*: a b c e f d g
0->0* 3->7 : a b c e f g d
0->0  3->7*: a b c e f g d
0->0* 4->0 : e a b c d f g
0->0  4->0*: e a b c d f g
0->0* 4->1 : a e b c d f g
0->0  4->1*: a e b c d f g
0->0* 4->2 : a b e c d f g
0->0  4->2*: a b e c d f g
0->0* 4->3 : a b c e d f g
0->0  4->3*: a b c e d f g
0->0* 4->4 : a b c d e f g
0->0  4->4*: a b c d e f g
0->0* 4->5 : a b c d e f g
0->0  4->5*: a b c d e f g
0->0* 4->6 : a b c d f e g
0->0  4->6*: a b c d f e g
0->0* 4->7 : a b c d f g e
0->0  4->7*: a b c d f g e
0->0* 5->0 : f a b c d e g
0->0  5->0*: f a b c d e g
0->0* 5->1 : a f b c d e g
0->0  5->1*: a f b c d e g
0->0* 5->2 : a b f c d e g
0->0  5->2*: a b f c d e g
0->0* 5->3 : a b c f d e g
0->0  5->3*: a b c f d e g
0->0* 5->4 : a b c d f e g
0->0  5->4*: a b c d f e g
0->0* 5->5 : a b c d e f g
0->0  5->5*: a b c d e f g
0->0* 5->6 : a b c d e f g
0->0  5->6*: a b c d e f g
0->0* 5->7 : a b c d e g f
0->0  5->7*: a b c d e g f
0->0* 6->0 : g a b c d e f
0->0  6->0*: g a b c d e f
0->0* 6->1 : a g b c d e f
0->0  6->1*: a g b c d e f
0->0* 6->2 : a b g c d e f
0->0  6->2*: a b g c d e f
0->0* 6->3 : a b c g d e f
0->0  6->3*: a b c g d e f
0->0* 6->4 : a b c d g e f
0->0  6->4*: a b c d g e f
0->0* 6->5 : a b c d e g f
0->0  6->5*: a b c d e g f
0->0* 6->6 : a b c d e f g
0->0  6->6*: a b c d e f g
0->0* 6->7 : a b c d e f g
0->0  6->7*: a b c d e f g
0->1* 0->0 : a b c d e f g
0->1  0->0*: a b c d e f g
0->1* 0->1 : a b c d e f g
0->1  0->1*: a b c d e f g
0->1* 0->2 : b a c d e f g
0->1  0->2*: b a c d e f g
0->1* 0->3 : b c a d e f g
0->1  0->3*: b c a d e f g
0->1* 0->4 : b c d a e f g
0->1  0->4*: b c d a e f g
0->1* 0->5 : b c d e a f g
0->1  0->5*: b c d e a f g
0->1* 0->6 : b c d e f a g
0->1  0->6*: b c d e f a g
0->1* 0->7 : b c d e f g a
0->1  0->7*: b c d e f g a
0->1* 1->0 : b a c d e f g
0->1  1->0*: b a c d e f g
0->1* 1->1 : a b c d e f g
0->1  1->1*: a b c d e f g
0->1* 1->2 : a b c d e f g
0->1  1->2*: a b c d e f g
0->1* 1->3 : a c b d e f g
0->1  1->3*: a c b d e f g
0->1* 1->4 : a c d b e f g
0->1  1->4*: a c d b e f g
0->1* 1->5 : a c d e b f g
0->1  1->5*: a c d e b f g
0->1* 1->6 : a c d e f b g
0->1  1->6*: a c d e f b g
0->1* 1->7 : a c d e f g b
0->1  1->7*: a c d e f g b
0->1* 2->0 : c a b d e f g
0->1  2->0*: c a b d e f g
0->1* 2->1 : a c b d e f g
0->1  2->1*: a c b d e f g
0->1* 2->2 : a b c d e f g
0->1  2->2*: a b c d e f g
0->1* 2->3 : a b c d e f g
0->1  2->3*: a b c d e f g
0->1* 2->4 : a b d c e f g
0->1  2->4*: a b d c e f g
0->1* 2->5 : a b d e c f g
0->1  2->5*: a b d e c f g
0->1* 2->6 : a b d e f c g
0->1  2->6*: a b d e f c g
0->1* 2->7 : a b d e f g c
0->1  2->7*: a b d e f g c
0->1* 3->0 : d a b c e f g
0->1  3->0*: d a b c e f g
0->1* 3->1 : a d b c e f g
0->1  3->1*: a d b c e f g
0->1* 3->2 : a b d c e f g
0->1  3->2*: a b d c e f g
0->1* 3->3 : a b c d e f g
0->1  3->3*: a b c d e f g
0->1* 3->4 : a b c d e f g
0->1  3->4*: a b c d e f g
0->1* 3->5 : a b c e d f g
0->1  3->5*: a b c e d f g
0->1* 3->6 : a b c e f d g
0->1  3->6*: a b c e f d g
0->1* 3->7 : a b c e f g d
0->1  3->7*: a b c e f g d
0->1* 4->0 : e a b c d f g
0->1  4->0*: e a b c d f g
0->1* 4->1 : a e b c d f g
0->1  4->1*: a e b c d f g
0->1* 4->2 : a b e c d f g
0->1  4->2*: a b e c d f g
0->1* 4->3 : a b c e d f g
0->1  4->3*: a b c e d f g
0->1* 4->4 : a b c d e f g
0->1  4->4*: a b c d e f g
0->1* 4->5 : a b c d e f g
0->1  4->5*: a b c d e f g
0->1* 4->6 : a b c d f e g
0->1  4->6*: a b c d f e g
0->1* 4->7 : a b c d f g e
0->1  4->7*: a b c d f g e
0->1* 5->0 : f a b c d e g
0->1  5->0*: f a b c d e g
0->1* 5->1 : a f b c d e g
0->1  5->1*: a f b c d e g
0->1* 5->2 : a b f c d e g
0->1  5->2*: a b f c d e g
0->1* 5->3 : a b c f d e g
0->1  5->3*: a b c f d e g
0->1* 5->4 : a b c d f e g
0->1  5->4*: a b c d f e g
0->1* 5->5 : a b c d e f g
0->1  5->5*: a b c d e f g
0->1* 5->6 : a b c d e f g
0->1  5->6*: a b c d e f g
0->1* 5->7 : a b c d e g f
0->1  5->7*: a b c d e g f
0->1* 6->0 : g a b c d e f
0->1  6->0*: g a b c d e f
0->1* 6->1 : a g b c d e f
0->1  6->1*: a g b c d e f
0->1* 6->2 : a b g c d e f
0->1  6->2*: a b g c d e f
0->1* 6->3 : a b c g d e f
0->1  6->3*: a b c g d e f
0->1* 6->4 : a b c d g e f
0->1  6->4*: a b c d g e f
0->1* 6->5 : a b c d e g f
0->1  6->5*: a b c d e g f
0->1* 6->6 : a b c d e f g
0->1  6->6*: a b c d e f g
0->1* 6->7 : a b c d e f g
0->1  6->7*: a b c d e f g
0->2* 0->0 : b a c d e f g
0->2  0->0*: b a c d e f g
0->2* 0->1 : b a c d e f g
0->2  0->1*: b a c d e f g
0->2* 0->2 : b a c d e f g
0->2  0->2*: b a c d e f g
0->2* 0->3 : b a c d e f g
0->2  0->3*: b c a d e f g
0->2* 0->4 : b a c d e f g
0->2  0->4*: b c d a e f g
0->2* 0->5 : b a c d e f g
0->2  0->5*: b c d e a f g
0->2* 0->6 : b a c d e f g
0->2  0->6*: b c d e f a g
0->2* 0->7 : b a c d e f g
0->2  0->7*: b c d e f g a
0->2* 1->0 : b a c d e f g
0->2  1->0*: b a c d e f g
0->2* 1->1 : b a c d e f g
0->2  1->1*: b a c d e f g
0->2* 1->2 : b a c d e f g
0->2  1->2*: b a c d e f g
0->2* 1->3 : a c b d e f g
0->2  1->3*: a c b d e f g
0->2* 1->4 : a c d b e f g
0->2  1->4*: a c d b e f g
0->2* 1->5 : a c d e b f g
0->2  1->5*: a c d e b f g
0->2* 1->6 : a c d e f b g
0->2  1->6*: a c d e f b g
0->2* 1->7 : a c d e f g b
0->2  1->7*: a c d e f g b
0->2* 2->0 : c b a d e f g
0->2  2->0*: c b a d e f g
0->2* 2->1 : c b a d e f g
0->2  2->1*: c b a d e f g
0->2* 2->2 : b a c d e f g
0->2  2->2*: b a c d e f g
0->2* 2->3 : b a c d e f g
0->2  2->3*: b a c d e f g
0->2* 2->4 : b a d c e f g
0->2  2->4*: b a d c e f g
0->2* 2->5 : b a d e c f g
0->2  2->5*: b a d e c f g
0->2* 2->6 : b a d e f c g
0->2  2->6*: b a d e f c g
0->2* 2->7 : b a d e f g c
0->2  2->7*: b a d e f g c
0->2* 3->0 : d b a c e f g
0->2  3->0*: d b a c e f g
0->2* 3->1 : d b a c e f g
0->2  3->1*: d b a c e f g
0->2* 3->2 : b a d c e f g
0->2  3->2*: b d a c e f g
0->2* 3->3 : b a c d e f g
0->2  3->3*: b a c d e f g
0->2* 3->4 : b a c d e f g
0->2  3->4*: b a c d e f g
0->2* 3->5 : b a c e d f g
0->2  3->5*: b a c e d f g
0->2* 3->6 : b a c e f d g
0->2  3->6*: b a c e f d g
0->2* 3->7 : b a c e f g d
0->2  3->7*: b a c e f g d
0->2* 4->0 : e b a c d f g
0->2  4->0*: e b a c d f g
0->2* 4->1 : e b a c d f g
0->2  4->1*: e b a c d f g
0->2* 4->2 : b a e c d f g
0->2  4->2*: b e a c d f g
0->2* 4->3 : b a c e d f g
0->2  4->3*: b a c e d f g
0->2* 4->4 : b a c d e f g
0->2  4->4*: b a c d e f g
0->2* 4->5 : b a c d e f g
0->2  4->5*: b a c d e f g
0->2* 4->6 : b a c d f e g
0->2  4->6*: b a c d f e g
0->2* 4->7 : b a c d f g e
0->2  4->7*: b a c d f g e
0->2* 5->0 : f b a c d e g
0->2  5->0*: f b a c d e g
0->2* 5->1 : f b a c d e g
0->2  5->1*: f b a c d e g
0->2* 5->2 : b a f c d e g
0->2  5->2*: b f a c d e g
0->2* 5->3 : b a c f d e g
0->2  5->3*: b a c f d e g
0->2* 5->4 : b a c d f e g
0->2  5->4*: b a c d f e g
0->2* 5->5 : b a c d e f g
0->2  5->5*: b a c d e f g
0->2* 5->6 : b a c d e f g
0->2  5->6*: b a c d e f g
0->2* 5->7 : b a c d e g f
0->2  5->7*: b a c d e g f
0->2* 6->0 : g b a c d e f
0->2  6->0*: g b a c d e f
0->2* 6->1 : g b a c d e f
0->2  6->1*: g b a c d e f
0->2* 6->2 : b a g c d e f
0->2  6->2*: b g a c d e f
0->2* 6->3 : b a c g d e f
0->2  6->3*: b a c g d e f
0->2* 6->4 : b a c d g e f
0->2  6->4*: b a c d g e f
0->2* 6->5 : b a c d e g f
0->2  6->5*: b a c d e g f
0->2* 6->6 : b a c d e f g
0->2  6->6*: b a c d e f g
0->2* 6->7 : b a c d e f g
0->2  6->7*: b a c d e f g
0->3* 0->0 : b c a d e f g
0->3  0->0*: b c a d e f g
0->3* 0->1 : b c a d e f g
0->3  0->1*: b c a d e f g
0->3* 0->2 : b c a d e f g
0->3  0->2*: b a c d e f g
0->3* 0->3 : b c a d e f g
0->3  0->3*: b c a d e f g
0->3* 0->4 : b c a d e f g
0->3  0->4*: b c d a e f g
0->3* 0->5 : b c a d e f g
0->3  0->5*: b c d e a f g
0->3* 0->6 : b c a d e f g
0->3  0->6*: b c d e f a g
0->3* 0->7 : b c a d e f g
0->3  0->7*: b c d e f g a
0->3* 1->0 : b c a d e f g
0->3  1->0*: b c a d e f g
0->3* 1->1 : b c a d e f g
0->3  1->1*: b c a d e f g
0->3* 1->2 : b c a d e f g
0->3  1->2*: b c a d e f g
0->3* 1->3 : c a b d e f g
0->3  1->3*: c b a d e f g
0->3* 1->4 : c a d b e f g
0->3  1->4*: c a d b e f g
0->3* 1->5 : c a d e b f g
0->3  1->5*: c a d e b f g
0->3* 1->6 : c a d e f b g
0->3  1->6*: c a d e f b g
0->3* 1->7 : c a d e f g b
0->3  1->7*: c a d e f g b
0->3* 2->0 : c b a d e f g
0->3  2->0*: c b a d e f g
0->3* 2->1 : c b a d e f g
0->3  2->1*: c b a d e f g
0->3* 2->2 : b c a d e f g
0->3  2->2*: b c a d e f g
0->3* 2->3 : b c a d e f g
0->3  2->3*: b c a d e f g
0->3* 2->4 : b a d c e f g
0->3  2->4*: b a d c e f g
0->3* 2->5 : b a d e c f g
0->3  2->5*: b a d e c f g
0->3* 2->6 : b a d e f c g
0->3  2->6*: b a d e f c g
0->3* 2->7 : b a d e f g c
0->3  2->7*: b a d e f g c
0->3* 3->0 : d b c a e f g
0->3  3->0*: d b c a e f g
0->3* 3->1 : d b c a e f g
0->3  3->1*: d b c a e f g
0->3* 3->2 : b d c a e f g
0->3  3->2*: b d c a e f g
0->3* 3->3 : b c a d e f g
0->3  3->3*: b c a d e f g
0->3* 3->4 : b c a d e f g
0->3  3->4*: b c a d e f g
0->3* 3->5 : b c a e d f g
0->3  3->5*: b c a e d f g
0->3* 3->6 : b c a e f d g
0->3  3->6*: b c a e f d g
0->3* 3->7 : b c a e f g d
0->3  3->7*: b c a e f g d
0->3* 4->0 : e b c a d f g
0->3  4->0*: e b c a d f g
0->3* 4->1 : e b c a d f g
0->3  4->1*: e b c a d f g
0->3* 4->2 : b e c a d f g
0->3  4->2*: b e c a d f g
0->3* 4->3 : b c a e d f g
0->3  4->3*: b c e a d f g
0->3* 4->4 : b c a d e f g
0->3  4->4*: b c a d e f g
0->3* 4->5 : b c a d e f g
0->3  4->5*: b c a d e f g
0->3* 4->6 : b c a d f e g
0->3  4->6*: b c a d f e g
0->3* 4->7 : b c a d f g e
0->3  4->7*: b c a d f g e
0->3* 5->0 : f b c a d e g
0->3  5->0*: f b c a d e g
0->3* 5->1 : f b c a d e g
0->3  5->1*: f b c a d e g
0->3* 5->2 : b f c a d e g
0->3  5->2*: b f c a d e g
0->3* 5->3 : b c a f d e g
0->3  5->3*: b c f a d e g
0->3* 5->4 : b c a d f e g
0->3  5->4*: b c a d f e g
0->3* 5->5 : b c a d e f g
0->3  5->5*: b c a d e f g
0->3* 5->6 : b c a d e f g
0->3  5->6*: b c a d e f g
0->3* 5->7 : b c a d e g f
0->3  5->7*: b c a d e g f
0->3* 6->0 : g b c a d e f
0->3  6->0*: g b c a d e f
0->3* 6->1 : g b c a d e f
0->3  6->1*: g b c a d e f
0->3* 6->2 : b g c a d e f
0->3  6->2*: b g c a d e f
0->3* 6->3 : b c a g d e f
0->3  6->3*: b c g a d e f
0->3* 6->4 : b c a d g e f
0->3  6->4*: b c a d g e f
0->3* 6->5 : b c a d e g f
0->3  6->5*: b c a d e g f
0->3* 6->6 : b c a d e f g
0->3  6->6*: b c a d e f g
0->3* 6->7 : b c a d e f g
0->3  6->7*: b c a d e f g
0->4* 0->0 : b c d a e f g
0->4  0->0*: b c d a e f g
0->4* 0->1 : b c d a e f g
0->4  0->1*: b c d a e f g
0->4* 0->2 : b c d a e f g
0->4  0->2*: b a c d e f g
0->4* 0->3 : b c d a e f g
0->4  0->3*: b c a d e f g
0->4* 0->4 : b c d a e f g
0->4  0->4*: b c d a e f g
0->4* 0->5 : b c d a e f g
0->4  0->5*: b c d e a f g
0->4* 0->6 : b c d a e f g
0->4  0->6*: b c d e f a g
0->4* 0->7 : b c d a e f g
0->4  0->7*: b c d e f g a
0->4* 1->0 : b c d a e f g
0->4  1->0*: b c d a e f g
0->4* 1->1 : b c d a e f g
0->4  1->1*: b c d a e f g
0->4* 1->2 : b c d a e f g
0->4  1->2*: b c d a e f g
0->4* 1->3 : c b d a e f g
0->4  1->3*: c b d a e f g
0->4* 1->4 : c d a b e f g
0->4  1->4*: c d b a e f g
0->4* 1->5 : c d a e b f g
0->4  1->5*: c d a e b f g
0->4* 1->6 : c d a e f b g
0->4  1->6*: c d a e f b g
0->4* 1->7 : c d a e f g b
0->4  1->7*: c d a e f g b
0->4* 2->0 : c b d a e f g
0->4  2->0*: c b d a e f g
0->4* 2->1 : c b d a e f g
0->4  2->1*: c b d a e f g
0->4* 2->2 : b c d a e f g
0->4  2->2*: b c d a e f g
0->4* 2->3 : b c d a e f g
0->4  2->3*: b c d a e f g
0->4* 2->4 : b d a c e f g
0->4  2->4*: b d c a e f g
0->4* 2->5 : b d a e c f g
0->4  2->5*: b d a e c f g
0->4* 2->6 : b d a e f c g
0->4  2->6*: b d a e f c g
0->4* 2->7 : b d a e f g c
0->4  2->7*: b d a e f g c
0->4* 3->0 : d b c a e f g
0->4  3->0*: d b c a e f g
0->4* 3->1 : d b c a e f g
0->4  3->1*: d b c a e f g
0->4* 3->2 : b d c a e f g
0->4  3->2*: b d c a e f g
0->4* 3->3 : b c d a e f g
0->4  3->3*: b c d a e f g
0->4* 3->4 : b c d a e f g
0->4  3->4*: b c d a e f g
0->4* 3->5 : b c a e d f g
0->4  3->5*: b c a e d f g
0->4* 3->6 : b c a e f d g
0->4  3->6*: b c a e f d g
0->4* 3->7 : b c a e f g d
0->4  3->7*: b c a e f g d
0->4* 4->0 : e b c d a f g
0->4  4->0*: e b c d a f g
0->4* 4->1 : e b c d a f g
0->4  4->1*: e b c d a f g
0->4* 4->2 : b e c d a f g
0->4  4->2*: b e c d a f g
0->4* 4->3 : b c e d a f g
0->4  4->3*: b c e d a f g
0->4* 4->4 : b c d a e f g
0->4  4->4*: b c d a e f g
0->4* 4->5 : b c d a e f g
0->4  4->5*: b c d a e f g
0->4* 4->6 : b c d a f e g
0->4  4->6*: b c d a f e g
0->4* 4->7 : b c d a f g e
0->4  4->7*: b c d a f g e
0->4* 5->0 : f b c d a e g
0->4  5->0*: f b c d a e g
0->4* 5->1 : f b c d a e g
0->4  5->1*: f b c d a e g
0->4* 5->2 : b f c d a e g
0->4  5->2*: b f c d a e g
0->4* 5->3 : b c f d a e g
0->4  5->3*: b c f d a e g
0->4* 5->4 : b c d a f e g
0->4  5->4*: b c d f a e g
0->4* 5->5 : b c d a e f g
0->4  5->5*: b c d a e f g
0->4* 5->6 : b c d a e f g
0->4  5->6*: b c d a e f g
0->4* 5->7 : b c d a e g f
0->4  5->7*: b c d a e g f
0->4* 6->0 : g b c d a e f
0->4  6->0*: g b c d a e f
0->4* 6->1 : g b c d a e f
0->4  6->1*: g b c d a e f
0->4* 6->2 : b g c d a e f
0->4  6->2*: b g c d a e f
0->4* 6->3 : b c g d a e f
0->4  6->3*: b c g d a e f
0->4* 6->4 : b c d a g e f
0->4  6->4*: b c d g a e f
0->4* 6->5 : b c d a e g f
0->4  6->5*: b c d a e g f
0->4* 6->6 : b c d a e f g
0->4  6->6*: b c d a e f g
0->4* 6->7 : b c d a e f g
0->4  6->7*: b c d a e f g
0->5* 0->0 : b c d e a f g
0->5  0->0*: b c d e a f g
0->5* 0->1 : b c d e a f g
0->5  0->1*: b c d e a f g
0->5* 0->2 : b c d e a f g
0->5  0->2*: b a c d e f g
0->5* 0->3 : b c d e a f g
0->5  0->3*: b c a d e f g
0->5* 0->4 : b c d e a f g
0->5  0->4*: b c d a e f g
0->5* 0->5 : b c d e a f g
0->5  0->5*: b c d e a f g
0->5* 0->6 : b c d e a f g
0->5  0->6*: b c d e f a g
0->5* 0->7 : b c d e a f g
0->5  0->7*: b c d e f g a
0->5* 1->0 : b c d e a f g
0->5  1->0*: b c d e a f g
0->5* 1->1 : b c d e a f g
0->5  1->1*: b c d e a f g
0->5* 1->2 : b c d e a f g
0->5  1->2*: b c d e a f g
0->5* 1->3 : c b d e a f g
0->5  1->3*: c b d e a f g
0->5* 1->4 : c d b e a f g
0->5  1->4*: c d b e a f g
0->5* 1->5 : c d e a b f g
0->5  1->5*: c d e b a f g
0->5* 1->6 : c d e a f b g
0->5  1->6*: c d e a f b g
0->5* 1->7 : c d e a f g b
0->5  1->7*: c d e a f g b
0->5* 2->0 : c b d e a f g
0->5  2->0*: c b d e a f g
0->5* 2->1 : c b d e a f g
0->5  2->1*: c b d e a f g
0->5* 2->2 : b c d e a f g
0->5  2->2*: b c d e a f g
0->5* 2->3 : b c d e a f g
0->5  2->3*: b c d e a f g
0->5* 2->4 : b d c e a f g
0->5  2->4*: b d c e a f g
0->5* 2->5 : b d e a c f g
0->5  2->5*: b d e c a f g
0->5* 2->6 : b d e a f c g
0->5  2->6*: b d e a f c g
0->5* 2->7 : b d e a f g c
0->5  2->7*: b d e a f g c
0->5* 3->0 : d b c e a f g
0->5  3->0*: d b c e a f g
0->5* 3->1 : d b c e a f g
0->5  3->1*: d b c e a f g
0->5* 3->2 : b d c e a f g
0->5  3->2*: b d c e a f g
0->5* 3->3 : b c d e a f g
0->5  3->3*: b c d e a f g
0->5* 3->4 : b c d e a f g
0->5  3->4*: b c d e a f g
0->5* 3->5 : b c e a d f g
0->5  3->5*: b c e d a f g
0->5* 3->6 : b c e a f d g
0->5  3->6*: b c e a f d g
0->5* 3->7 : b c e a f g d
0->5  3->7*: b c e a f g d
0->5* 4->0 : e b c d a f g
0->5  4->0*: e b c d a f g
0->5* 4->1 : e b c d a f g
0->5  4->1*: e b c d a f g
0->5* 4->2 : b e c d a f g
0->5  4->2*: b e c d a f g
0->5* 4->3 : b c e d a f g
0->5  4->3*: b c e d a f g
0->5* 4->4 : b c d e a f g
0->5  4->4*: b c d e a f g
0->5* 4->5 : b c d e a f g
0->5  4->5*: b c d e a f g
0->5* 4->6 : b c d a f e g
0->5  4->6*: b c d a f e g
0->5* 4->7 : b c d a f g e
0->5  4->7*: b c d a f g e
0->5* 5->0 : f b c d e a g
0->5  5->0*: f b c d e a g
0->5* 5->1 : f b c d e a g
0->5  5->1*: f b c d e a g
0->5* 5->2 : b f c d e a g
0->5  5->2*: b f c d e a g
0->5* 5->3 : b c f d e a g
0->5  5->3*: b c f d e a g
0->5* 5->4 : b c d f e a g
0->5  5->4*: b c d f e a g
0->5* 5->5 : b c d e a f g
0->5  5->5*: b c d e a f g
0->5* 5->6 : b c d e a f g
0->5  5->6*: b c d e a f g
0->5* 5->7 : b c d e a g f
0->5  5->7*: b c d e a g f
0->5* 6->0 : g b c d e a f
0->5  6->0*: g b c d e a f
0->5* 6->1 : g b c d e a f
0->5  6->1*: g b c d e a f
0->5* 6->2 : b g c d e a f
0->5  6->2*: b g c d e a f
0->5* 6->3 : b c g d e a f
0->5  6->3*: b c g d e a f
0->5* 6->4 : b c d g e a f
0->5  6->4*: b c d g e a f
0->5* 6->5 : b c d e a g f
0->5  6->5*: b c d e g a f
0->5* 6->6 : b c d e a f g
0->5  6->6*: b c d e a f g
0->5* 6->7 : b c d e a f g
0->5  6->7*: b c d e a f g
0->6* 0->0 : b c d e f a g
0->6  0->0*: b c d e f a g
0->6* 0->1 : b c d e f a g
0->6  0->1*: b c d e f a g
0->6* 0->2 : b c d e f a g
0->6  0->2*: b a c d e f g
0->6* 0->3 : b c d e f a g
0->6  0->3*: b c a d e f g
0->6* 0->4 : b c d e f a g
0->6  0->4*: b c d a e f g
0->6* 0->5 : b c d e f a g
0->6  0->5*: b c d e a f g
0->6* 0->6 : b c d e f a g
0->6  0->6*: b c d e f a g
0->6* 0->7 : b c d e f a g
0->6  0->7*: b c d e f g a
0->6* 1->0 : b c d e f a g
0->6  1->0*: b c d e f a g
0->6* 1->1 : b c d e f a g
0->6  1->1*: b c d e f a g
0->6* 1->2 : b c d e f a g
0->6  1->2*: b c d e f a g
0->6* 1->3 : c b d e f a g
0->6  1->3*: c b d e f a g
0->6* 1->4 : c d b e f a g
0->6  1->4*: c d b e f a g
0->6* 1->5 : c d e b f a g
0->6  1->5*: c d e b f a g
0->6* 1->6 : c d e f a b g
0->6  1->6*: c d e f b a g
0->6* 1->7 : c d e f a g b
0->6  1->7*: c d e f a g b
0->6* 2->0 : c b d e f a g
0->6  2->0*: c b d e f a g
0->6* 2->1 : c b d e f a g
0->6  2->1*: c b d e f a g
0->6* 2->2 : b c d e f a g
0->6  2->2*: b c d e f a g
0->6* 2->3 : b c d e f a g
0->6  2->3*: b c d e f a g
0->6* 2->4 : b d c e f a g
0->6  2->4*: b d c e f a g
0->6* 2->5 : b d e c f a g
0->6  2->5*: b d e c f a g
0->6* 2->6 : b d e f a c g
0->6  2->6*: b d e f c a g
0->6* 2->7 : b d e f a g c
0->6  2->7*: b d e f a g c
0->6* 3->0 : d b c e f a g
0->6  3->0*: d b c e f a g
0->6* 3->1 : d b c e f a g
0->6  3->1*: d b c e f a g
0->6* 3->2 : b d c e f a g
0->6  3->2*: b d c e f a g
0->6* 3->3 : b c d e f a g
0->6  3->3*: b c d e f a g
0->6* 3->4 : b c d e f a g
0->6  3->4*: b c d e f a g
0->6* 3->5 : b c e d f a g
0->6  3->5*: b c e d f a g
0->6* 3->6 : b c e f a d g
0->6  3->6*: b c e f d a g
0->6* 3->7 : b c e f a g d
0->6  3->7*: b c e f a g d
0->6* 4->0 : e b c d f a g
0->6  4->0*: e b c d f a g
0->6* 4->1 : e b c d f a g
0->6  4->1*: e b c d f a g
0->6* 4->2 : b e c d f a g
0->6  4->2*: b e c d f a g
0->6* 4->3 : b c e d f a g
0->6  4->3*: b c e d f a g
0->6* 4->4 : b c d e f a g
0->6  4->4*: b c d e f a g
0->6* 4->5 : b c d e f a g
0->6  4->5*: b c d e f a g
0->6* 4->6 : b c d f a e g
0->6  4->6*: b c d f e a g
0->6* 4->7 : b c d f a g e
0->6  4->7*: b c d f a g e
0->6* 5->0 : f b c d e a g
0->6  5->0*: f b c d e a g
0->6* 5->1 : f b c d e a g
0->6  5->1*: f b c d e a g
0->6* 5->2 : b f c d e a g
0->6  5->2*: b f c d e a g
0->6* 5->3 : b c f d e a g
0->6  5->3*: b c f d e a g
0->6* 5->4 : b c d f e a g
0->6  5->4*: b c d f e a g
0->6* 5->5 : b c d e f a g
0->6  5->5*: b c d e f a g
0->6* 5->6 : b c d e f a g
0->6  5->6*: b c d e f a g
0->6* 5->7 : b c d e a g f
0->6  5->7*: b c d e a g f
0->6* 6->0 : g b c d e f a
0->6  6->0*: g b c d e f a
0->6* 6->1 : g b c d e f a
0->6  6->1*: g b c d e f a
0->6* 6->2 : b g c d e f a
0->6  6->2*: b g c d e f a
0->6* 6->3 : b c g d e f a
0->6  6->3*: b c g d e f a
0->6* 6->4 : b c d g e f a
0->6  6->4*: b c d g e f a
0->6* 6->5 : b c d e g f a
0->6  6->5*: b c d e g f a
0->6* 6->6 : b c d e f a g
0->6  6->6*: b c d e f a g
0->6* 6->7 : b c d e f a g
0->6  6->7*: b c d e f a g
0->7* 0->0 : b c d e f g a
0->7  0->0*: b c d e f g a
0->7* 0->1 : b c d e f g a
0->7  0->1*: b c d e f g a
0->7* 0->2 : b c d e f g a
0->7  0->2*: b a c d e f g
0->7* 0->3 : b c d e f g a
0->7  0->3*: b c a d e f g
0->7* 0->4 : b c d e f g a
0->7  0->4*: b c d a e f g
0->7* 0->5 : b c d e f g a
0->7  0->5*: b c d e a f g
0->7* 0->6 : b c d e f g a
0->7  0->6*: b c d e f a g
0->7* 0->7 : b c d e f g a
0->7  0->7*: b c d e f g a
0->7* 1->0 : b c d e f g a
0->7  1->0*: b c d e f g a
0->7* 1->1 : b c d e f g a
0->7  1->1*: b c d e f g a
0->7* 1->2 : b c d e f g a
0->7  1->2*: b c d e f g a
0->7* 1->3 : c b d e f g a
0->7  1->3*: c b d e f g a
0->7* 1->4 : c d b e f g a
0->7  1->4*: c d b e f g a
0->7* 1->5 : c d e b f g a
0->7  1->5*: c d e b f g a
0->7* 1->6 : c d e f b g a
0->7  1->6*: c d e f b g a
0->7* 1->7 : c d e f g a b
0->7  1->7*: c d e f g b a
0->7* 2->0 : c b d e f g a
0->7  2->0*: c b d e f g a
0->7* 2->1 : c b d e f g a
0->7  2->1*: c b d e f g a
0->7* 2->2 : b c d e f g a
0->7  2->2*: b c d e f g a
0->7* 2->3 : b c d e f g a
0->7  2->3*: b c d e f g a
0->7* 2->4 : b d c e f g a
0->7  2->4*: b d c e f g a
0->7* 2->5 : b d e c f g a
0->7  2->5*: b d e c f g a
0->7* 2->6 : b d e f c g a
0->7  2->6*: b d e f c g a
0->7* 2->7 : b d e f g a c
0->7  2->7*: b d e f g c a
0->7* 3->0 : d b c e f g a
0->7  3->0*: d b c e f g a
0->7* 3->1 : d b c e f g a
0->7  3->1*: d b c e f g a
0->7* 3->2 : b d c e f g a
0->7  3->2*: b d c e f g a
0->7* 3->3 : b c d e f g a
0->7  3->3*: b c d e f g a
0->7* 3->4 : b c d e f g a
0->7  3->4*: b c d e f g a
0->7* 3->5 : b c e d f g a
0->7  3->5*: b c e d f g a
0->7* 3->6 : b c e f d g a
0->7  3->6*: b c e f d g a
0->7* 3->7 : b c e f g a d
0->7  3->7*: b c e f g d a
0->7* 4->0 : e b c d f g a
0->7  4->0*: e b c d f g a
0->7* 4->1 : e b c d f g a
0->7  4->1*: e b c d f g a
0->7* 4->2 : b e c d f g a
0->7  4->2*: b e c d f g a
0->7* 4->3 : b c e d f g a
0->7  4->3*: b c e d f g a
0->7* 4->4 : b c d e f g a
0->7  4->4*: b c d e f g a
0->7* 4->5 : b c d e f g a
0->7  4->5*: b c d e f g a
0->7* 4->6 : b c d f e g a
0->7  4->6*: b c d f e g a
0->7* 4->7 : b c d f g a e
0->7  4->7*: b c d f g e a
0->7* 5->0 : f b c d e g a
0->7  5->0*: f b c d e g a
0->7* 5->1 : f b c d e g a
0->7  5->1*: f b c d e g a
0->7* 5->2 : b f c d e g a
0->7  5->2*: b f c d e g a
0->7* 5->3 : b c f d e g a
0->7  5->3*: b c f d e g a
0->7* 5->4 : b c d f e g a
0->7  5->4*: b c d f e g a
0->7* 5->5 : b c d e f g a
0->7  5->5*: b c d e f g a
0->7* 5->6 : b c d e f g a
0->7  5->6*: b c d e f g a
0->7* 5->7 : b c d e g a f
0->7  5->7*: b c d e g f a
0->7* 6->0 : g b c d e f a
0->7  6->0*: g b c d e f a
0->7* 6->1 : g b c d e f a
0->7  6->1*: g b c d e f a
0->7* 6->2 : b g c d e f a
0->7  6->2*: b g c d e f a
0->7* 6->3 : b c g d e f a
0->7  6->3*: b c g d e f a
0->7* 6->4 : b c d g e f a
0->7  6->4*: b c d g e f a
0->7* 6->5 : b c d e g f a
0->7  6->5*: b c d e g f a
0->7* 6->6 : b c d e f g a
0->7  6->6*: b c d e f g a
0->7* 6->7 : b c d e f g a
0->7  6->7*: b c d e f g a
1->0* 0->0 : b a c d e f g
1->0  0->0*: b a c d e f g
1->0* 0->1 : b a c d e f g
1->0  0->1*: b a c d e f g
1->0* 0->2 : b a c d e f g
1->0  0->2*: b a c d e f g
1->0* 0->3 : b c a d e f g
1->0  0->3*: b c a d e f g
1->0* 0->4 : b c d a e f g
1->0  0->4*: b c d a e f g
1->0* 0->5 : b c d e a f g
1->0  0->5*: b c d e a f g
1->0* 0->6 : b c d e f a g
1->0  0->6*: b c d e f a g
1->0* 0->7 : b c d e f g a
1->0  0->7*: b c d e f g a
1->0* 1->0 : b a c d e f g
1->0  1->0*: b a c d e f g
1->0* 1->1 : b a c d e f g
1->0  1->1*: b a c d e f g
1->0* 1->2 : b a c d e f g
1->0  1->2*: b a c d e f g
1->0* 1->3 : b a c d e f g
1->0  1->3*: a c b d e f g
1->0* 1->4 : b a c d e f g
1->0  1->4*: a c d b e f g
1->0* 1->5 : b a c d e f g
1->0  1->5*: a c d e b f g
1->0* 1->6 : b a c d e f g
1->0  1->6*: a c d e f b g
1->0* 1->7 : b a c d e f g
1->0  1->7*: a c d e f g b
1->0* 2->0 : b c a d e f g
1->0  2->0*: c b a d e f g
1->0* 2->1 : b a c d e f g
1->0  2->1*: b a c d e f g
1->0* 2->2 : b a c d e f g
1->0  2->2*: b a c d e f g
1->0* 2->3 : b a c d e f g
1->0  2->3*: b a c d e f g
1->0* 2->4 : b a d c e f g
1->0  2->4*: b a d c e f g
1->0* 2->5 : b a d e c f g
1->0  2->5*: b a d e c f g
1->0* 2->6 : b a d e f c g
1->0  2->6*: b a d e f c g
1->0* 2->7 : b a d e f g c
1->0  2->7*: b a d e f g c
1->0* 3->0 : b d a c e f g
1->0  3->0*: d b a c e f g
1->0* 3->1 : b a d c e f g
1->0  3->1*: b a d c e f g
1->0* 3->2 : b a d c e f g
1->0  3->2*: b a d c e f g
1->0* 3->3 : b a c d e f g
1->0  3->3*: b a c d e f g
1->0* 3->4 : b a c d e f g
1->0  3->4*: b a c d e f g
1->0* 3->5 : b a c e d f g
1->0  3->5*: b a c e d f g
1->0* 3->6 : b a c e f d g
1->0  3->6*: b a c e f d g
1->0* 3->7 : b a c e f g d
1->0  3->7*: b a c e f g d
1->0* 4->0 : b e a c d f g
1->0  4->0*: e b a c d f g
1->0* 4->1 : b a e c d f g
1->0  4->1*: b a e c d f g
1->0* 4->2 : b a e c d f g
1->0  4->2*: b a e c d f g
1->0* 4->3 : b a c e d f g
1->0  4->3*: b a c e d f g
1->0* 4->4 : b a c d e f g
1->0  4->4*: b a c d e f g
1->0* 4->5 : b a c d e f g
1->0  4->5*: b a c d e f g
1->0* 4->6 : b a c d f e g
1->0  4->6*: b a c d f e g
1->0* 4->7 : b a c d f g e
1->0  4->7*: b a c d f g e
1->0* 5->0 : b f a c d e g
1->0  5->0*: f b a c d e g
1->0* 5->1 : b a f c d e g
1->0  5->1*: b a f c d e g
1->0* 5->2 : b a f c d e g
1->0  5->2*: b a f c d e g
1->0* 5->3 : b a c f d e g
1->0  5->3*: b a c f d e g
1->0* 5->4 : b a c d f e g
1->0  5->4*: b a c d f e g
1->0* 5->5 : b a c d e f g
1->0  5->5*: b a c d e f g
1->0* 5->6 : b a c d e f g
1->0  5->6*: b a c d e f g
1->0* 5->7 : b a c d e g f
1->0  5->7*: b a c d e g f
1->0* 6->0 : b g a c d e f
1->0  6->0*: g b a c d e f
1->0* 6->1 : b a g c d e f
1->0  6->1*: b a g c d e f
1->0* 6->2 : b a g c d e f
1->0  6->2*: b a g c d e f
1->0* 6->3 : b a c g d e f
1->0  6->3*: b a c g d e f
1->0* 6->4 : b a c d g e f
1->0  6->4*: b a c d g e f
1->0* 6->5 : b a c d e g f
1->0  6->5*: b a c d e g f
1->0* 6->6 : b a c d e f g
1->0  6->6*: b a c d e f g
1->0* 6->7 : b a c d e f g
1->0  6->7*: b a c d e f g
1->1* 0->0 : a b c d e f g
1->1  0->0*: a b c d e f g
1->1* 0->1 : a b c d e f g
1->1  0->1*: a b c d e f g
1->1* 0->2 : b a c d e f g
1->1  0->2*: b a c d e f g
1->1* 0->3 : b c a d e f g
1->1  0->3*: b c a d e f g
1->1* 0->4 : b c d a e f g
1->1  0->4*: b c d a e f g
1->1* 0->5 : b c d e a f g
1->1  0->5*: b c d e a f g
1->1* 0->6 : b c d e f a g
1->1  0->6*: b c d e f a g
1->1* 0->7 : b c d e f g a
1->1  0->7*: b c d e f g a
1->1* 1->0 : b a c d e f g
1->1  1->0*: b a c d e f g
1->1* 1->1 : a b c d e f g
1->1  1->1*: a b c d e f g
1->1* 1->2 : a b c d e f g
1->1  1->2*: a b c d e f g
1->1* 1->3 : a c b d e f g
1->1  1->3*: a c b d e f g
1->1* 1->4 : a c d b e f g
1->1  1->4*: a c d b e f g
1->1* 1->5 : a c d e b f g
1->1  1->5*: a c d e b f g
1->1* 1->6 : a c d e f b g
1->1  1->6*: a c d e f b g
1->1* 1->7 : a c d e f g b
1->1  1->7*: a c d e f g b
1->1* 2->0 : c a b d e f g
1->1  2->0*: c a b d e f g
1->1* 2->1 : a c b d e f g
1->1  2->1*: a c b d e f g
1->1* 2->2 : a b c d e f g
1->1  2->2*: a b c d e f g
1->1* 2->3 : a b c d e f g
1->1  2->3*: a b c d e f g
1->1* 2->4 : a b d c e f g
1->1  2->4*: a b d c e f g
1->1* 2->5 : a b d e c f g
1->1  2->5*: a b d e c f g
1->1* 2->6 : a b d e f c g
1->1  2->6*: a b d e f c g
1->1* 2->7 : a b d e f g c
1->1  2->7*: a b d e f g c
1->1* 3->0 : d a b c e f g
1->1  3->0*: d a b c e f g
1->1* 3->1 : a d b c e f g
1->1  3->1*: a d b c e f g
1->1* 3->2 : a b d c e f g
1->1  3->2*: a b d c e f g
1->1* 3->3 : a b c d e f g
1->1  3->3*: a b c d e f g
1->1* 3->4 : a b c d e f g
1->1  3->4*: a b c d e f g
1->1* 3->5 : a b c e d f g
1->1  3->5*: a b c e d f g
1->1* 3->6 : a b c e f d g
1->1  3->6*: a b c e f d g
1->1* 3->7 : a b c e f g d
1->1  3->7*: a b c e f g d
1->1* 4->0 : e a b c d f g
1->1  4->0*: e a b c d f g
1->1* 4->1 : a e b c d f g
1->1  4->1*: a e b c d f g
1->1* 4->2 : a b e c d f g
1->1  4->2*: a b e c d f g
1->1* 4->3 : a b c e d f g
1->1  4->3*: a b c e d f g
1->1* 4->4 : a b c d e f g
1->1  4->4*: a b c d e f g
1->1* 4->5 : a b c d e f g
1->1  4->5*: a b c d e f g
1->1* 4->6 : a b c d f e g
1->1  4->6*: a b c d f e g
1->1* 4->7 : a b c d f g e
1->1  4->7*: a b c d f g e
1->1* 5->0 : f a b c d e g
1->1  5->0*: f a b c d e g
1->1* 5->1 : a f b c d e g
1->1  5->1*: a f b c d e g
1->1* 5->2 : a b f c d e g
1->1  5->2*: a b f c d e g
1->1* 5->3 : a b c f d e g
1->1  5->3*: a b c f d e g
1->1* 5->4 : a b c d f e g
1->1  5->4*: a b c d f e g
1->1* 5->5 : a b c d e f g
1->1  5->5*: a b c d e f g
1->1* 5->6 : a b c d e f g
1->1  5->6*: a b c d e f g
1->1* 5->7 : a b c d e g f
1->1  5->7*: a b c d e g f
1->1* 6->0 : g a b c d e f
1->1  6->0*: g a b c d e f
1->1* 6->1 : a g b c d e f
1->1  6->1*: a g b c d e f
1->1* 6->2 : a b g c d e f
1->1  6->2*: a b g c d e f
1->1* 6->3 : a b c g d e f
1->1  6->3*: a b c g d e f
1->1* 6->4 : a b c d g e f
1->1  6->4*: a b c d g e f
1->1* 6->5 : a b c d e g f
1->1  6->5*: a b c d e g f
1->1* 6->6 : a b c d e f g
1->1  6->6*: a b c d e f g
1->1* 6->7 : a b c d e f g
1->1  6->7*: a b c d e f g
1->2* 0->0 : a b c d e f g
1->2  0->0*: a b c d e f g
1->2* 0->1 : a b c d e f g
1->2  0->1*: a b c d e f g
1->2* 0->2 : b a c d e f g
1->2  0->2*: b a c d e f g
1->2* 0->3 : b c a d e f g
1->2  0->3*: b c a d e f g
1->2* 0->4 : b c d a e f g
1->2  0->4*: b c d a e f g
1->2* 0->5 : b c d e a f g
1->2  0->5*: b c d e a f g
1->2* 0->6 : b c d e f a g
1->2  0->6*: b c d e f a g
1->2* 0->7 : b c d e f g a
1->2  0->7*: b c d e f g a
1->2* 1->0 : b a c d e f g
1->2  1->0*: b a c d e f g
1->2* 1->1 : a b c d e f g
1->2  1->1*: a b c d e f g
1->2* 1->2 : a b c d e f g
1->2  1->2*: a b c d e f g
1->2* 1->3 : a c b d e f g
1->2  1->3*: a c b d e f g
1->2* 1->4 : a c d b e f g
1->2  1->4*: a c d b e f g
1->2* 1->5 : a c d e b f g
1->2  1->5*: a c d e b f g
1->2* 1->6 : a c d e f b g
1->2  1->6*: a c d e f b g
1->2* 1->7 : a c d e f g b
1->2  1->7*: a c d e f g b
1->2* 2->0 : c a b d e f g
1->2  2->0*: c a b d e f g
1->2* 2->1 : a c b d e f g
1->2  2->1*: a c b d e f g
1->2* 2->2 : a b c d e f g
1->2  2->2*: a b c d e f g
1->2* 2->3 : a b c d e f g
1->2  2->3*: a b c d e f g
1->2* 2->4 : a b d c e f g
1->2  2->4*: a b d c e f g
1->2* 2->5 : a b d e c f g
1->2  2->5*: a b d e c f g
1->2* 2->6 : a b d e f c g
1->2  2->6*: a b d e f c g
1->2* 2->7 : a b d e f g c
1->2  2->7*: a b d e f g c
1->2* 3->0 : d a b c e f g
1->2  3->0*: d a b c e f g
1->2* 3->1 : a d b c e f g
1->2  3->1*: a d b c e f g
1->2* 3->2 : a b d c e f g
1->2  3->2*: a b d c e f g
1->2* 3->3 : a b c d e f g
1->2  3->3*: a b c d e f g
1->2* 3->4 : a b c d e f g
1->2  3->4*: a b c d e f g
1->2* 3->5 : a b c e d f g
1->2  3->5*: a b c e d f g
1->2* 3->6 : a b c e f d g
1->2  3->6*: a b c e f d g
1->2* 3->7 : a b c e f g d
1->2  3->7*: a b c e f g d
1->2* 4->0 : e a b c d f g
1->2  4->0*: e a b c d f g
1->2* 4->1 : a e b c d f g
1->2  4->1*: a e b c d f g
1->2* 4->2 : a b e c d f g
1->2  4->2*: a b e c d f g
1->2* 4->3 : a b c e d f g
1->2  4->3*: a b c e d f g
1->2* 4->4 : a b c d e f g
1->2  4->4*: a b c d e f g
1->2* 4->5 : a b c d e f g
1->2  4->5*: a b c d e f g
1->2* 4->6 : a b c d f e g
1->2  4->6*: a b c d f e g
1->2* 4->7 : a b c d f g e
1->2  4->7*: a b c d f g e
1->2* 5->0 : f a b c d e g
1->2  5->0*: f a b c d e g
1->2* 5->1 : a f b c d e g
1->2  5->1*: a f b c d e g
1->2* 5->2 : a b f c d e g
1->2  5->2*: a b f c d e g
1->2* 5->3 : a b c f d e g
1->2  5->3*: a b c f d e g
1->2* 5->4 : a b c d f e g
1->2  5->4*: a b c d f e g
1->2* 5->5 : a b c d e f g
1->2  5->5*: a b c d e f g
1->2* 5->6 : a b c d e f g
1->2  5->6*: a b c d e f g
1->2* 5->7 : a b c d e g f
1->2  5->7*: a b c d e g f
1->2* 6->0 : g a b c d e f
1->2  6->0*: g a b c d e f
1->2* 6->1 : a g b c d e f
1->2  6->1*: a g b c d e f
1->2* 6->2 : a b g c d e f
1->2  6->2*: a b g c d e f
1->2* 6->3 : a b c g d e f
1->2  6->3*: a b c g d e f
1->2* 6->4 : a b c d g e f
1->2  6->4*: a b c d g e f
1->2* 6->5 : a b c d e g f
1->2  6->5*: a b c d e g f
1->2* 6->6 : a b c d e f g
1->2  6->6*: a b c d e f g
1->2* 6->7 : a b c d e f g
1->2  6->7*: a b c d e f g
1->3* 0->0 : a c b d e f g
1->3  0->0*: a c b d e f g
1->3* 0->1 : a c b d e f g
1->3  0->1*: a c b d e f g
1->3* 0->2 : a c b d e f g
1->3  0->2*: a c b d e f g
1->3* 0->3 : c b a d e f g
1->3  0->3*: c a b d e f g
1->3* 0->4 : c b d a e f g
1->3  0->4*: c b d a e f g
1->3* 0->5 : c b d e a f g
1->3  0->5*: c b d e a f g
1->3* 0->6 : c b d e f a g
1->3  0->6*: c b d e f a g
1->3* 0->7 : c b d e f g a
1->3  0->7*: c b d e f g a
1->3* 1->0 : a c b d e f g
1->3  1->0*: b a c d e f g
1->3* 1->1 : a c b d e f g
1->3  1->1*: a c b d e f g
1->3* 1->2 : a c b d e f g
1->3  1->2*: a c b d e f g
1->3* 1->3 : a c b d e f g
1->3  1->3*: a c b d e f g
1->3* 1->4 : a c b d e f g
1->3  1->4*: a c d b e f g
1->3* 1->5 : a c b d e f g
1->3  1->5*: a c d e b f g
1->3* 1->6 : a c b d e f g
1->3  1->6*: a c d e f b g
1->3* 1->7 : a c b d e f g
1->3  1->7*: a c d e f g b
1->3* 2->0 : c a b d e f g
1->3  2->0*: c a b d e f g
1->3* 2->1 : a c b d e f g
1->3  2->1*: a c b d e f g
1->3* 2->2 : a c b d e f g
1->3  2->2*: a c b d e f g
1->3* 2->3 : a c b d e f g
1->3  2->3*: a c b d e f g
1->3* 2->4 : a b d c e f g
1->3  2->4*: a b d c e f g
1->3* 2->5 : a b d e c f g
1->3  2->5*: a b d e c f g
1->3* 2->6 : a b d e f c g
1->3  2->6*: a b d e f c g
1->3* 2->7 : a b d e f g c
1->3  2->7*: a b d e f g c
1->3* 3->0 : d a c b e f g
1->3  3->0*: d a c b e f g
1->3* 3->1 : a d c b e f g
1->3  3->1*: a d c b e f g
1->3* 3->2 : a d c b e f g
1->3  3->2*: a d c b e f g
1->3* 3->3 : a c b d e f g
1->3  3->3*: a c b d e f g
1->3* 3->4 : a c b d e f g
1->3  3->4*: a c b d e f g
1->3* 3->5 : a c b e d f g
1->3  3->5*: a c b e d f g
1->3* 3->6 : a c b e f d g
1->3  3->6*: a c b e f d g
1->3* 3->7 : a c b e f g d
1->3  3->7*: a c b e f g d
1->3* 4->0 : e a c b d f g
1->3  4->0*: e a c b d f g
1->3* 4->1 : a e c b d f g
1->3  4->1*: a e c b d f g
1->3* 4->2 : a e c b d f g
1->3  4->2*: a e c b d f g
1->3* 4->3 : a c b e d f g
1->3  4->3*: a c e b d f g
1->3* 4->4 : a c b d e f g
1->3  4->4*: a c b d e f g
1->3* 4->5 : a c b d e f g
1->3  4->5*: a c b d e f g
1->3* 4->6 : a c b d f e g
1->3  4->6*: a c b d f e g
1->3* 4->7 : a c b d f g e
1->3  4->7*: a c b d f g e
1->3* 5->0 : f a c b d e g
1->3  5->0*: f a c b d e g
1->3* 5->1 : a f c b d e g
1->3  5->1*: a f c b d e g
1->3* 5->2 : a f c b d e g
1->3  5->2*: a f c b d e g
1->3* 5->3 : a c b f d e g
1->3  5->3*: a c f b d e g
1->3* 5->4 : a c b d f e g
1->3  5->4*: a c b d f e g
1->3* 5->5 : a c b d e f g
1->3  5->5*: a c b d e f g
1->3* 5->6 : a c b d e f g
1->3  5->6*: a c b d e f g
1->3* 5->7 : a c b d e g f
1->3  5->7*: a c b d e g f
1->3* 6->0 : g a c b d e f
1->3  6->0*: g a c b d e f
1->3* 6->1 : a g c b d e f
1->3  6->1*: a g c b d e f
1->3* 6->2 : a g c b d e f
1->3  6->2*: a g c b d e f
1->3* 6->3 : a c b g d e f
1->3  6->3*: a c g b d e f
1->3* 6->4 : a c b d g e f
1->3  6->4*: a c b d g e f
1->3* 6->5 : a c b d e g f
1->3  6->5*: a c b d e g f
1->3* 6->6 : a c b d e f g
1->3  6->6*: a c b d e f g
1->3* 6->7 : a c b d e f g
1->3  6->7*: a c b d e f g
1->4* 0->0 : a c d b e f g
1->4  0->0*: a c d b e f g
1->4* 0->1 : a c d b e f g
1->4  0->1*: a c d b e f g
1->4* 0->2 : a c d b e f g
1->4  0->2*: a c d b e f g
1->4* 0->3 : c a d b e f g
1->4  0->3*: c a d b e f g
1->4* 0->4 : c d b a e f g
1->4  0->4*: c d a b e f g
1->4* 0->5 : c d b e a f g
1->4  0->5*: c d b e a f g
1->4* 0->6 : c d b e f a g
1->4  0->6*: c d b e f a g
1->4* 0->7 : c d b e f g a
1->4  0->7*: c d b e f g a
1->4* 1->0 : a c d b e f g
1->4  1->0*: b a c d e f g
1->4* 1->1 : a c d b e f g
1->4  1->1*: a c d b e f g
1->4* 1->2 : a c d b e f g
1->4  1->2*: a c d b e f g
1->4* 1->3 : a c d b e f g
1->4  1->3*: a c b d e f g
1->4* 1->4 : a c d b e f g
1->4  1->4*: a c d b e f g
1->4* 1->5 : a c d b e f g
1->4  1->5*: a c d e b f g
1->4* 1->6 : a c d b e f g
1->4  1->6*: a c d e f b g
1->4* 1->7 : a c d b e f g
1->4  1->7*: a c d e f g b
1->4* 2->0 : c a d b e f g
1->4  2->0*: c a d b e f g
1->4* 2->1 : a c d b e f g
1->4  2->1*: a c d b e f g
1->4* 2->2 : a c d b e f g
1->4  2->2*: a c d b e f g
1->4* 2->3 : a c d b e f g
1->4  2->3*: a c d b e f g
1->4* 2->4 : a d b c e f g
1->4  2->4*: a d c b e f g
1->4* 2->5 : a d b e c f g
1->4  2->5*: a d b e c f g
1->4* 2->6 : a d b e f c g
1->4  2->6*: a d b e f c g
1->4* 2->7 : a d b e f g c
1->4  2->7*: a d b e f g c
1->4* 3->0 : d a c b e f g
1->4  3->0*: d a c b e f g
1->4* 3->1 : a d c b e f g
1->4  3->1*: a d c b e f g
1->4* 3->2 : a d c b e f g
1->4  3->2*: a d c b e f g
1->4* 3->3 : a c d b e f g
1->4  3->3*: a c d b e f g
1->4* 3->4 : a c d b e f g
1->4  3->4*: a c d b e f g
1->4* 3->5 : a c b e d f g
1->4  3->5*: a c b e d f g
1->4* 3->6 : a c b e f d g
1->4  3->6*: a c b e f d g
1->4* 3->7 : a c b e f g d
1->4  3->7*: a c b e f g d
1->4* 4->0 : e a c d b f g
1->4  4->0*: e a c d b f g
1->4* 4->1 : a e c d b f g
1->4  4->1*: a e c d b f g
1->4* 4->2 : a e c d b f g
1->4  4->2*: a e c d b f g
1->4* 4->3 : a c e d b f g
1->4  4->3*: a c e d b f g
1->4* 4->4 : a c d b e f g
1->4  4->4*: a c d b e f g
1->4* 4->5 : a c d b e f g
1->4  4->5*: a c d b e f g
1->4* 4->6 : a c d b f e g
1->4  4->6*: a c d b f e g
1->4* 4->7 : a c d b f g e
1->4  4->7*: a c d b f g e
1->4* 5->0 : f a c d b e g
1->4  5->0*: f a c d b e g
1->4* 5->1 : a f c d b e g
1->4  5->1*: a f c d b e g
1->4* 5->2 : a f c d b e g
1->4  5->2*: a f c d b e g
1->4* 5->3 : a c f d b e g
1->4  5->3*: a c f d b e g
1->4* 5->4 : a c d b f e g
1->4  5->4*: a c d f b e g
1->4* 5->5 : a c d b e f g
1->4  5->5*: a c d b e f g
1->4* 5->6 : a c d b e f g
1->4  5->6*: a c d b e f g
1->4* 5->7 : a c d b e g f
1->4  5->7*: a c d b e g f
1->4* 6->0 : g a c d b e f
1->4  6->0*: g a c d b e f
1->4* 6->1 : a g c d b e f
1->4  6->1*: a g c d b e f
1->4* 6->2 : a g c d b e f
1->4  6->2*: a g c d b e f
1->4* 6->3 : a c g d b e f
1->4  6->3*: a c g d b e f
1->4* 6->4 : a c d b g e f
1->4  6->4*: a c d g b e f
1->4* 6->5 : a c d b e g f
1->4  6->5*: a c d b e g f
1->4* 6->6 : a c d b e f g
1->4  6->6*: a c d b e f g
1->4* 6->7 : a c d b e f g
1->4  6->7*: a c d b e f g
1->5* 0->0 : a c d e b f g
1->5  0->0*: a c d e b f g
1->5* 0->1 : a c d e b f g
1->5  0->1*: a c d e b f g
1->5* 0->2 : a c d e b f g
1->5  0->2*: a c d e b f g
1->5* 0->3 : c a d e b f g
1->5  0->3*: c a d e b f g
1->5* 0->4 : c d a e b f g
1->5  0->4*: c d a e b f g
1->5* 0->5 : c d e b a f g
1->5  0->5*: c d e a b f g
1->5* 0->6 : c d e b f a g
1->5  0->6*: c d e b f a g
1->5* 0->7 : c d e b f g a
1->5  0->7*: c d e b f g a
1->5* 1->0 : a c d e b f g
1->5  1->0*: b a c d e f g
1->5* 1->1 : a c d e b f g
1->5  1->1*: a c d e b f g
1->5* 1->2 : a c d e b f g
1->5  1->2*: a c d e b f g
1->5* 1->3 : a c d e b f g
1->5  1->3*: a c b d e f g
1->5* 1->4 : a c d e b f g
1->5  1->4*: a c d b e f g
1->5* 1->5 : a c d e b f g
1->5  1->5*: a c d e b f g
1->5* 1->6 : a c d e b f g
1->5  1->6*: a c d e f b g
1->5* 1->7 : a c d e b f g
1->5  1->7*: a c d e f g b
1->5* 2->0 : c a d e b f g
1->5  2->0*: c a d e b f g
1->5* 2->1 : a c d e b f g
1->5  2->1*: a c d e b f g
1->5* 2->2 : a c d e b f g
1->5  2->2*: a c d e b f g
1->5* 2->3 : a c d e b f g
1->5  2->3*: a c d e b f g
1->5* 2->4 : a d c e b f g
1->5  2->4*: a d c e b f g
1->5* 2->5 : a d e b c f g
1->5  2->5*: a d e c b f g
1->5* 2->6 : a d e b f c g
1->5  2->6*: a d e b f c g
1->5* 2->7 : a d e b f g c
1->5  2->7*: a d e b f g c
1->5* 3->0 : d a c e b f g
1->5  3->0*: d a c e b f g
1->5* 3->1 : a d c e b f g
1->5  3->1*: a d c e b f g
1->5* 3->2 : a d c e b f g
1->5  3->2*: a d c e b f g
1->5* 3->3 : a c d e b f g
1->5  3->3*: a c d e b f g
1->5* 3->4 : a c d e b f g
1->5  3->4*: a c d e b f g
1->5* 3->5 : a c e b d f g
1->5  3->5*: a c e d b f g
1->5* 3->6 : a c e b f d g
1->5  3->6*: a c e b f d g
1->5* 3->7 : a c e b f g d
1->5  3->7*: a c e b f g d
1->5* 4->0 : e a c d b f g
1->5  4->0*: e a c d b f g
1->5* 4->1 : a e c d b f g
1->5  4->1*: a e c d b f g
1->5* 4->2 : a e c d b f g
1->5  4->2*: a e c d b f g
1->5* 4->3 : a c e d b f g
1->5  4->3*: a c e d b f g
1->5* 4->4 : a c d e b f g
1->5  4->4*: a c d e b f g
1->5* 4->5 : a c d e b f g
1->5  4->5*: a c d e b f g
1->5* 4->6 : a c d b f e g
1->5  4->6*: a c d b f e g
1->5* 4->7 : a c d b f g e
1->5  4->7*: a c d b f g e
1->5* 5->0 : f a c d e b g
1->5  5->0*: f a c d e b g
1->5* 5->1 : a f c d e b g
1->5  5->1*: a f c d e b g
1->5* 5->2 : a f c d e b g
1->5  5->2*: a f c d e b g
1->5* 5->3 : a c f d e b g
1->5  5->3*: a c f d e b g
1->5* 5->4 : a c d f e b g
1->5  5->4*: a c d f e b g
1->5* 5->5 : a c d e b f g
1->5  5->5*: a c d e b f g
1->5* 5->6 : a c d e b f g
1->5  5->6*: a c d e b f g
1->5* 5->7 : a c d e b g f
1->5  5->7*: a c d e b g f
1->5* 6->0 : g a c d e b f
1->5  6->0*: g a c d e b f
1->5* 6->1 : a g c d e b f
1->5  6->1*: a g c d e b f
1->5* 6->2 : a g c d e b f
1->5  6->2*: a g c d e b f
1->5* 6->3 : a c g d e b f
1->5  6->3*: a c g d e b f
1->5* 6->4 : a c d g e b f
1->5  6->4*: a c d g e b f
1->5* 6->5 : a c d e b g f
1->5  6->5*: a c d e g b f
1->5* 6->6 : a c d e b f g
1->5  6->6*: a c d e b f g
1->5* 6->7 : a c d e b f g
1->5  6->7*: a c d e b f g
1->6* 0->0 : a c d e f b g
1->6  0->0*: a c d e f b g
1->6* 0->1 : a c d e f b g
1->6  0->1*: a c d e f b g
1->6* 0->2 : a c d e f b g
1->6  0->2*: a c d e f b g
1->6* 0->3 : c a d e f b g
1->6  0->3*: c a d e f b g
1->6* 0->4 : c d a e f b g
1->6  0->4*: c d a e f b g
1->6* 0->5 : c d e a f b g
1->6  0->5*: c d e a f b g
1->6* 0->6 : c d e f b a g
1->6  0->6*: c d e f a b g
1->6* 0->7 : c d e f b g a
1->6  0->7*: c d e f b g a
1->6* 1->0 : a c d e f b g
1->6  1->0*: b a c d e f g
1->6* 1->1 : a c d e f b g
1->6  1->1*: a c d e f b g
1->6* 1->2 : a c d e f b g
1->6  1->2*: a c d e f b g
1->6* 1->3 : a c d e f b g
1->6  1->3*: a c b d e f g
1->6* 1->4 : a c d e f b g
1->6  1->4*: a c d b e f g
1->6* 1->5 : a c d e f b g
1->6  1->5*: a c d e b f g
1->6* 1->6 : a c d e f b g
1->6  1->6*: a c d e f b g
1->6* 1->7 : a c d e f b g
1->6  1->7*: a c d e f g b
1->6* 2->0 : c a d e f b g
1->6  2->0*: c a d e f b g
1->6* 2->1 : a c d e f b g
1->6  2->1*: a c d e f b g
1->6* 2->2 : a c d e f b g
1->6  2->2*: a c d e f b g
1->6* 2->3 : a c d e f b g
1->6  2->3*: a c d e f b g
1->6* 2->4 : a d c e f b g
1->6  2->4*: a d c e f b g
1->6* 2->5 : a d e c f b g
1->6  2->5*: a d e c f b g
1->6* 2->6 : a d e f b c g
1->6  2->6*: a d e f c b g
1->6* 2->7 : a d e f b g c
1->6  2->7*: a d e f b g c
1->6* 3->0 : d a c e f b g
1->6  3->0*: d a c e f b g
1->6* 3->1 : a d c e f b g
1->6  3->1*: a d c e f b g
1->6* 3->2 : a d c e f b g
1->6  3->2*: a d c e f b g
1->6* 3->3 : a c d e f b g
1->6  3->3*: a c d e f b g
1->6* 3->4 : a c d e f b g
1->6  3->4*: a c d e f b g
1->6* 3->5 : a c e d f b g
1->6  3->5*: a c e d f b g
1->6* 3->6 : a c e f b d g
1->6  3->6*: a c e f d b g
1->6* 3->7 : a c e f b g d
1->6  3->7*: a c e f b g d
1->6* 4->0 : e a c d f b g
1->6  4->0*: e a c d f b g
1->6* 4->1 : a e c d f b g
1->6  4->1*: a e c d f b g
1->6* 4->2 : a e c d f b g
1->6  4->2*: a e c d f b g
1->6* 4->3 : a c e d f b g
1->6  4->3*: a c e d f b g
1->6* 4->4 : a c d e f b g
1->6  4->4*: a c d e f b g
1->6* 4->5 : a c d e f b g
1->6  4->5*: a c d e f b g
1->6* 4->6 : a c d f b e g
1->6  4->6*: a c d f e b g
1->6* 4->7 : a c d f b g e
1->6  4->7*: a c d f b g e
1->6* 5->0 : f a c d e b g
1->6  5->0*: f a c d e b g
1->6* 5->1 : a f c d e b g
1->6  5->1*: a f c d e b g
1->6* 5->2 : a f c d e b g
1->6  5->2*: a f c d e b g
1->6* 5->3 : a c f d e b g
1->6  5->3*: a c f d e b g
1->6* 5->4 : a c d f e b g
1->6  5->4*: a c d f e b g
1->6* 5->5 : a c d e f b g
1->6  5->5*: a c d e f b g
1->6* 5->6 : a c d e f b g
1->6  5->6*: a c d e f b g
1->6* 5->7 : a c d e b g f
1->6  5->7*: a c d e b g f
1->6* 6->0 : g a c d e f b
1->6  6->0*: g a c d e f b
1->6* 6->1 : a g c d e f b
1->6  6->1*: a g c d e f b
1->6* 6->2 : a g c d e f b
1->6  6->2*: a g c d e f b
1->6* 6->3 : a c g d e f b
1->6  6->3*: a c g d e f b
1->6* 6->4 : a c d g e f b
1->6  6->4*: a c d g e f b
1->6* 6->5 : a c d e g f b
1->6  6->5*: a c d e g f b
1->6* 6->6 : a c d e f b g
1->6  6->6*: a c d e f b g
1->6* 6->7 : a c d e f b g
1->6  6->7*: a c d e f b g
1->7* 0->0 : a c d e f g b
1->7  0->0*: a c d e f g b
1->7* 0->1 : a c d e f g b
1->7  0->1*: a c d e f g b
1->7* 0->2 : a c d e f g b
1->7  0->2*: a c d e f g b
1->7* 0->3 : c a d e f g b
1->7  0->3*: c a d e f g b
1->7* 0->4 : c d a e f g b
1->7  0->4*: c d a e f g b
1->7* 0->5 : c d e a f g b
1->7  0->5*: c d e a f g b
1->7* 0->6 : c d e f a g b
1->7  0->6*: c d e f a g b
1->7* 0->7 : c d e f g b a
1->7  0->7*: c d e f g a b
1->7* 1->0 : a c d e f g b
1->7  1->0*: b a c d e f g
1->7* 1->1 : a c d e f g b
1->7  1->1*: a c d e f g b
1->7* 1->2 : a c d e f g b
1->7  1->2*: a c d e f g b
1->7* 1->3 : a c d e f g b
1->7  1->3*: a c b d e f g
1->7* 1->4 : a c d e f g b
1->7  1->4*: a c d b e f g
1->7* 1->5 : a c d e f g b
1->7  1->5*: a c d e b f g
1->7* 1->6 : a c d e f g b
1->7  1->6*: a c d e f b g
1->7* 1->7 : a c d e f g b
1->7  1->7*: a c d e f g b
1->7* 2->0 : c a d e f g b
1->7  2->0*: c a d e f g b
1->7* 2->1 : a c d e f g b
1->7  2->1*: a c d e f g b
1->7* 2->2 : a c d e f g b
1->7  2->2*: a c d e f g b
1->7* 2->3 : a c d e f g b
1->7  2->3*: a c d e f g b
1->7* 2->4 : a d c e f g b
1->7  2->4*: a d c e f g b
1->7* 2->5 : a d e c f g b
1->7  2->5*: a d e c f g b
1->7* 2->6 : a d e f c g b
1->7  2->6*: a d e f c g b
1->7* 2->7 : a d e f g b c
1->7  2->7*: a d e f g c b
1->7* 3->0 : d a c e f g b
1->7  3->0*: d a c e f g b
1->7* 3->1 : a d c e f g b
1->7  3->1*: a d c e f g b
1->7* 3->2 : a d c e f g b
1->7  3->2*: a d c e f g b
1->7* 3->3 : a c d e f g b
1->7  3->3*: a c d e f g b
1->7* 3->4 : a c d e f g b
1->7  3->4*: a c d e f g b
1->7* 3->5 : a c e d f g b
1->7  3->5*: a c e d f g b
1->7* 3->6 : a c e f d g b
1->7  3->6*: a c e f d g b
1->7* 3->7 : a c e f g b d
1->7  3->7*: a c e f g d b
1->7* 4->0 : e a c d f g b
1->7  4->0*: e a c d f g b
1->7* 4->1 : a e c d f g b
1->7  4->1*: a e c d f g b
1->7* 4->2 : a e c d f g b
1->7  4->2*: a e c d f g b
1->7* 4->3 : a c e d f g b
1->7  4->3*: a c e d f g b
1->7* 4->4 : a c d e f g b
1->7  4->4*: a c d e f g b
1->7* 4->5 : a c d e f g b
1->7  4->5*: a c d e f g b
1->7* 4->6 : a c d f e g b
1->7  4->6*: a c d f e g b
1->7* 4->7 : a c d f g b e
1->7  4->7*: a c d f g e b
1->7* 5->0 : f a c d e g b
1->7  5->0*: f a c d e g b
1->7* 5->1 : a f c d e g b
1->7  5->1*: a f c d e g b
1->7* 5->2 : a f c d e g b
1->7  5->2*: a f c d e g b
1->7* 5->3 : a c f d e g b
1->7  5->3*: a c f d e g b
1->7* 5->4 : a c d f e g b
1->7  5->4*: a c d f e g b
1->7* 5->5 : a c d e f g b
1->7  5->5*: a c d e f g b
1->7* 5->6 : a c d e f g b
1->7  5->6*: a c d e f g b
1->7* 5->7 : a c d e g b f
1->7  5->7*: a c d e g f b
1->7* 6->0 : g a c d e f b
1->7  6->0*: g a c d e f b
1->7* 6->1 : a g c d e f b
1->7  6->1*: a g c d e f b
1->7* 6->2 : a g c d e f b
1->7  6->2*: a g c d e f b
1->7* 6->3 : a c g d e f b
1->7  6->3*: a c g d e f b
1->7* 6->4 : a c d g e f b
1->7  6->4*: a c d g e f b
1->7* 6->5 : a c d e g f b
1->7  6->5*: a c d e g f b
1->7* 6->6 : a c d e f g b
1->7  6->6*: a c d e f g b
1->7* 6->7 : a c d e f g b
1->7  6->7*: a c d e f g b
2->0* 0->0 : c a b d e f g
2->0  0->0*: c a b d e f g
2->0* 0->1 : c a b d e f g
2->0  0->1*: c a b d e f g
2->0* 0->2 : c b a d e f g
2->0  0->2*: c b a d e f g
2->0* 0->3 : c b a d e f g
2->0  0->3*: c b a d e f g
2->0* 0->4 : c b d a e f g
2->0  0->4*: c b d a e f g
2->0* 0->5 : c b d e a f g
2->0  0->5*: c b d e a f g
2->0* 0->6 : c b d e f a g
2->0  0->6*: c b d e f a g
2->0* 0->7 : c b d e f g a
2->0  0->7*: c b d e f g a
2->0* 1->0 : c b a d e f g
2->0  1->0*: b c a d e f g
2->0* 1->1 : c a b d e f g
2->0  1->1*: c a b d e f g
2->0* 1->2 : c a b d e f g
2->0  1->2*: c a b d e f g
2->0* 1->3 : c a b d e f g
2->0  1->3*: c a b d e f g
2->0* 1->4 : c a d b e f g
2->0  1->4*: c a d b e f g
2->0* 1->5 : c a d e b f g
2->0  1->5*: c a d e b f g
2->0* 1->6 : c a d e f b g
2->0  1->6*: c a d e f b g
2->0* 1->7 : c a d e f g b
2->0  1->7*: c a d e f g b
2->0* 2->0 : c a b d e f g
2->0  2->0*: c a b d e f g
2->0* 2->1 : c a b d e f g
2->0  2->1*: a c b d e f g
2->0* 2->2 : c a b d e f g
2->0  2->2*: c a b d e f g
2->0* 2->3 : c a b d e f g
2->0  2->3*: c a b d e f g
2->0* 2->4 : c a b d e f g
2->0  2->4*: a b d c e f g
2->0* 2->5 : c a b d e f g
2->0  2->5*: a b d e c f g
2->0* 2->6 : c a b d e f g
2->0  2->6*: a b d e f c g
2->0* 2->7 : c a b d e f g
2->0  2->7*: a b d e f g c
2->0* 3->0 : c d a b e f g
2->0  3->0*: d c a b e f g
2->0* 3->1 : c a d b e f g
2->0  3->1*: c a d b e f g
2->0* 3->2 : c a b d e f g
2->0  3->2*: c a b d e f g
2->0* 3->3 : c a b d e f g
2->0  3->3*: c a b d e f g
2->0* 3->4 : c a b d e f g
2->0  3->4*: c a b d e f g
2->0* 3->5 : c a b e d f g
2->0  3->5*: c a b e d f g
2->0* 3->6 : c a b e f d g
2->0  3->6*: c a b e f d g
2->0* 3->7 : c a b e f g d
2->0  3->7*: c a b e f g d
2->0* 4->0 : c e a b d f g
2->0  4->0*: e c a b d f g
2->0* 4->1 : c a e b d f g
2->0  4->1*: c a e b d f g
2->0* 4->2 : c a b e d f g
2->0  4->2*: c a b e d f g
2->0* 4->3 : c a b e d f g
2->0  4->3*: c a b e d f g
2->0* 4->4 : c a b d e f g
2->0  4->4*: c a b d e f g
2->0* 4->5 : c a b d e f g
2->0  4->5*: c a b d e f g
2->0* 4->6 : c a b d f e g
2->0  4->6*: c a b d f e g
2->0* 4->7 : c a b d f g e
2->0  4->7*: c a b d f g e
2->0* 5->0 : c f a b d e g
2->0  5->0*: f c a b d e g
2->0* 5->1 : c a f b d e g
2->0  5->1*: c a f b d e g
2->0* 5->2 : c a b f d e g
2->0  5->2*: c a b f d e g
2->0* 5->3 : c a b f d e g
2->0  5->3*: c a b f d e g
2->0* 5->4 : c a b d f e g
2->0  5->4*: c a b d f e g
2->0* 5->5 : c a b d e f g
2->0  5->5*: c a b d e f g
2->0* 5->6 : c a b d e f g
2->0  5->6*: c a b d e f g
2->0* 5->7 : c a b d e g f
2->0  5->7*: c a b d e g f
2->0* 6->0 : c g a b d e f
2->0  6->0*: g c a b d e f
2->0* 6->1 : c a g b d e f
2->0  6->1*: c a g b d e f
2->0* 6->2 : c a b g d e f
2->0  6->2*: c a b g d e f
2->0* 6->3 : c a b g d e f
2->0  6->3*: c a b g d e f
2->0* 6->4 : c a b d g e f
2->0  6->4*: c a b d g e f
2->0* 6->5 : c a b d e g f
2->0  6->5*: c a b d e g f
2->0* 6->6 : c a b d e f g
2->0  6->6*: c a b d e f g
2->0* 6->7 : c a b d e f g
2->0  6->7*: c a b d e f g
2->1* 0->0 : a c b d e f g
2->1  0->0*: a c b d e f g
2->1* 0->1 : a c b d e f g
2->1  0->1*: a c b d e f g
2->1* 0->2 : c b a d e f g
2->1  0->2*: c b a d e f g
2->1* 0->3 : c b a d e f g
2->1  0->3*: c b a d e f g
2->1* 0->4 : c b d a e f g
2->1  0->4*: c b d a e f g
2->1* 0->5 : c b d e a f g
2->1  0->5*: c b d e a f g
2->1* 0->6 : c b d e f a g
2->1  0->6*: c b d e f a g
2->1* 0->7 : c b d e f g a
2->1  0->7*: c b d e f g a
2->1* 1->0 : b a c d e f g
2->1  1->0*: b a c d e f g
2->1* 1->1 : a c b d e f g
2->1  1->1*: a c b d e f g
2->1* 1->2 : a c b d e f g
2->1  1->2*: a c b d e f g
2->1* 1->3 : a c b d e f g
2->1  1->3*: a c b d e f g
2->1* 1->4 : a c d b e f g
2->1  1->4*: a c d b e f g
2->1* 1->5 : a c d e b f g
2->1  1->5*: a c d e b f g
2->1* 1->6 : a c d e f b g
2->1  1->6*: a c d e f b g
2->1* 1->7 : a c d e f g b
2->1  1->7*: a c d e f g b
2->1* 2->0 : a c b d e f g
2->1  2->0*: c a b d e f g
2->1* 2->1 : a c b d e f g
2->1  2->1*: a c b d e f g
2->1* 2->2 : a c b d e f g
2->1  2->2*: a c b d e f g
2->1* 2->3 : a c b d e f g
2->1  2->3*: a c b d e f g
2->1* 2->4 : a c b d e f g
2->1  2->4*: a b d c e f g
2->1* 2->5 : a c b d e f g
2->1  2->5*: a b d e c f g
2->1* 2->6 : a c b d e f g
2->1  2->6*: a b d e f c g
2->1* 2->7 : a c b d e f g
2->1  2->7*: a b d e f g c
2->1* 3->0 : d a c b e f g
2->1  3->0*: d a c b e f g
2->1* 3->1 : a c d b e f g
2->1  3->1*: a d c b e f g
2->1* 3->2 : a c b d e f g
2->1  3->2*: a c b d e f g
2->1* 3->3 : a c b d e f g
2->1  3->3*: a c b d e f g
2->1* 3->4 : a c b d e f g
2->1  3->4*: a c b d e f g
2->1* 3->5 : a c b e d f g
2->1  3->5*: a c b e d f g
2->1* 3->6 : a c b e f d g
2->1  3->6*: a c b e f d g
2->1* 3->7 : a c b e f g d
2->1  3->7*: a c b e f g d
2->1* 4->0 : e a c b d f g
2->1  4->0*: e a c b d f g
2->1* 4->1 : a c e b d f g
2->1  4->1*: a e c b d f g
2->1* 4->2 : a c b e d f g
2->1  4->2*: a c b e d f g
2->1* 4->3 : a c b e d f g
2->1  4->3*: a c b e d f g
2->1* 4->4 : a c b d e f g
2->1  4->4*: a c b d e f g
2->1* 4->5 : a c b d e f g
2->1  4->5*: a c b d e f g
2->1* 4->6 : a c b d f e g
2->1  4->6*: a c b d f e g
2->1* 4->7 : a c b d f g e
2->1  4->7*: a c b d f g e
2->1* 5->0 : f a c b d e g
2->1  5->0*: f a c b d e g
2->1* 5->1 : a c f b d e g
2->1  5->1*: a f c b d e g
2->1* 5->2 : a c b f d e g
2->1  5->2*: a c b f d e g
2->1* 5->3 : a c b f d e g
2->1  5->3*: a c b f d e g
2->1* 5->4 : a c b d f e g
2->1  5->4*: a c b d f e g
2->1* 5->5 : a c b d e f g
2->1  5->5*: a c b d e f g
2->1* 5->6 : a c b d e f g
2->1  5->6*: a c b d e f g
2->1* 5->7 : a c b d e g f
2->1  5->7*: a c b d e g f
2->1* 6->0 : g a c b d e f
2->1  6->0*: g a c b d e f
2->1* 6->1 : a c g b d e f
2->1  6->1*: a g c b d e f
2->1* 6->2 : a c b g d e f
2->1  6->2*: a c b g d e f
2->1* 6->3 : a c b g d e f
2->1  6->3*: a c b g d e f
2->1* 6->4 : a c b d g e f
2->1  6->4*: a c b d g e f
2->1* 6->5 : a c b d e g f
2->1  6->5*: a c b d e g f
2->1* 6->6 : a c b d e f g
2->1  6->6*: a c b d e f g
2->1* 6->7 : a c b d e f g
2->1  6->7*: a c b d e f g
2->2* 0->0 : a b c d e f g
2->2  0->0*: a b c d e f g
2->2* 0->1 : a b c d e f g
2->2  0->1*: a b c d e f g
2->2* 0->2 : b a c d e f g
2->2  0->2*: b a c d e f g
2->2* 0->3 : b c a d e f g
2->2  0->3*: b c a d e f g
2->2* 0->4 : b c d a e f g
2->2  0->4*: b c d a e f g
2->2* 0->5 : b c d e a f g
2->2  0->5*: b c d e a f g
2->2* 0->6 : b c d e f a g
2->2  0->6*: b c d e f a g
2->2* 0->7 : b c d e f g a
2->2  0->7*: b c d e f g a
2->2* 1->0 : b a c d e f g
2->2  1->0*: b a c d e f g
2->2* 1->1 : a b c d e f g
2->2  1->1*: a b c d e f g
2->2* 1->2 : a b c d e f g
2->2  1->2*: a b c d e f g
2->2* 1->3 : a c b d e f g
2->2  1->3*: a c b d e f g
2->2* 1->4 : a c d b e f g
2->2  1->4*: a c d b e f g
2->2* 1->5 : a c d e b f g
2->2  1->5*: a c d e b f g
2->2* 1->6 : a c d e f b g
2->2  1->6*: a c d e f b g
2->2* 1->7 : a c d e f g b
2->2  1->7*: a c d e f g b
2->2* 2->0 : c a b d e f g
2->2  2->0*: c a b d e f g
2->2* 2->1 : a c b d e f g
2->2  2->1*: a c b d e f g
2->2* 2->2 : a b c d e f g
2->2  2->2*: a b c d e f g
2->2* 2->3 : a b c d e f g
2->2  2->3*: a b c d e f g
2->2* 2->4 : a b d c e f g
2->2  2->4*: a b d c e f g
2->2* 2->5 : a b d e c f g
2->2  2->5*: a b d e c f g
2->2* 2->6 : a b d e f c g
2->2  2->6*: a b d e f c g
2->2* 2->7 : a b d e f g c
2->2  2->7*: a b d e f g c
2->2* 3->0 : d a b c e f g
2->2  3->0*: d a b c e f g
2->2* 3->1 : a d b c e f g
2->2  3->1*: a d b c e f g
2->2* 3->2 : a b d c e f g
2->2  3->2*: a b d c e f g
2->2* 3->3 : a b c d e f g
2->2  3->3*: a b c d e f g
2->2* 3->4 : a b c d e f g
2->2  3->4*: a b c d e f g
2->2* 3->5 : a b c e d f g
2->2  3->5*: a b c e d f g
2->2* 3->6 : a b c e f d g
2->2  3->6*: a b c e f d g
2->2* 3->7 : a b c e f g d
2->2  3->7*: a b c e f g d
2->2* 4->0 : e a b c d f g
2->2  4->0*: e a b c d f g
2->2* 4->1 : a e b c d f g
2->2  4->1*: a e b c d f g
2->2* 4->2 : a b e c d f g
2->2  4->2*: a b e c d f g
2->2* 4->3 : a b c e d f g
2->2  4->3*: a b c e d f g
2->2* 4->4 : a b c d e f g
2->2  4->4*: a b c d e f g
2->2* 4->5 : a b c d e f g
2->2  4->5*: a b c d e f g
2->2* 4->6 : a b c d f e g
2->2  4->6*: a b c d f e g
2->2* 4->7 : a b c d f g e
2->2  4->7*: a b c d f g e
2->2* 5->0 : f a b c d e g
2->2  5->0*: f a b c d e g
2->2* 5->1 : a f b c d e g
2->2  5->1*: a f b c d e g
2->2* 5->2 : a b f c d e g
2->2  5->2*: a b f c d e g
2->2* 5->3 : a b c f d e g
2->2  5->3*: a b c f d e g
2->2* 5->4 : a b c d f e g
2->2  5->4*: a b c d f e g
2->2* 5->5 : a b c d e f g
2->2  5->5*: a b c d e f g
2->2* 5->6 : a b c d e f g
2->2  5->6*: a b c d e f g
2->2* 5->7 : a b c d e g f
2->2  5->7*: a b c d e g f
2->2* 6->0 : g a b c d e f
2->2  6->0*: g a b c d e f
2->2* 6->1 : a g b c d e f
2->2  6->1*: a g b c d e f
2->2* 6->2 : a b g c d e f
2->2  6->2*: a b g c d e f
2->2* 6->3 : a b c g d e f
2->2  6->3*: a b c g d e f
2->2* 6->4 : a b c d g e f
2->2  6->4*: a b c d g e f
2->2* 6->5 : a b c d e g f
2->2  6->5*: a b c d e g f
2->2* 6->6 : a b c d e f g
2->2  6->6*: a b c d e f g
2->2* 6->7 : a b c d e f g
2->2  6->7*: a b c d e f g
2->3* 0->0 : a b c d e f g
2->3  0->0*: a b c d e f g
2->3* 0->1 : a b c d e f g
2->3  0->1*: a b c d e f g
2->3* 0->2 : b a c d e f g
2->3  0->2*: b a c d e f g
2->3* 0->3 : b c a d e f g
2->3  0->3*: b c a d e f g
2->3* 0->4 : b c d a e f g
2->3  0->4*: b c d a e f g
2->3* 0->5 : b c d e a f g
2->3  0->5*: b c d e a f g
2->3* 0->6 : b c d e f a g
2->3  0->6*: b c d e f a g
2->3* 0->7 : b c d e f g a
2->3  0->7*: b c d e f g a
2->3* 1->0 : b a c d e f g
2->3  1->0*: b a c d e f g
2->3* 1->1 : a b c d e f g
2->3  1->1*: a b c d e f g
2->3* 1->2 : a b c d e f g
2->3  1->2*: a b c d e f g
2->3* 1->3 : a c b d e f g
2->3  1->3*: a c b d e f g
2->3* 1->4 : a c d b e f g
2->3  1->4*: a c d b e f g
2->3* 1->5 : a c d e b f g
2->3  1->5*: a c d e b f g
2->3* 1->6 : a c d e f b g
2->3  1->6*: a c d e f b g
2->3* 1->7 : a c d e f g b
2->3  1->7*: a c d e f g b
2->3* 2->0 : c a b d e f g
2->3  2->0*: c a b d e f g
2->3* 2->1 : a c b d e f g
2->3  2->1*: a c b d e f g
2->3* 2->2 : a b c d e f g
2->3  2->2*: a b c d e f g
2->3* 2->3 : a b c d e f g
2->3  2->3*: a b c d e f g
2->3* 2->4 : a b d c e f g
2->3  2->4*: a b d c e f g
2->3* 2->5 : a b d e c f g
2->3  2->5*: a b d e c f g
2->3* 2->6 : a b d e f c g
2->3  2->6*: a b d e f c g
2->3* 2->7 : a b d e f g c
2->3  2->7*: a b d e f g c
2->3* 3->0 : d a b c e f g
2->3  3->0*: d a b c e f g
2->3* 3->1 : a d b c e f g
2->3  3->1*: a d b c e f g
2->3* 3->2 : a b d c e f g
2->3  3->2*: a b d c e f g
2->3* 3->3 : a b c d e f g
2->3  3->3*: a b c d e f g
2->3* 3->4 : a b c d e f g
2->3  3->4*: a b c d e f g
2->3* 3->5 : a b c e d f g
2->3  3->5*: a b c e d f g
2->3* 3->6 : a b c e f d g
2->3  3->6*: a b c e f d g
2->3* 3->7 : a b c e f g d
2->3  3->7*: a b c e f g d
2->3* 4->0 : e a b c d f g
2->3  4->0*: e a b c d f g
2->3* 4->1 : a e b c d f g
2->3  4->1*: a e b c d f g
2->3* 4->2 : a b e c d f g
2->3  4->2*: a b e c d f g
2->3* 4->3 : a b c e d f g
2->3  4->3*: a b c e d f g
2->3* 4->4 : a b c d e f g
2->3  4->4*: a b c d e f g
2->3* 4->5 : a b c d e f g
2->3  4->5*: a b c d e f g
2->3* 4->6 : a b c d f e g
2->3  4->6*: a b c d f e g
2->3* 4->7 : a b c d f g e
2->3  4->7*: a b c d f g e
2->3* 5->0 : f a b c d e g
2->3  5->0*: f a b c d e g
2->3* 5->1 : a f b c d e g
2->3  5->1*: a f b c d e g
2->3* 5->2 : a b f c d e g
2->3  5->2*: a b f c d e g
2->3* 5->3 : a b c f d e g
2->3  5->3*: a b c f d e g
2->3* 5->4 : a b c d f e g
2->3  5->4*: a b c d f e g
2->3* 5->5 : a b c d e f g
2->3  5->5*: a b c d e f g
2->3* 5->6 : a b c d e f g
2->3  5->6*: a b c d e f g
2->3* 5->7 : a b c d e g f
2->3  5->7*: a b c d e g f
2->3* 6->0 : g a b c d e f
2->3  6->0*: g a b c d e f
2->3* 6->1 : a g b c d e f
2->3  6->1*: a g b c d e f
2->3* 6->2 : a b g c d e f
2->3  6->2*: a b g c d e f
2->3* 6->3 : a b c g d e f
2->3  6->3*: a b c g d e f
2->3* 6->4 : a b c d g e f
2->3  6->4*: a b c d g e f
2->3* 6->5 : a b c d e g f
2->3  6->5*: a b c d e g f
2->3* 6->6 : a b c d e f g
2->3  6->6*: a b c d e f g
2->3* 6->7 : a b c d e f g
2->3  6->7*: a b c d e f g
2->4* 0->0 : a b d c e f g
2->4  0->0*: a b d c e f g
2->4* 0->1 : a b d c e f g
2->4  0->1*: a b d c e f g
2->4* 0->2 : b a d c e f g
2->4  0->2*: b a d c e f g
2->4* 0->3 : b a d c e f g
2->4  0->3*: b a d c e f g
2->4* 0->4 : b d c a e f g
2->4  0->4*: b d a c e f g
2->4* 0->5 : b d c e a f g
2->4  0->5*: b d c e a f g
2->4* 0->6 : b d c e f a g
2->4  0->6*: b d c e f a g
2->4* 0->7 : b d c e f g a
2->4  0->7*: b d c e f g a
2->4* 1->0 : b a d c e f g
2->4  1->0*: b a d c e f g
2->4* 1->1 : a b d c e f g
2->4  1->1*: a b d c e f g
2->4* 1->2 : a b d c e f g
2->4  1->2*: a b d c e f g
2->4* 1->3 : a b d c e f g
2->4  1->3*: a b d c e f g
2->4* 1->4 : a d c b e f g
2->4  1->4*: a d b c e f g
2->4* 1->5 : a d c e b f g
2->4  1->5*: a d c e b f g
2->4* 1->6 : a d c e f b g
2->4  1->6*: a d c e f b g
2->4* 1->7 : a d c e f g b
2->4  1->7*: a d c e f g b
2->4* 2->0 : a b d c e f g
2->4  2->0*: c a b d e f g
2->4* 2->1 : a b d c e f g
2->4  2->1*: a c b d e f g
2->4* 2->2 : a b d c e f g
2->4  2->2*: a b d c e f g
2->4* 2->3 : a b d c e f g
2->4  2->3*: a b d c e f g
2->4* 2->4 : a b d c e f g
2->4  2->4*: a b d c e f g
2->4* 2->5 : a b d c e f g
2->4  2->5*: a b d e c f g
2->4* 2->6 : a b d c e f g
2->4  2->6*: a b d e f c g
2->4* 2->7 : a b d c e f g
2->4  2->7*: a b d e f g c
2->4* 3->0 : d a b c e f g
2->4  3->0*: d a b c e f g
2->4* 3->1 : a d b c e f g
2->4  3->1*: a d b c e f g
2->4* 3->2 : a b d c e f g
2->4  3->2*: a b d c e f g
2->4* 3->3 : a b d c e f g
2->4  3->3*: a b d c e f g
2->4* 3->4 : a b d c e f g
2->4  3->4*: a b d c e f g
2->4* 3->5 : a b c e d f g
2->4  3->5*: a b c e d f g
2->4* 3->6 : a b c e f d g
2->4  3->6*: a b c e f d g
2->4* 3->7 : a b c e f g d
2->4  3->7*: a b c e f g d
2->4* 4->0 : e a b d c f g
2->4  4->0*: e a b d c f g
2->4* 4->1 : a e b d c f g
2->4  4->1*: a e b d c f g
2->4* 4->2 : a b e d c f g
2->4  4->2*: a b e d c f g
2->4* 4->3 : a b e d c f g
2->4  4->3*: a b e d c f g
2->4* 4->4 : a b d c e f g
2->4  4->4*: a b d c e f g
2->4* 4->5 : a b d c e f g
2->4  4->5*: a b d c e f g
2->4* 4->6 : a b d c f e g
2->4  4->6*: a b d c f e g
2->4* 4->7 : a b d c f g e
2->4  4->7*: a b d c f g e
2->4* 5->0 : f a b d c e g
2->4  5->0*: f a b d c e g
2->4* 5->1 : a f b d c e g
2->4  5->1*: a f b d c e g
2->4* 5->2 : a b f d c e g
2->4  5->2*: a b f d c e g
2->4* 5->3 : a b f d c e g
2->4  5->3*: a b f d c e g
2->4* 5->4 : a b d c f e g
2->4  5->4*: a b d f c e g
2->4* 5->5 : a b d c e f g
2->4  5->5*: a b d c e f g
2->4* 5->6 : a b d c e f g
2->4  5->6*: a b d c e f g
2->4* 5->7 : a b d c e g f
2->4  5->7*: a b d c e g f
2->4* 6->0 : g a b d c e f
2->4  6->0*: g a b d c e f
2->4* 6->1 : a g b d c e f
2->4  6->1*: a g b d c e f
2->4* 6->2 : a b g d c e f
2->4  6->2*: a b g d c e f
2->4* 6->3 : a b g d c e f
2->4  6->3*: a b g d c e f
2->4* 6->4 : a b d c g e f
2->4  6->4*: a b d g c e f
2->4* 6->5 : a b d c e g f
2->4  6->5*: a b d c e g f
2->4* 6->6 : a b d c e f g
2->4  6->6*: a b d c e f g
2->4* 6->7 : a b d c e f g
2->4  6->7*: a b d c e f g
2->5* 0->0 : a b d e c f g
2->5  0->0*: a b d e c f g
2->5* 0->1 : a b d e c f g
2->5  0->1*: a b d e c f g
2->5* 0->2 : b a d e c f g
2->5  0->2*: b a d e c f g
2->5* 0->3 : b a d e c f g
2->5  0->3*: b a d e c f g
2->5* 0->4 : b d a e c f g
2->5  0->4*: b d a e c f g
2->5* 0->5 : b d e c a f g
2->5  0->5*: b d e a c f g
2->5* 0->6 : b d e c f a g
2->5  0->6*: b d e c f a g
2->5* 0->7 : b d e c f g a
2->5  0->7*: b d e c f g a
2->5* 1->0 : b a d e c f g
2->5  1->0*: b a d e c f g
2->5* 1->1 : a b d e c f g
2->5  1->1*: a b d e c f g
2->5* 1->2 : a b d e c f g
2->5  1->2*: a b d e c f g
2->5* 1->3 : a b d e c f g
2->5  1->3*: a b d e c f g
2->5* 1->4 : a d b e c f g
2->5  1->4*: a d b e c f g
2->5* 1->5 : a d e c b f g
2->5  1->5*: a d e b c f g
2->5* 1->6 : a d e c f b g
2->5  1->6*: a d e c f b g
2->5* 1->7 : a d e c f g b
2->5  1->7*: a d e c f g b
2->5* 2->0 : a b d e c f g
2->5  2->0*: c a b d e f g
2->5* 2->1 : a b d e c f g
2->5  2->1*: a c b d e f g
2->5* 2->2 : a b d e c f g
2->5  2->2*: a b d e c f g
2->5* 2->3 : a b d e c f g
2->5  2->3*: a b d e c f g
2->5* 2->4 : a b d e c f g
2->5  2->4*: a b d c e f g
2->5* 2->5 : a b d e c f g
2->5  2->5*: a b d e c f g
2->5* 2->6 : a b d e c f g
2->5  2->6*: a b d e f c g
2->5* 2->7 : a b d e c f g
2->5  2->7*: a b d e f g c
2->5* 3->0 : d a b e c f g
2->5  3->0*: d a b e c f g
2->5* 3->1 : a d b e c f g
2->5  3->1*: a d b e c f g
2->5* 3->2 : a b d e c f g
2->5  3->2*: a b d e c f g
2->5* 3->3 : a b d e c f g
2->5  3->3*: a b d e c f g
2->5* 3->4 : a b d e c f g
2->5  3->4*: a b d e c f g
2->5* 3->5 : a b e c d f g
2->5  3->5*: a b e d c f g
2->5* 3->6 : a b e c f d g
2->5  3->6*: a b e c f d g
2->5* 3->7 : a b e c f g d
2->5  3->7*: a b e c f g d
2->5* 4->0 : e a b d c f g
2->5  4->0*: e a b d c f g
2->5* 4->1 : a e b d c f g
2->5  4->1*: a e b d c f g
2->5* 4->2 : a b e d c f g
2->5  4->2*: a b e d c f g
2->5* 4->3 : a b e d c f g
2->5  4->3*: a b e d c f g
2->5* 4->4 : a b d e c f g
2->5  4->4*: a b d e c f g
2->5* 4->5 : a b d e c f g
2->5  4->5*: a b d e c f g
2->5* 4->6 : a b d c f e g
2->5  4->6*: a b d c f e g
2->5* 4->7 : a b d c f g e
2->5  4->7*: a b d c f g e
2->5* 5->0 : f a b d e c g
2->5  5->0*: f a b d e c g
2->5* 5->1 : a f b d e c g
2->5  5->1*: a f b d e c g
2->5* 5->2 : a b f d e c g
2->5  5->2*: a b f d e c g
2->5* 5->3 : a b f d e c g
2->5  5->3*: a b f d e c g
2->5* 5->4 : a b d f e c g
2->5  5->4*: a b d f e c g
2->5* 5->5 : a b d e c f g
2->5  5->5*: a b d e c f g
2->5* 5->6 : a b d e c f g
2->5  5->6*: a b d e c f g
2->5* 5->7 : a b d e c g f
2->5  5->7*: a b d e c g f
2->5* 6->0 : g a b d e c f
2->5  6->0*: g a b d e c f
2->5* 6->1 : a g b d e c f
2->5  6->1*: a g b d e c f
2->5* 6->2 : a b g d e c f
2->5  6->2*: a b g d e c f
2->5* 6->3 : a b g d e c f
2->5  6->3*: a b g d e c f
2->5* 6->4 : a b d g e c f
2->5  6->4*: a b d g e c f
2->5* 6->5 : a b d e c g f
2->5  6->5*: a b d e g c f
2->5* 6->6 : a b d e c f g
2->5  6->6*: a b d e c f g
2->5* 6->7 : a b d e c f g
2->5  6->7*: a b d e c f g
2->6* 0->0 : a b d e f c g
2->6  0->0*: a b d e f c g
2->6* 0->1 : a b d e f c g
2->6  0->1*: a b d e f c g
2->6* 0->2 : b a d e f c g
2->6  0->2*: b a d e f c g
2->6* 0->3 : b a d e f c g
2->6  0->3*: b a d e f c g
2->6* 0->4 : b d a e f c g
2->6  0->4*: b d a e f c g
2->6* 0->5 : b d e a f c g
2->6  0->5*: b d e a f c g
2->6* 0->6 : b d e f c a g
2->6  0->6*: b d e f a c g
2->6* 0->7 : b d e f c g a
2->6  0->7*: b d e f c g a
2->6* 1->0 : b a d e f c g
2->6  1->0*: b a d e f c g
2->6* 1->1 : a b d e f c g
2->6  1->1*: a b d e f c g
2->6* 1->2 : a b d e f c g
2->6  1->2*: a b d e f c g
2->6* 1->3 : a b d e f c g
2->6  1->3*: a b d e f c g
2->6* 1->4 : a d b e f c g
2->6  1->4*: a d b e f c g
2->6* 1->5 : a d e b f c g
2->6  1->5*: a d e b f c g
2->6* 1->6 : a d e f c b g
2->6  1->6*: a d e f b c g
2->6* 1->7 : a d e f c g b
2->6  1->7*: a d e f c g b
2->6* 2->0 : a b d e f c g
2->6  2->0*: c a b d e f g
2->6* 2->1 : a b d e f c g
2->6  2->1*: a c b d e f g
2->6* 2->2 : a b d e f c g
2->6  2->2*: a b d e f c g
2->6* 2->3 : a b d e f c g
2->6  2->3*: a b d e f c g
2->6* 2->4 : a b d e f c g
2->6  2->4*: a b d c e f g
2->6* 2->5 : a b d e f c g
2->6  2->5*: a b d e c f g
2->6* 2->6 : a b d e f c g
2->6  2->6*: a b d e f c g
2->6* 2->7 : a b d e f c g
2->6  2->7*: a b d e f g c
2->6* 3->0 : d a b e f c g
2->6  3->0*: d a b e f c g
2->6* 3->1 : a d b e f c g
2->6  3->1*: a d b e f c g
2->6* 3->2 : a b d e f c g
2->6  3->2*: a b d e f c g
2->6* 3->3 : a b d e f c g
2->6  3->3*: a b d e f c g
2->6* 3->4 : a b d e f c g
2->6  3->4*: a b d e f c g
2->6* 3->5 : a b e d f c g
2->6  3->5*: a b e d f c g
2->6* 3->6 : a b e f c d g
2->6  3->6*: a b e f d c g
2->6* 3->7 : a b e f c g d
2->6  3->7*: a b e f c g d
2->6* 4->0 : e a b d f c g
2->6  4->0*: e a b d f c g
2->6* 4->1 : a e b d f c g
2->6  4->1*: a e b d f c g
2->6* 4->2 : a b e d f c g
2->6  4->2*: a b e d f c g
2->6* 4->3 : a b e d f c g
2->6  4->3*: a b e d f c g
2->6* 4->4 : a b d e f c g
2->6  4->4*: a b d e f c g
2->6* 4->5 : a b d e f c g
2->6  4->5*: a b d e f c g
2->6* 4->6 : a b d f c e g
2->6  4->6*: a b d f e c g
2->6* 4->7 : a b d f c g e
2->6  4->7*: a b d f c g e
2->6* 5->0 : f a b d e c g
2->6  5->0*: f a b d e c g
2->6* 5->1 : a f b d e c g
2->6  5->1*: a f b d e c g
2->6* 5->2 : a b f d e c g
2->6  5->2*: a b f d e c g
2->6* 5->3 : a b f d e c g
2->6  5->3*: a b f d e c g
2->6* 5->4 : a b d f e c g
2->6  5->4*: a b d f e c g
2->6* 5->5 : a b d e f c g
2->6  5->5*: a b d e f c g
2->6* 5->6 : a b d e f c g
2->6  5->6*: a b d e f c g
2->6* 5->7 : a b d e c g f
2->6  5->7*: a b d e c g f
2->6* 6->0 : g a b d e f c
2->6  6->0*: g a b d e f c
2->6* 6->1 : a g b d e f c
2->6  6->1*: a g b d e f c
2->6* 6->2 : a b g d e f c
2->6  6->2*: a b g d e f c
2->6* 6->3 : a b g d e f c
2->6  6->3*: a b g d e f c
2->6* 6->4 : a b d g e f c
2->6  6->4*: a b d g e f c
2->6* 6->5 : a b d e g f c
2->6  6->5*: a b d e g f c
2->6* 6->6 : a b d e f c g
2->6  6->6*: a b d e f c g
2->6* 6->7 : a b d e f c g
2->6  6->7*: a b d e f c g
2->7* 0->0 : a b d e f g c
2->7  0->0*: a b d e f g c
2->7* 0->1 : a b d e f g c
2->7  0->1*: a b d e f g c
2->7* 0->2 : b a d e f g c
2->7  0->2*: b a d e f g c
2->7* 0->3 : b a d e f g c
2->7  0->3*: b a d e f g c
2->7* 0->4 : b d a e f g c
2->7  0->4*: b d a e f g c
2->7* 0->5 : b d e a f g c
2->7  0->5*: b d e a f g c
2->7* 0->6 : b d e f a g c
2->7  0->6*: b d e f a g c
2->7* 0->7 : b d e f g c a
2->7  0->7*: b d e f g a c
2->7* 1->0 : b a d e f g c
2->7  1->0*: b a d e f g c
2->7* 1->1 : a b d e f g c
2->7  1->1*: a b d e f g c
2->7* 1->2 : a b d e f g c
2->7  1->2*: a b d e f g c
2->7* 1->3 : a b d e f g c
2->7  1->3*: a b d e f g c
2->7* 1->4 : a d b e f g c
2->7  1->4*: a d b e f g c
2->7* 1->5 : a d e b f g c
2->7  1->5*: a d e b f g c
2->7* 1->6 : a d e f b g c
2->7  1->6*: a d e f b g c
2->7* 1->7 : a d e f g c b
2->7  1->7*: a d e f g b c
2->7* 2->0 : a b d e f g c
2->7  2->0*: c a b d e f g
2->7* 2->1 : a b d e f g c
2->7  2->1*: a c b d e f g
2->7* 2->2 : a b d e f g c
2->7  2->2*: a b d e f g c
2->7* 2->3 : a b d e f g c
2->7  2->3*: a b d e f g c
2->7* 2->4 : a b d e f g c
2->7  2->4*: a b d c e f g
2->7* 2->5 : a b d e f g c
2->7  2->5*: a b d e c f g
2->7* 2->6 : a b d e f g c
2->7  2->6*: a b d e f c g
2->7* 2->7 : a b d e f g c
2->7  2->7*: a b d e f g c
2->7* 3->0 : d a b e f g c
2->7  3->0*: d a b e f g c
2->7* 3->1 : a d b e f g c
2->7  3->1*: a d b e f g c
2->7* 3->2 : a b d e f g c
2->7  3->2*: a b d e f g c
2->7* 3->3 : a b d e f g c
2->7  3->3*: a b d e f g c
2->7* 3->4 : a b d e f g c
2->7  3->4*: a b d e f g c
2->7* 3->5 : a b e d f g c
2->7  3->5*: a b e d f g c
2->7* 3->6 : a b e f d g c
2->7  3->6*: a b e f d g c
2->7* 3->7 : a b e f g c d
2->7  3->7*: a b e f g d c
2->7* 4->0 : e a b d f g c
2->7  4->0*: e a b d f g c
2->7* 4->1 : a e b d f g c
2->7  4->1*: a e b d f g c
2->7* 4->2 : a b e d f g c
2->7  4->2*: a b e d f g c
2->7* 4->3 : a b e d f g c
2->7  4->3*: a b e d f g c
2->7* 4->4 : a b d e f g c
2->7  4->4*: a b d e f g c
2->7* 4->5 : a b d e f g c
2->7  4->5*: a b d e f g c
2->7* 4->6 : a b d f e g c
2->7  4->6*: a b d f e g c
2->7* 4->7 : a b d f g c e
2->7  4->7*: a b d f g e c
2->7* 5->0 : f a b d e g c
2->7  5->0*: f a b d e g c
2->7* 5->1 : a f b d e g c
2->7  5->1*: a f b d e g c
2->7* 5->2 : a b f d e g c
2->7  5->2*: a b f d e g c
2->7* 5->3 : a b f d e g c
2->7  5->3*: a b f d e g c
2->7* 5->4 : a b d f e g c
2->7  5->4*: a b d f e g c
2->7* 5->5 : a b d e f g c
2->7  5->5*: a b d e f g c
2->7* 5->6 : a b d e f g c
2->7  5->6*: a b d e f g c
2->7* 5->7 : a b d e g c f
2->7  5->7*: a b d e g f c
2->7* 6->0 : g a b d e f c
2->7  6->0*: g a b d e f c
2->7* 6->1 : a g b d e f c
2->7  6->1*: a g b d e f c
2->7* 6->2 : a b g d e f c
2->7  6->2*: a b g d e f c
2->7* 6->3 : a b g d e f c
2->7  6->3*: a b g d e f c
2->7* 6->4 : a b d g e f c
2->7  6->4*: a b d g e f c
2->7* 6->5 : a b d e g f c
2->7  6->5*: a b d e g f c
2->7* 6->6 : a b d e f g c
2->7  6->6*: a b d e f g c
2->7* 6->7 : a b d e f g c
2->7  6->7*: a b d e f g c
3->0* 0->0 : d a b c e f g
3->0  0->0*: d a b c e f g
3->0* 0->1 : d a b c e f g
3->0  0->1*: d a b c e f g
3->0* 0->2 : d b a c e f g
3->0  0->2*: d b a c e f g
3->0* 0->3 : d b c a e f g
3->0  0->3*: d b c a e f g
3->0* 0->4 : d b c a e f g
3->0  0->4*: d b c a e f g
3->0* 0->5 : d b c e a f g
3->0  0->5*: d b c e a f g
3->0* 0->6 : d b c e f a g
3->0  0->6*: d b c e f a g
3->0* 0->7 : d b c e f g a
3->0  0->7*: d b c e f g a
3->0* 1->0 : d b a c e f g
3->0  1->0*: b d a c e f g
3->0* 1->1 : d a b c e f g
3->0  1->1*: d a b c e f g
3->0* 1->2 : d a b c e f g
3->0  1->2*: d a b c e f g
3->0* 1->3 : d a c b e f g
3->0  1->3*: d a c b e f g
3->0* 1->4 : d a c b e f g
3->0  1->4*: d a c b e f g
3->0* 1->5 : d a c e b f g
3->0  1->5*: d a c e b f g
3->0* 1->6 : d a c e f b g
3->0  1->6*: d a c e f b g
3->0* 1->7 : d a c e f g b
3->0  1->7*: d a c e f g b
3->0* 2->0 : d c a b e f g
3->0  2->0*: c d a b e f g
3->0* 2->1 : d a c b e f g
3->0  2->1*: d a c b e f g
3->0* 2->2 : d a b c e f g
3->0  2->2*: d a b c e f g
3->0* 2->3 : d a b c e f g
3->0  2->3*: d a b c e f g
3->0* 2->4 : d a b c e f g
3->0  2->4*: d a b c e f g
3->0* 2->5 : d a b e c f g
3->0  2->5*: d a b e c f g
3->0* 2->6 : d a b e f c g
3->0  2->6*: d a b e f c g
3->0* 2->7 : d a b e f g c
3->0  2->7*: d a b e f g c
3->0* 3->0 : d a b c e f g
3->0  3->0*: d a b c e f g
3->0* 3->1 : d a b c e f g
3->0  3->1*: a d b c e f g
3->0* 3->2 : d a b c e f g
3->0  3->2*: a b d c e f g
3->0* 3->3 : d a b c e f g
3->0  3->3*: d a b c e f g
3->0* 3->4 : d a b c e f g
3->0  3->4*: d a b c e f g
3->0* 3->5 : d a b c e f g
3->0  3->5*: a b c e d f g
3->0* 3->6 : d a b c e f g
3->0  3->6*: a b c e f d g
3->0* 3->7 : d a b c e f g
3->0  3->7*: a b c e f g d
3->0* 4->0 : d e a b c f g
3->0  4->0*: e d a b c f g
3->0* 4->1 : d a e b c f g
3->0  4->1*: d a e b c f g
3->0* 4->2 : d a b e c f g
3->0  4->2*: d a b e c f g
3->0* 4->3 : d a b c e f g
3->0  4->3*: d a b c e f g
3->0* 4->4 : d a b c e f g
3->0  4->4*: d a b c e f g
3->0* 4->5 : d a b c e f g
3->0  4->5*: d a b c e f g
3->0* 4->6 : d a b c f e g
3->0  4->6*: d a b c f e g
3->0* 4->7 : d a b c f g e
3->0  4->7*: d a b c f g e
3->0* 5->0 : d f a b c e g
3->0  5->0*: f d a b c e g
3->0* 5->1 : d a f b c e g
3->0  5->1*: d a f b c e g
3->0* 5->2 : d a b f c e g
3->0  5->2*: d a b f c e g
3->0* 5->3 : d a b c f e g
3->0  5->3*: d a b c f e g
3->0* 5->4 : d a b c f e g
3->0  5->4*: d a b c f e g
3->0* 5->5 : d a b c e f g
3->0  5->5*: d a b c e f g
3->0* 5->6 : d a b c e f g
3->0  5->6*: d a b c e f g
3->0* 5->7 : d a b c e g f
3->0  5->7*: d a b c e g f
3->0* 6->0 : d g a b c e f
3->0  6->0*: g d a b c e f
3->0* 6->1 : d a g b c e f
3->0  6->1*: d a g b c e f
3->0* 6->2 : d a b g c e f
3->0  6->2*: d a b g c e f
3->0* 6->3 : d a b c g e f
3->0  6->3*: d a b c g e f
3->0* 6->4 : d a b c g e f
3->0  6->4*: d a b c g e f
3->0* 6->5 : d a b c e g f
3->0  6->5*: d a b c e g f
3->0* 6->6 : d a b c e f g
3->0  6->6*: d a b c e f g
3->0* 6->7 : d a b c e f g
3->0  6->7*: d a b c e f g
3->1* 0->0 : a d b c e f g
3->1  0->0*: a d b c e f g
3->1* 0->1 : a d b c e f g
3->1  0->1*: a d b c e f g
3->1* 0->2 : d b a c e f g
3->1  0->2*: d b a c e f g
3->1* 0->3 : d b c a e f g
3->1  0->3*: d b c a e f g
3->1* 0->4 : d b c a e f g
3->1  0->4*: d b c a e f g
3->1* 0->5 : d b c e a f g
3->1  0->5*: d b c e a f g
3->1* 0->6 : d b c e f a g
3->1  0->6*: d b c e f a g
3->1* 0->7 : d b c e f g a
3->1  0->7*: d b c e f g a
3->1* 1->0 : b a d c e f g
3->1  1->0*: b a d c e f g
3->1* 1->1 : a d b c e f g
3->1  1->1*: a d b c e f g
3->1* 1->2 : a d b c e f g
3->1  1->2*: a d b c e f g
3->1* 1->3 : a d c b e f g
3->1  1->3*: a d c b e f g
3->1* 1->4 : a d c b e f g
3->1  1->4*: a d c b e f g
3->1* 1->5 : a d c e b f g
3->1  1->5*: a d c e b f g
3->1* 1->6 : a d c e f b g
3->1  1->6*: a d c e f b g
3->1* 1->7 : a d c e f g b
3->1  1->7*: a d c e f g b
3->1* 2->0 : c a d b e f g
3->1  2->0*: c a d b e f g
3->1* 2->1 : a d c b e f g
3->1  2->1*: a c d b e f g
3->1* 2->2 : a d b c e f g
3->1  2->2*: a d b c e f g
3->1* 2->3 : a d b c e f g
3->1  2->3*: a d b c e f g
3->1* 2->4 : a d b c e f g
3->1  2->4*: a d b c e f g
3->1* 2->5 : a d b e c f g
3->1  2->5*: a d b e c f g
3->1* 2->6 : a d b e f c g
3->1  2->6*: a d b e f c g
3->1* 2->7 : a d b e f g c
3->1  2->7*: a d b e f g c
3->1* 3->0 : a d b c e f g
3->1  3->0*: d a b c e f g
3->1* 3->1 : a d b c e f g
3->1  3->1*: a d b c e f g
3->1* 3->2 : a d b c e f g
3->1  3->2*: a b d c e f g
3->1* 3->3 : a d b c e f g
3->1  3->3*: a d b c e f g
3->1* 3->4 : a d b c e f g
3->1  3->4*: a d b c e f g
3->1* 3->5 : a d b c e f g
3->1  3->5*: a b c e d f g
3->1* 3->6 : a d b c e f g
3->1  3->6*: a b c e f d g
3->1* 3->7 : a d b c e f g
3->1  3->7*: a b c e f g d
3->1* 4->0 : e a d b c f g
3->1  4->0*: e a d b c f g
3->1* 4->1 : a d e b c f g
3->1  4->1*: a e d b c f g
3->1* 4->2 : a d b e c f g
3->1  4->2*: a d b e c f g
3->1* 4->3 : a d b c e f g
3->1  4->3*: a d b c e f g
3->1* 4->4 : a d b c e f g
3->1  4->4*: a d b c e f g
3->1* 4->5 : a d b c e f g
3->1  4->5*: a d b c e f g
3->1* 4->6 : a d b c f e g
3->1  4->6*: a d b c f e g
3->1* 4->7 : a d b c f g e
3->1  4->7*: a d b c f g e
3->1* 5->0 : f a d b c e g
3->1  5->0*: f a d b c e g
3->1* 5->1 : a d f b c e g
3->1  5->1*: a f d b c e g
3->1* 5->2 : a d b f c e g
3->1  5->2*: a d b f c e g
3->1* 5->3 : a d b c f e g
3->1  5->3*: a d b c f e g
3->1* 5->4 : a d b c f e g
3->1  5->4*: a d b c f e g
3->1* 5->5 : a d b c e f g
3->1  5->5*: a d b c e f g
3->1* 5->6 : a d b c e f g
3->1  5->6*: a d b c e f g
3->1* 5->7 : a d b c e g f
3->1  5->7*: a d b c e g f
3->1* 6->0 : g a d b c e f
3->1  6->0*: g a d b c e f
3->1* 6->1 : a d g b c e f
3->1  6->1*: a g d b c e f
3->1* 6->2 : a d b g c e f
3->1  6->2*: a d b g c e f
3->1* 6->3 : a d b c g e f
3->1  6->3*: a d b c g e f
3->1* 6->4 : a d b c g e f
3->1  6->4*: a d b c g e f
3->1* 6->5 : a d b c e g f
3->1  6->5*: a d b c e g f
3->1* 6->6 : a d b c e f g
3->1  6->6*: a d b c e f g
3->1* 6->7 : a d b c e f g
3->1  6->7*: a d b c e f g
3->2* 0->0 : a b d c e f g
3->2  0->0*: a b d c e f g
3->2* 0->1 : a b d c e f g
3->2  0->1*: a b d c e f g
3->2* 0->2 : b d a c e f g
3->2  0->2*: b a d c e f g
3->2* 0->3 : b d c a e f g
3->2  0->3*: b d c a e f g
3->2* 0->4 : b d c a e f g
3->2  0->4*: b d c a e f g
3->2* 0->5 : b d c e a f g
3->2  0->5*: b d c e a f g
3->2* 0->6 : b d c e f a g
3->2  0->6*: b d c e f a g
3->2* 0->7 : b d c e f g a
3->2  0->7*: b d c e f g a
3->2* 1->0 : b a d c e f g
3->2  1->0*: b a d c e f g
3->2* 1->1 : a b d c e f g
3->2  1->1*: a b d c e f g
3->2* 1->2 : a b d c e f g
3->2  1->2*: a b d c e f g
3->2* 1->3 : a d c b e f g
3->2  1->3*: a d c b e f g
3->2* 1->4 : a d c b e f g
3->2  1->4*: a d c b e f g
3->2* 1->5 : a d c e b f g
3->2  1->5*: a d c e b f g
3->2* 1->6 : a d c e f b g
3->2  1->6*: a d c e f b g
3->2* 1->7 : a d c e f g b
3->2  1->7*: a d c e f g b
3->2* 2->0 : c a b d e f g
3->2  2->0*: c a b d e f g
3->2* 2->1 : a c b d e f g
3->2  2->1*: a c b d e f g
3->2* 2->2 : a b d c e f g
3->2  2->2*: a b d c e f g
3->2* 2->3 : a b d c e f g
3->2  2->3*: a b d c e f g
3->2* 2->4 : a b d c e f g
3->2  2->4*: a b d c e f g
3->2* 2->5 : a b d e c f g
3->2  2->5*: a b d e c f g
3->2* 2->6 : a b d e f c g
3->2  2->6*: a b d e f c g
3->2* 2->7 : a b d e f g c
3->2  2->7*: a b d e f g c
3->2* 3->0 : a b d c e f g
3->2  3->0*: d a b c e f g
3->2* 3->1 : a b d c e f g
3->2  3->1*: a d b c e f g
3->2* 3->2 : a b d c e f g
3->2  3->2*: a b d c e f g
3->2* 3->3 : a b d c e f g
3->2  3->3*: a b d c e f g
3->2* 3->4 : a b d c e f g
3->2  3->4*: a b d c e f g
3->2* 3->5 : a b d c e f g
3->2  3->5*: a b c e d f g
3->2* 3->6 : a b d c e f g
3->2  3->6*: a b c e f d g
3->2* 3->7 : a b d c e f g
3->2  3->7*: a b c e f g d
3->2* 4->0 : e a b d c f g
3->2  4->0*: e a b d c f g
3->2* 4->1 : a e b d c f g
3->2  4->1*: a e b d c f g
3->2* 4->2 : a b d e c f g
3->2  4->2*: a b e d c f g
3->2* 4->3 : a b d c e f g
3->2  4->3*: a b d c e f g
3->2* 4->4 : a b d c e f g
3->2  4->4*: a b d c e f g
3->2* 4->5 : a b d c e f g
3->2  4->5*: a b d c e f g
3->2* 4->6 : a b d c f e g
3->2  4->6*: a b d c f e g
3->2* 4->7 : a b d c f g e
3->2  4->7*: a b d c f g e
3->2* 5->0 : f a b d c e g
3->2  5->0*: f a b d c e g
3->2* 5->1 : a f b d c e g
3->2  5->1*: a f b d c e g
3->2* 5->2 : a b d f c e g
3->2  5->2*: a b f d c e g
3->2* 5->3 : a b d c f e g
3->2  5->3*: a b d c f e g
3->2* 5->4 : a b d c f e g
3->2  5->4*: a b d c f e g
3->2* 5->5 : a b d c e f g
3->2  5->5*: a b d c e f g
3->2* 5->6 : a b d c e f g
3->2  5->6*: a b d c e f g
3->2* 5->7 : a b d c e g f
3->2  5->7*: a b d c e g f
3->2* 6->0 : g a b d c e f
3->2  6->0*: g a b d c e f
3->2* 6->1 : a g b d c e f
3->2  6->1*: a g b d c e f
3->2* 6->2 : a b d g c e f
3->2  6->2*: a b g d c e f
3->2* 6->3 : a b d c g e f
3->2  6->3*: a b d c g e f
3->2* 6->4 : a b d c g e f
3->2  6->4*: a b d c g e f
3->2* 6->5 : a b d c e g f
3->2  6->5*: a b d c e g f
3->2* 6->6 : a b d c e f g
3->2  6->6*: a b d c e f g
3->2* 6->7 : a b d c e f g
3->2  6->7*: a b d c e f g
3->3* 0->0 : a b c d e f g
3->3  0->0*: a b c d e f g
3->3* 0->1 : a b c d e f g
3->3  0->1*: a b c d e f g
3->3* 0->2 : b a c d e f g
3->3  0->2*: b a c d e f g
3->3* 0->3 : b c a d e f g
3->3  0->3*: b c a d e f g
3->3* 0->4 : b c d a e f g
3->3  0->4*: b c d a e f g
3->3* 0->5 : b c d e a f g
3->3  0->5*: b c d e a f g
3->3* 0->6 : b c d e f a g
3->3  0->6*: b c d e f a g
3->3* 0->7 : b c d e f g a
3->3  0->7*: b c d e f g a
3->3* 1->0 : b a c d e f g
3->3  1->0*: b a c d e f g
3->3* 1->1 : a b c d e f g
3->3  1->1*: a b c d e f g
3->3* 1->2 : a b c d e f g
3->3  1->2*: a b c d e f g
3->3* 1->3 : a c b d e f g
3->3  1->3*: a c b d e f g
3->3* 1->4 : a c d b e f g
3->3  1->4*: a c d b e f g
3->3* 1->5 : a c d e b f g
3->3  1->5*: a c d e b f g
3->3* 1->6 : a c d e f b g
3->3  1->6*: a c d e f b g
3->3* 1->7 : a c d e f g b
3->3  1->7*: a c d e f g b
3->3* 2->0 : c a b d e f g
3->3  2->0*: c a b d e f g
3->3* 2->1 : a c b d e f g
3->3  2->1*: a c b d e f g
3->3* 2->2 : a b c d e f g
3->3  2->2*: a b c d e f g
3->3* 2->3 : a b c d e f g
3->3  2->3*: a b c d e f g
3->3* 2->4 : a b d c e f g
3->3  2->4*: a b d c e f g
3->3* 2->5 : a b d e c f g
3->3  2->5*: a b d e c f g
3->3* 2->6 : a b d e f c g
3->3  2->6*: a b d e f c g
3->3* 2->7 : a b d e f g c
3->3  2->7*: a b d e f g c
3->3* 3->0 : d a b c e f g
3->3  3->0*: d a b c e f g
3->3* 3->1 : a d b c e f g
3->3  3->1*: a d b c e f g
3->3* 3->2 : a b d c e f g
3->3  3->2*: a b d c e f g
3->3* 3->3 : a b c d e f g
3->3  3->3*: a b c d e f g
3->3* 3->4 : a b c d e f g
3->3  3->4*: a b c d e f g
3->3* 3->5 : a b c e d f g
3->3  3->5*: a b c e d f g
3->3* 3->6 : a b c e f d g
3->3  3->6*: a b c e f d g
3->3* 3->7 : a b c e f g d
3->3  3->7*: a b c e f g d
3->3* 4->0 : e a b c d f g
3->3  4->0*: e a b c d f g
3->3* 4->1 : a e b c d f g
3->3  4->1*: a e b c d f g
3->3* 4->2 : a b e c d f g
3->3  4->2*: a b e c d f g
3->3* 4->3 : a b c e d f g
3->3  4->3*: a b c e d f g
3->3* 4->4 : a b c d e f g
3->3  4->4*: a b c d e f g
3->3* 4->5 : a b c d e f g
3->3  4->5*: a b c d e f g
3->3* 4->6 : a b c d f e g
3->3  4->6*: a b c d f e g
3->3* 4->7 : a b c d f g e
3->3  4->7*: a b c d f g e
3->3* 5->0 : f a b c d e g
3->3  5->0*: f a b c d e g
3->3* 5->1 : a f b c d e g
3->3  5->1*: a f b c d e g
3->3* 5->2 : a b f c d e g
3->3  5->2*: a b f c d e g
3->3* 5->3 : a b c f d e g
3->3  5->3*: a b c f d e g
3->3* 5->4 : a b c d f e g
3->3  5->4*: a b c d f e g
3->3* 5->5 : a b c d e f g
3->3  5->5*: a b c d e f g
3->3* 5->6 : a b c d e f g
3->3  5->6*: a b c d e f g
3->3* 5->7 : a b c d e g f
3->3  5->7*: a b c d e g f
3->3* 6->0 : g a b c d e f
3->3  6->0*: g a b c d e f
3->3* 6->1 : a g b c d e f
3->3  6->1*: a g b c d e f
3->3* 6->2 : a b g c d e f
3->3  6->2*: a b g c d e f
3->3* 6->3 : a b c g d e f
3->3  6->3*: a b c g d e f
3->3* 6->4 : a b c d g e f
3->3  6->4*: a b c d g e f
3->3* 6->5 : a b c d e g f
3->3  6->5*: a b c d e g f
3->3* 6->6 : a b c d e f g
3->3  6->6*: a b c d e f g
3->3* 6->7 : a b c d e f g
3->3  6->7*: a b c d e f g
3->4* 0->0 : a b c d e f g
3->4  0->0*: a b c d e f g
3->4* 0->1 : a b c d e f g
3->4  0->1*: a b c d e f g
3->4* 0->2 : b a c d e f g
3->4  0->2*: b a c d e f g
3->4* 0->3 : b c a d e f g
3->4  0->3*: b c a d e f g
3->4* 0->4 : b c d a e f g
3->4  0->4*: b c d a e f g
3->4* 0->5 : b c d e a f g
3->4  0->5*: b c d e a f g
3->4* 0->6 : b c d e f a g
3->4  0->6*: b c d e f a g
3->4* 0->7 : b c d e f g a
3->4  0->7*: b c d e f g a
3->4* 1->0 : b a c d e f g
3->4  1->0*: b a c d e f g
3->4* 1->1 : a b c d e f g
3->4  1->1*: a b c d e f g
3->4* 1->2 : a b c d e f g
3->4  1->2*: a b c d e f g
3->4* 1->3 : a c b d e f g
3->4  1->3*: a c b d e f g
3->4* 1->4 : a c d b e f g
3->4  1->4*: a c d b e f g
3->4* 1->5 : a c d e b f g
3->4  1->5*: a c d e b f g
3->4* 1->6 : a c d e f b g
3->4  1->6*: a c d e f b g
3->4* 1->7 : a c d e f g b
3->4  1->7*: a c d e f g b
3->4* 2->0 : c a b d e f g
3->4  2->0*: c a b d e f g
3->4* 2->1 : a c b d e f g
3->4  2->1*: a c b d e f g
3->4* 2->2 : a b c d e f g
3->4  2->2*: a b c d e f g
3->4* 2->3 : a b c d e f g
3->4  2->3*: a b c d e f g
3->4* 2->4 : a b d c e f g
3->4  2->4*: a b d c e f g
3->4* 2->5 : a b d e c f g
3->4  2->5*: a b d e c f g
3->4* 2->6 : a b d e f c g
3->4  2->6*: a b d e f c g
3->4* 2->7 : a b d e f g c
3->4  2->7*: a b d e f g c
3->4* 3->0 : d a b c e f g
3->4  3->0*: d a b c e f g
3->4* 3->1 : a d b c e f g
3->4  3->1*: a d b c e f g
3->4* 3->2 : a b d c e f g
3->4  3->2*: a b d c e f g
3->4* 3->3 : a b c d e f g
3->4  3->3*: a b c d e f g
3->4* 3->4 : a b c d e f g
3->4  3->4*: a b c d e f g
3->4* 3->5 : a b c e d f g
3->4  3->5*: a b c e d f g
3->4* 3->6 : a b c e f d g
3->4  3->6*: a b c e f d g
3->4* 3->7 : a b c e f g d
3->4  3->7*: a b c e f g d
3->4* 4->0 : e a b c d f g
3->4  4->0*: e a b c d f g
3->4* 4->1 : a e b c d f g
3->4  4->1*: a e b c d f g
3->4* 4->2 : a b e c d f g
3->4  4->2*: a b e c d f g
3->4* 4->3 : a b c e d f g
3->4  4->3*: a b c e d f g
3->4* 4->4 : a b c d e f g
3->4  4->4*: a b c d e f g
3->4* 4->5 : a b c d e f g
3->4  4->5*: a b c d e f g
3->4* 4->6 : a b c d f e g
3->4  4->6*: a b c d f e g
3->4* 4->7 : a b c d f g e
3->4  4->7*: a b c d f g e
3->4* 5->0 : f a b c d e g
3->4  5->0*: f a b c d e g
3->4* 5->1 : a f b c d e g
3->4  5->1*: a f b c d e g
3->4* 5->2 : a b f c d e g
3->4  5->2*: a b f c d e g
3->4* 5->3 : a b c f d e g
3->4  5->3*: a b c f d e g
3->4* 5->4 : a b c d f e g
3->4  5->4*: a b c d f e g
3->4* 5->5 : a b c d e f g
3->4  5->5*: a b c d e f g
3->4* 5->6 : a b c d e f g
3->4  5->6*: a b c d e f g
3->4* 5->7 : a b c d e g f
3->4  5->7*: a b c d e g f
3->4* 6->0 : g a b c d e f
3->4  6->0*: g a b c d e f
3->4* 6->1 : a g b c d e f
3->4  6->1*: a g b c d e f
3->4* 6->2 : a b g c d e f
3->4  6->2*: a b g c d e f
3->4* 6->3 : a b c g d e f
3->4  6->3*: a b c g d e f
3->4* 6->4 : a b c d g e f
3->4  6->4*: a b c d g e f
3->4* 6->5 : a b c d e g f
3->4  6->5*: a b c d e g f
3->4* 6->6 : a b c d e f g
3->4  6->6*: a b c d e f g
3->4* 6->7 : a b c d e f g
3->4  6->7*: a b c d e f g
3->5* 0->0 : a b c e d f g
3->5  0->0*: a b c e d f g
3->5* 0->1 : a b c e d f g
3->5  0->1*: a b c e d f g
3->5* 0->2 : b a c e d f g
3->5  0->2*: b a c e d f g
3->5* 0->3 : b c a e d f g
3->5  0->3*: b c a e d f g
3->5* 0->4 : b c a e d f g
3->5  0->4*: b c a e d f g
3->5* 0->5 : b c e d a f g
3->5  0->5*: b c e a d f g
3->5* 0->6 : b c e d f a g
3->5  0->6*: b c e d f a g
3->5* 0->7 : b c e d f g a
3->5  0->7*: b c e d f g a
3->5* 1->0 : b a c e d f g
3->5  1->0*: b a c e d f g
3->5* 1->1 : a b c e d f g
3->5  1->1*: a b c e d f g
3->5* 1->2 : a b c e d f g
3->5  1->2*: a b c e d f g
3->5* 1->3 : a c b e d f g
3->5  1->3*: a c b e d f g
3->5* 1->4 : a c b e d f g
3->5  1->4*: a c b e d f g
3->5* 1->5 : a c e d b f g
3->5  1->5*: a c e b d f g
3->5* 1->6 : a c e d f b g
3->5  1->6*: a c e d f b g
3->5* 1->7 : a c e d f g b
3->5  1->7*: a c e d f g b
3->5* 2->0 : c a b e d f g
3->5  2->0*: c a b e d f g
3->5* 2->1 : a c b e d f g
3->5  2->1*: a c b e d f g
3->5* 2->2 : a b c e d f g
3->5  2->2*: a b c e d f g
3->5* 2->3 : a b c e d f g
3->5  2->3*: a b c e d f g
3->5* 2->4 : a b c e d f g
3->5  2->4*: a b c e d f g
3->5* 2->5 : a b e d c f g
3->5  2->5*: a b e c d f g
3->5* 2->6 : a b e d f c g
3->5  2->6*: a b e d f c g
3->5* 2->7 : a b e d f g c
3->5  2->7*: a b e d f g c
3->5* 3->0 : a b c e d f g
3->5  3->0*: d a b c e f g
3->5* 3->1 : a b c e d f g
3->5  3->1*: a d b c e f g
3->5* 3->2 : a b c e d f g
3->5  3->2*: a b d c e f g
3->5* 3->3 : a b c e d f g
3->5  3->3*: a b c e d f g
3->5* 3->4 : a b c e d f g
3->5  3->4*: a b c e d f g
3->5* 3->5 : a b c e d f g
3->5  3->5*: a b c e d f g
3->5* 3->6 : a b c e d f g
3->5  3->6*: a b c e f d g
3->5* 3->7 : a b c e d f g
3->5  3->7*: a b c e f g d
3->5* 4->0 : e a b c d f g
3->5  4->0*: e a b c d f g
3->5* 4->1 : a e b c d f g
3->5  4->1*: a e b c d f g
3->5* 4->2 : a b e c d f g
3->5  4->2*: a b e c d f g
3->5* 4->3 : a b c e d f g
3->5  4->3*: a b c e d f g
3->5* 4->4 : a b c e d f g
3->5  4->4*: a b c e d f g
3->5* 4->5 : a b c e d f g
3->5  4->5*: a b c e d f g
3->5* 4->6 : a b c d f e g
3->5  4->6*: a b c d f e g
3->5* 4->7 : a b c d f g e
3->5  4->7*: a b c d f g e
3->5* 5->0 : f a b c e d g
3->5  5->0*: f a b c e d g
3->5* 5->1 : a f b c e d g
3->5  5->1*: a f b c e d g
3->5* 5->2 : a b f c e d g
3->5  5->2*: a b f c e d g
3->5* 5->3 : a b c f e d g
3->5  5->3*: a b c f e d g
3->5* 5->4 : a b c f e d g
3->5  5->4*: a b c f e d g
3->5* 5->5 : a b c e d f g
3->5  5->5*: a b c e d f g
3->5* 5->6 : a b c e d f g
3->5  5->6*: a b c e d f g
3->5* 5->7 : a b c e d g f
3->5  5->7*: a b c e d g f
3->5* 6->0 : g a b c e d f
3->5  6->0*: g a b c e d f
3->5* 6->1 : a g b c e d f
3->5  6->1*: a g b c e d f
3->5* 6->2 : a b g c e d f
3->5  6->2*: a b g c e d f
3->5* 6->3 : a b c g e d f
3->5  6->3*: a b c g e d f
3->5* 6->4 : a b c g e d f
3->5  6->4*: a b c g e d f
3->5* 6->5 : a b c e d g f
3->5  6->5*: a b c e g d f
3->5* 6->6 : a b c e d f g
3->5  6->6*: a b c e d f g
3->5* 6->7 : a b c e d f g
3->5  6->7*: a b c e d f g
3->6* 0->0 : a b c e f d g
3->6  0->0*: a b c e f d g
3->6* 0->1 : a b c e f d g
3->6  0->1*: a b c e f d g
3->6* 0->2 : b a c e f d g
3->6  0->2*: b a c e f d g
3->6* 0->3 : b c a e f d g
3->6  0->3*: b c a e f d g
3->6* 0->4 : b c a e f d g
3->6  0->4*: b c a e f d g
3->6* 0->5 : b c e a f d g
3->6  0->5*: b c e a f d g
3->6* 0->6 : b c e f d a g
3->6  0->6*: b c e f a d g
3->6* 0->7 : b c e f d g a
3->6  0->7*: b c e f d g a
3->6* 1->0 : b a c e f d g
3->6  1->0*: b a c e f d g
3->6* 1->1 : a b c e f d g
3->6  1->1*: a b c e f d g
3->6* 1->2 : a b c e f d g
3->6  1->2*: a b c e f d g
3->6* 1->3 : a c b e f d g
3->6  1->3*: a c b e f d g
3->6* 1->4 : a c b e f d g
3->6  1->4*: a c b e f d g
3->6* 1->5 : a c e b f d g
3->6  1->5*: a c e b f d g
3->6* 1->6 : a c e f d b g
3->6  1->6*: a c e f b d g
3->6* 1->7 : a c e f d g b
3->6  1->7*: a c e f d g b
3->6* 2->0 : c a b e f d g
3->6  2->0*: c a b e f d g
3->6* 2->1 : a c b e f d g
3->6  2->1*: a c b e f d g
3->6* 2->2 : a b c e f d g
3->6  2->2*: a b c e f d g
3->6* 2->3 : a b c e f d g
3->6  2->3*: a b c e f d g
3->6* 2->4 : a b c e f d g
3->6  2->4*: a b c e f d g
3->6* 2->5 : a b e c f d g
3->6  2->5*: a b e c f d g
3->6* 2->6 : a b e f d c g
3->6  2->6*: a b e f c d g
3->6* 2->7 : a b e f d g c
3->6  2->7*: a b e f d g c
3->6* 3->0 : a b c e f d g
3->6  3->0*: d a b c e f g
3->6* 3->1 : a b c e f d g
3->6  3->1*: a d b c e f g
3->6* 3->2 : a b c e f d g
3->6  3->2*: a b d c e f g
3->6* 3->3 : a b c e f d g
3->6  3->3*: a b c e f d g
3->6* 3->4 : a b c e f d g
3->6  3->4*: a b c e f d g
3->6* 3->5 : a b c e f d g
3->6  3->5*: a b c e d f g
3->6* 3->6 : a b c e f d g
3->6  3->6*: a b c e f d g
3->6* 3->7 : a b c e f d g
3->6  3->7*: a b c e f g d
3->6* 4->0 : e a b c f d g
3->6  4->0*: e a b c f d g
3->6* 4->1 : a e b c f d g
3->6  4->1*: a e b c f d g
3->6* 4->2 : a b e c f d g
3->6  4->2*: a b e c f d g
3->6* 4->3 : a b c e f d g
3->6  4->3*: a b c e f d g
3->6* 4->4 : a b c e f d g
3->6  4->4*: a b c e f d g
3->6* 4->5 : a b c e f d g
3->6  4->5*: a b c e f d g
3->6* 4->6 : a b c f d e g
3->6  4->6*: a b c f e d g
3->6* 4->7 : a b c f d g e
3->6  4->7*: a b c f d g e
3->6* 5->0 : f a b c e d g
3->6  5->0*: f a b c e d g
3->6* 5->1 : a f b c e d g
3->6  5->1*: a f b c e d g
3->6* 5->2 : a b f c e d g
3->6  5->2*: a b f c e d g
3->6* 5->3 : a b c f e d g
3->6  5->3*: a b c f e d g
3->6* 5->4 : a b c f e d g
3->6  5->4*: a b c f e d g
3->6* 5->5 : a b c e f d g
3->6  5->5*: a b c e f d g
3->6* 5->6 : a b c e f d g
3->6  5->6*: a b c e f d g
3->6* 5->7 : a b c e d g f
3->6  5->7*: a b c e d g f
3->6* 6->0 : g a b c e f d
3->6  6->0*: g a b c e f d
3->6* 6->1 : a g b c e f d
3->6  6->1*: a g b c e f d
3->6* 6->2 : a b g c e f d
3->6  6->2*: a b g c e f d
3->6* 6->3 : a b c g e f d
3->6  6->3*: a b c g e f d
3->6* 6->4 : a b c g e f d
3->6  6->4*: a b c g e f d
3->6* 6->5 : a b c e g f d
3->6  6->5*: a b c e g f d
3->6* 6->6 : a b c e f d g
3->6  6->6*: a b c e f d g
3->6* 6->7 : a b c e f d g
3->6  6->7*: a b c e f d g
3->7* 0->0 : a b c e f g d
3->7  0->0*: a b c e f g d
3->7* 0->1 : a b c e f g d
3->7  0->1*: a b c e f g d
3->7* 0->2 : b a c e f g d
3->7  0->2*: b a c e f g d
3->7* 0->3 : b c a e f g d
3->7  0->3*: b c a e f g d
3->7* 0->4 : b c a e f g d
3->7  0->4*: b c a e f g d
3->7* 0->5 : b c e a f g d
3->7  0->5*: b c e a f g d
3->7* 0->6 : b c e f a g d
3->7  0->6*: b c e f a g d
3->7* 0->7 : b c e f g d a
3->7  0->7*: b c e f g a d
3->7* 1->0 : b a c e f g d
3->7  1->0*: b a c e f g d
3->7* 1->1 : a b c e f g d
3->7  1->1*: a b c e f g d
3->7* 1->2 : a b c e f g d
3->7  1->2*: a b c e f g d
3->7* 1->3 : a c b e f g d
3->7  1->3*: a c b e f g d
3->7* 1->4 : a c b e f g d
3->7  1->4*: a c b e f g d
3->7* 1->5 : a c e b f g d
3->7  1->5*: a c e b f g d
3->7* 1->6 : a c e f b g d
3->7  1->6*: a c e f b g d
3->7* 1->7 : a c e f g d b
3->7  1->7*: a c e f g b d
3->7* 2->0 : c a b e f g d
3->7  2->0*: c a b e f g d
3->7* 2->1 : a c b e f g d
3->7  2->1*: a c b e f g d
3->7* 2->2 : a b c e f g d
3->7  2->2*: a b c e f g d
3->7* 2->3 : a b c e f g d
3->7  2->3*: a b c e f g d
3->7* 2->4 : a b c e f g d
3->7  2->4*: a b c e f g d
3->7* 2->5 : a b e c f g d
3->7  2->5*: a b e c f g d
3->7* 2->6 : a b e f c g d
3->7  2->6*: a b e f c g d
3->7* 2->7 : a b e f g d c
3->7  2->7*: a b e f g c d
3->7* 3->0 : a b c e f g d
3->7  3->0*: d a b c e f g
3->7* 3->1 : a b c e f g d
3->7  3->1*: a d b c e f g
3->7* 3->2 : a b c e f g d
3->7  3->2*: a b d c e f g
3->7* 3->3 : a b c e f g d
3->7  3->3*: a b c e f g d
3->7* 3->4 : a b c e f g d
3->7  3->4*: a b c e f g d
3->7* 3->5 : a b c e f g d
3->7  3->5*: a b c e d f g
3->7* 3->6 : a b c e f g d
3->7  3->6*: a b c e f d g
3->7* 3->7 : a b c e f g d
3->7  3->7*: a b c e f g d
3->7* 4->0 : e a b c f g d
3->7  4->0*: e a b c f g d
3->7* 4->1 : a e b c f g d
3->7  4->1*: a e b c f g d
3->7* 4->2 : a b e c f g d
3->7  4->2*: a b e c f g d
3->7* 4->3 : a b c e f g d
3->7  4->3*: a b c e f g d
3->7* 4->4 : a b c e f g d
3->7  4->4*: a b c e f g d
3->7* 4->5 : a b c e f g d
3->7  4->5*: a b c e f g d
3->7* 4->6 : a b c f e g d
3->7  4->6*: a b c f e g d
3->7* 4->7 : a b c f g d e
3->7  4->7*: a b c f g e d
3->7* 5->0 : f a b c e g d
3->7  5->0*: f a b c e g d
3->7* 5->1 : a f b c e g d
3->7  5->1*: a f b c e g d
3->7* 5->2 : a b f c e g d
3->7  5->2*: a b f c e g d
3->7* 5->3 : a b c f e g d
3->7  5->3*: a b c f e g d
3->7* 5->4 : a b c f e g d
3->7  5->4*: a b c f e g d
3->7* 5->5 : a b c e f g d
3->7  5->5*: a b c e f g d
3->7* 5->6 : a b c e f g d
3->7  5->6*: a b c e f g d
3->7* 5->7 : a b c e g d f
3->7  5->7*: a b c e g f d
3->7* 6->0 : g a b c e f d
3->7  6->0*: g a b c e f d
3->7* 6->1 : a g b c e f d
3->7  6->1*: a g b c e f d
3->7* 6->2 : a b g c e f d
3->7  6->2*: a b g c e f d
3->7* 6->3 : a b c g e f d
3->7  6->3*: a b c g e f d
3->7* 6->4 : a b c g e f d
3->7  6->4*: a b c g e f d
3->7* 6->5 : a b c e g f d
3->7  6->5*: a b c e g f d
3->7* 6->6 : a b c e f g d
3->7  6->6*: a b c e f g d
3->7* 6->7 : a b c e f g d
3->7  6->7*: a b c e f g d
4->0* 0->0 : e a b c d f g
4->0  0->0*: e a b c d f g
4->0* 0->1 : e a b c d f g
4->0  0->1*: e a b c d f g
4->0* 0->2 : e b a c d f g
4->0  0->2*: e b a c d f g
4->0* 0->3 : e b c a d f g
4->0  0->3*: e b c a d f g
4->0* 0->4 : e b c d a f g
4->0  0->4*: e b c d a f g
4->0* 0->5 : e b c d a f g
4->0  0->5*: e b c d a f g
4->0* 0->6 : e b c d f a g
4->0  0->6*: e b c d f a g
4->0* 0->7 : e b c d f g a
4->0  0->7*: e b c d f g a
4->0* 1->0 : e b a c d f g
4->0  1->0*: b e a c d f g
4->0* 1->1 : e a b c d f g
4->0  1->1*: e a b c d f g
4->0* 1->2 : e a b c d f g
4->0  1->2*: e a b c d f g
4->0* 1->3 : e a c b d f g
4->0  1->3*: e a c b d f g
4->0* 1->4 : e a c d b f g
4->0  1->4*: e a c d b f g
4->0* 1->5 : e a c d b f g
4->0  1->5*: e a c d b f g
4->0* 1->6 : e a c d f b g
4->0  1->6*: e a c d f b g
4->0* 1->7 : e a c d f g b
4->0  1->7*: e a c d f g b
4->0* 2->0 : e c a b d f g
4->0  2->0*: c e a b d f g
4->0* 2->1 : e a c b d f g
4->0  2->1*: e a c b d f g
4->0* 2->2 : e a b c d f g
4->0  2->2*: e a b c d f g
4->0* 2->3 : e a b c d f g
4->0  2->3*: e a b c d f g
4->0* 2->4 : e a b d c f g
4->0  2->4*: e a b d c f g
4->0* 2->5 : e a b d c f g
4->0  2->5*: e a b d c f g
4->0* 2->6 : e a b d f c g
4->0  2->6*: e a b d f c g
4->0* 2->7 : e a b d f g c
4->0  2->7*: e a b d f g c
4->0* 3->0 : e d a b c f g
4->0  3->0*: d e a b c f g
4->0* 3->1 : e a d b c f g
4->0  3->1*: e a d b c f g
4->0* 3->2 : e a b d c f g
4->0  3->2*: e a b d c f g
4->0* 3->3 : e a b c d f g
4->0  3->3*: e a b c d f g
4->0* 3->4 : e a b c d f g
4->0  3->4*: e a b c d f g
4->0* 3->5 : e a b c d f g
4->0  3->5*: e a b c d f g
4->0* 3->6 : e a b c f d g
4->0  3->6*: e a b c f d g
4->0* 3->7 : e a b c f g d
4->0  3->7*: e a b c f g d
4->0* 4->0 : e a b c d f g
4->0  4->0*: e a b c d f g
4->0* 4->1 : e a b c d f g
4->0  4->1*: a e b c d f g
4->0* 4->2 : e a b c d f g
4->0  4->2*: a b e c d f g
4->0* 4->3 : e a b c d f g
4->0  4->3*: a b c e d f g
4->0* 4->4 : e a b c d f g
4->0  4->4*: e a b c d f g
4->0* 4->5 : e a b c d f g
4->0  4->5*: e a b c d f g
4->0* 4->6 : e a b c d f g
4->0  4->6*: a b c d f e g
4->0* 4->7 : e a b c d f g
4->0  4->7*: a b c d f g e
4->0* 5->0 : e f a b c d g
4->0  5->0*: f e a b c d g
4->0* 5->1 : e a f b c d g
4->0  5->1*: e a f b c d g
4->0* 5->2 : e a b f c d g
4->0  5->2*: e a b f c d g
4->0* 5->3 : e a b c f d g
4->0  5->3*: e a b c f d g
4->0* 5->4 : e a b c d f g
4->0  5->4*: e a b c d f g
4->0* 5->5 : e a b c d f g
4->0  5->5*: e a b c d f g
4->0* 5->6 : e a b c d f g
4->0  5->6*: e a b c d f g
4->0* 5->7 : e a b c d g f
4->0  5->7*: e a b c d g f
4->0* 6->0 : e g a b c d f
4->0  6->0*: g e a b c d f
4->0* 6->1 : e a g b c d f
4->0  6->1*: e a g b c d f
4->0* 6->2 : e a b g c d f
4->0  6->2*: e a b g c d f
4->0* 6->3 : e a b c g d f
4->0  6->3*: e a b c g d f
4->0* 6->4 : e a b c d g f
4->0  6->4*: e a b c d g f
4->0* 6->5 : e a b c d g f
4->0  6->5*: e a b c d g f
4->0* 6->6 : e a b c d f g
4->0  6->6*: e a b c d f g
4->0* 6->7 : e a b c d f g
4->0  6->7*: e a b c d f g
4->1* 0->0 : a e b c d f g
4->1  0->0*: a e b c d f g
4->1* 0->1 : a e b c d f g
4->1  0->1*: a e b c d f g
4->1* 0->2 : e b a c d f g
4->1  0->2*: e b a c d f g
4->1* 0->3 : e b c a d f g
4->1  0->3*: e b c a d f g
4->1* 0->4 : e b c d a f g
4->1  0->4*: e b c d a f g
4->1* 0->5 : e b c d a f g
4->1  0->5*: e b c d a f g
4->1* 0->6 : e b c d f a g
4->1  0->6*: e b c d f a g
4->1* 0->7 : e b c d f g a
4->1  0->7*: e b c d f g a
4->1* 1->0 : b a e c d f g
4->1  1->0*: b a e c d f g
4->1* 1->1 : a e b c d f g
4->1  1->1*: a e b c d f g
4->1* 1->2 : a e b c d f g
4->1  1->2*: a e b c d f g
4->1* 1->3 : a e c b d f g
4->1  1->3*: a e c b d f g
4->1* 1->4 : a e c d b f g
4->1  1->4*: a e c d b f g
4->1* 1->5 : a e c d b f g
4->1  1->5*: a e c d b f g
4->1* 1->6 : a e c d f b g
4->1  1->6*: a e c d f b g
4->1* 1->7 : a e c d f g b
4->1  1->7*: a e c d f g b
4->1* 2->0 : c a e b d f g
4->1  2->0*: c a e b d f g
4->1* 2->1 : a e c b d f g
4->1  2->1*: a c e b d f g
4->1* 2->2 : a e b c d f g
4->1  2->2*: a e b c d f g
4->1* 2->3 : a e b c d f g
4->1  2->3*: a e b c d f g
4->1* 2->4 : a e b d c f g
4->1  2->4*: a e b d c f g
4->1* 2->5 : a e b d c f g
4->1  2->5*: a e b d c f g
4->1* 2->6 : a e b d f c g
4->1  2->6*: a e b d f c g
4->1* 2->7 : a e b d f g c
4->1  2->7*: a e b d f g c
4->1* 3->0 : d a e b c f g
4->1  3->0*: d a e b c f g
4->1* 3->1 : a e d b c f g
4->1  3->1*: a d e b c f g
4->1* 3->2 : a e b d c f g
4->1  3->2*: a e b d c f g
4->1* 3->3 : a e b c d f g
4->1  3->3*: a e b c d f g
4->1* 3->4 : a e b c d f g
4->1  3->4*: a e b c d f g
4->1* 3->5 : a e b c d f g
4->1  3->5*: a e b c d f g
4->1* 3->6 : a e b c f d g
4->1  3->6*: a e b c f d g
4->1* 3->7 : a e b c f g d
4->1  3->7*: a e b c f g d
4->1* 4->0 : a e b c d f g
4->1  4->0*: e a b c d f g
4->1* 4->1 : a e b c d f g
4->1  4->1*: a e b c d f g
4->1* 4->2 : a e b c d f g
4->1  4->2*: a b e c d f g
4->1* 4->3 : a e b c d f g
4->1  4->3*: a b c e d f g
4->1* 4->4 : a e b c d f g
4->1  4->4*: a e b c d f g
4->1* 4->5 : a e b c d f g
4->1  4->5*: a e b c d f g
4->1* 4->6 : a e b c d f g
4->1  4->6*: a b c d f e g
4->1* 4->7 : a e b c d f g
4->1  4->7*: a b c d f g e
4->1* 5->0 : f a e b c d g
4->1  5->0*: f a e b c d g
4->1* 5->1 : a e f b c d g
4->1  5->1*: a f e b c d g
4->1* 5->2 : a e b f c d g
4->1  5->2*: a e b f c d g
4->1* 5->3 : a e b c f d g
4->1  5->3*: a e b c f d g
4->1* 5->4 : a e b c d f g
4->1  5->4*: a e b c d f g
4->1* 5->5 : a e b c d f g
4->1  5->5*: a e b c d f g
4->1* 5->6 : a e b c d f g
4->1  5->6*: a e b c d f g
4->1* 5->7 : a e b c d g f
4->1  5->7*: a e b c d g f
4->1* 6->0 : g a e b c d f
4->1  6->0*: g a e b c d f
4->1* 6->1 : a e g b c d f
4->1  6->1*: a g e b c d f
4->1* 6->2 : a e b g c d f
4->1  6->2*: a e b g c d f
4->1* 6->3 : a e b c g d f
4->1  6->3*: a e b c g d f
4->1* 6->4 : a e b c d g f
4->1  6->4*: a e b c d g f
4->1* 6->5 : a e b c d g f
4->1  6->5*: a e b c d g f
4->1* 6->6 : a e b c d f g
4->1  6->6*: a e b c d f g
4->1* 6->7 : a e b c d f g
4->1  6->7*: a e b c d f g
4->2* 0->0 : a b e c d f g
4->2  0->0*: a b e c d f g
4->2* 0->1 : a b e c d f g
4->2  0->1*: a b e c d f g
4->2* 0->2 : b e a c d f g
4->2  0->2*: b a e c d f g
4->2* 0->3 : b e c a d f g
4->2  0->3*: b e c a d f g
4->2* 0->4 : b e c d a f g
4->2  0->4*: b e c d a f g
4->2* 0->5 : b e c d a f g
4->2  0->5*: b e c d a f g
4->2* 0->6 : b e c d f a g
4->2  0->6*: b e c d f a g
4->2* 0->7 : b e c d f g a
4->2  0->7*: b e c d f g a
4->2* 1->0 : b a e c d f g
4->2  1->0*: b a e c d f g
4->2* 1->1 : a b e c d f g
4->2  1->1*: a b e c d f g
4->2* 1->2 : a b e c d f g
4->2  1->2*: a b e c d f g
4->2* 1->3 : a e c b d f g
4->2  1->3*: a e c b d f g
4->2* 1->4 : a e c d b f g
4->2  1->4*: a e c d b f g
4->2* 1->5 : a e c d b f g
4->2  1->5*: a e c d b f g
4->2* 1->6 : a e c d f b g
4->2  1->6*: a e c d f b g
4->2* 1->7 : a e c d f g b
4->2  1->7*: a e c d f g b
4->2* 2->0 : c a b e d f g
4->2  2->0*: c a b e d f g
4->2* 2->1 : a c b e d f g
4->2  2->1*: a c b e d f g
4->2* 2->2 : a b e c d f g
4->2  2->2*: a b e c d f g
4->2* 2->3 : a b e c d f g
4->2  2->3*: a b e c d f g
4->2* 2->4 : a b e d c f g
4->2  2->4*: a b e d c f g
4->2* 2->5 : a b e d c f g
4->2  2->5*: a b e d c f g
4->2* 2->6 : a b e d f c g
4->2  2->6*: a b e d f c g
4->2* 2->7 : a b e d f g c
4->2  2->7*: a b e d f g c
4->2* 3->0 : d a b e c f g
4->2  3->0*: d a b e c f g
4->2* 3->1 : a d b e c f g
4->2  3->1*: a d b e c f g
4->2* 3->2 : a b e d c f g
4->2  3->2*: a b d e c f g
4->2* 3->3 : a b e c d f g
4->2  3->3*: a b e c d f g
4->2* 3->4 : a b e c d f g
4->2  3->4*: a b e c d f g
4->2* 3->5 : a b e c d f g
4->2  3->5*: a b e c d f g
4->2* 3->6 : a b e c f d g
4->2  3->6*: a b e c f d g
4->2* 3->7 : a b e c f g d
4->2  3->7*: a b e c f g d
4->2* 4->0 : a b e c d f g
4->2  4->0*: e a b c d f g
4->2* 4->1 : a b e c d f g
4->2  4->1*: a e b c d f g
4->2* 4->2 : a b e c d f g
4->2  4->2*: a b e c d f g
4->2* 4->3 : a b e c d f g
4->2  4->3*: a b c e d f g
4->2* 4->4 : a b e c d f g
4->2  4->4*: a b e c d f g
4->2* 4->5 : a b e c d f g
4->2  4->5*: a b e c d f g
4->2* 4->6 : a b e c d f g
4->2  4->6*: a b c d f e g
4->2* 4->7 : a b e c d f g
4->2  4->7*: a b c d f g e
4->2* 5->0 : f a b e c d g
4->2  5->0*: f a b e c d g
4->2* 5->1 : a f b e c d g
4->2  5->1*: a f b e c d g
4->2* 5->2 : a b e f c d g
4->2  5->2*: a b f e c d g
4->2* 5->3 : a b e c f d g
4->2  5->3*: a b e c f d g
4->2* 5->4 : a b e c d f g
4->2  5->4*: a b e c d f g
4->2* 5->5 : a b e c d f g
4->2  5->5*: a b e c d f g
4->2* 5->6 : a b e c d f g
4->2  5->6*: a b e c d f g
4->2* 5->7 : a b e c d g f
4->2  5->7*: a b e c d g f
4->2* 6->0 : g a b e c d f
4->2  6->0*: g a b e c d f
4->2* 6->1 : a g b e c d f
4->2  6->1*: a g b e c d f
4->2* 6->2 : a b e g c d f
4->2  6->2*: a b g e c d f
4->2* 6->3 : a b e c g d f
4->2  6->3*: a b e c g d f
4->2* 6->4 : a b e c d g f
4->2  6->4*: a b e c d g f
4->2* 6->5 : a b e c d g f
4->2  6->5*: a b e c d g f
4->2* 6->6 : a b e c d f g
4->2  6->6*: a b e c d f g
4->2* 6->7 : a b e c d f g
4->2  6->7*: a b e c d f g
4->3* 0->0 : a b c e d f g
4->3  0->0*: a b c e d f g
4->3* 0->1 : a b c e d f g
4->3  0->1*: a b c e d f g
4->3* 0->2 : b a c e d f g
4->3  0->2*: b a c e d f g
4->3* 0->3 : b c e a d f g
4->3  0->3*: b c a e d f g
4->3* 0->4 : b c e d a f g
4->3  0->4*: b c e d a f g
4->3* 0->5 : b c e d a f g
4->3  0->5*: b c e d a f g
4->3* 0->6 : b c e d f a g
4->3  0->6*: b c e d f a g
4->3* 0->7 : b c e d f g a
4->3  0->7*: b c e d f g a
4->3* 1->0 : b a c e d f g
4->3  1->0*: b a c e d f g
4->3* 1->1 : a b c e d f g
4->3  1->1*: a b c e d f g
4->3* 1->2 : a b c e d f g
4->3  1->2*: a b c e d f g
4->3* 1->3 : a c e b d f g
4->3  1->3*: a c b e d f g
4->3* 1->4 : a c e d b f g
4->3  1->4*: a c e d b f g
4->3* 1->5 : a c e d b f g
4->3  1->5*: a c e d b f g
4->3* 1->6 : a c e d f b g
4->3  1->6*: a c e d f b g
4->3* 1->7 : a c e d f g b
4->3  1->7*: a c e d f g b
4->3* 2->0 : c a b e d f g
4->3  2->0*: c a b e d f g
4->3* 2->1 : a c b e d f g
4->3  2->1*: a c b e d f g
4->3* 2->2 : a b c e d f g
4->3  2->2*: a b c e d f g
4->3* 2->3 : a b c e d f g
4->3  2->3*: a b c e d f g
4->3* 2->4 : a b e d c f g
4->3  2->4*: a b e d c f g
4->3* 2->5 : a b e d c f g
4->3  2->5*: a b e d c f g
4->3* 2->6 : a b e d f c g
4->3  2->6*: a b e d f c g
4->3* 2->7 : a b e d f g c
4->3  2->7*: a b e d f g c
4->3* 3->0 : d a b c e f g
4->3  3->0*: d a b c e f g
4->3* 3->1 : a d b c e f g
4->3  3->1*: a d b c e f g
4->3* 3->2 : a b d c e f g
4->3  3->2*: a b d c e f g
4->3* 3->3 : a b c e d f g
4->3  3->3*: a b c e d f g
4->3* 3->4 : a b c e d f g
4->3  3->4*: a b c e d f g
4->3* 3->5 : a b c e d f g
4->3  3->5*: a b c e d f g
4->3* 3->6 : a b c e f d g
4->3  3->6*: a b c e f d g
4->3* 3->7 : a b c e f g d
4->3  3->7*: a b c e f g d
4->3* 4->0 : a b c e d f g
4->3  4->0*: e a b c d f g
4->3* 4->1 : a b c e d f g
4->3  4->1*: a e b c d f g
4->3* 4->2 : a b c e d f g
4->3  4->2*: a b e c d f g
4->3* 4->3 : a b c e d f g
4->3  4->3*: a b c e d f g
4->3* 4->4 : a b c e d f g
4->3  4->4*: a b c e d f g
4->3* 4->5 : a b c e d f g
4->3  4->5*: a b c e d f g
4->3* 4->6 : a b c e d f g
4->3  4->6*: a b c d f e g
4->3* 4->7 : a b c e d f g
4->3  4->7*: a b c d f g e
4->3* 5->0 : f a b c e d g
4->3  5->0*: f a b c e d g
4->3* 5->1 : a f b c e d g
4->3  5->1*: a f b c e d g
4->3* 5->2 : a b f c e d g
4->3  5->2*: a b f c e d g
4->3* 5->3 : a b c e f d g
4->3  5->3*: a b c f e d g
4->3* 5->4 : a b c e d f g
4->3  5->4*: a b c e d f g
4->3* 5->5 : a b c e d f g
4->3  5->5*: a b c e d f g
4->3* 5->6 : a b c e d f g
4->3  5->6*: a b c e d f g
4->3* 5->7 : a b c e d g f
4->3  5->7*: a b c e d g f
4->3* 6->0 : g a b c e d f
4->3  6->0*: g a b c e d f
4->3* 6->1 : a g b c e d f
4->3  6->1*: a g b c e d f
4->3* 6->2 : a b g c e d f
4->3  6->2*: a b g c e d f
4->3* 6->3 : a b c e g d f
4->3  6->3*: a b c g e d f
4->3* 6->4 : a b c e d g f
4->3  6->4*: a b c e d g f
4->3* 6->5 : a b c e d g f
4->3  6->5*: a b c e d g f
4->3* 6->6 : a b c e d f g
4->3  6->6*: a b c e d f g
4->3* 6->7 : a b c e d f g
4->3  6->7*: a b c e d f g
4->4* 0->0 : a b c d e f g
4->4  0->0*: a b c d e f g
4->4* 0->1 : a b c d e f g
4->4  0->1*: a b c d e f g
4->4* 0->2 : b a c d e f g
4->4  0->2*: b a c d e f g
4->4* 0->3 : b c a d e f g
4->4  0->3*: b c a d e f g
4->4* 0->4 : b c d a e f g
4->4  0->4*: b c d a e f g
4->4* 0->5 : b c d e a f g
4->4  0->5*: b c d e a f g
4->4* 0->6 : b c d e f a g
4->4  0->6*: b c d e f a g
4->4* 0->7 : b c d e f g a
4->4  0->7*: b c d e f g a
4->4* 1->0 : b a c d e f g
4->4  1->0*: b a c d e f g
4->4* 1->1 : a b c d e f g
4->4  1->1*: a b c d e f g
4->4* 1->2 : a b c d e f g
4->4  1->2*: a b c d e f g
4->4* 1->3 : a c b d e f g
4->4  1->3*: a c b d e f g
4->4* 1->4 : a c d b e f g
4->4  1->4*: a c d b e f g
4->4* 1->5 : a c d e b f g
4->4  1->5*: a c d e b f g
4->4* 1->6 : a c d e f b g
4->4  1->6*: a c d e f b g
4->4* 1->7 : a c d e f g b
4->4  1->7*: a c d e f g b
4->4* 2->0 : c a b d e f g
4->4  2->0*: c a b d e f g
4->4* 2->1 : a c b d e f g
4->4  2->1*: a c b d e f g
4->4* 2->2 : a b c d e f g
4->4  2->2*: a b c d e f g
4->4* 2->3 : a b c d e f g
4->4  2->3*: a b c d e f g
4->4* 2->4 : a b d c e f g
4->4  2->4*: a b d c e f g
4->4* 2->5 : a b d e c f g
4->4  2->5*: a b d e c f g
4->4* 2->6 : a b d e f c g
4->4  2->6*: a b d e f c g
4->4* 2->7 : a b d e f g c
4->4  2->7*: a b d e f g c
4->4* 3->0 : d a b c e f g
4->4  3->0*: d a b c e f g
4->4* 3->1 : a d b c e f g
4->4  3->1*: a d b c e f g
4->4* 3->2 : a b d c e f g
4->4  3->2*: a b d c e f g
4->4* 3->3 : a b c d e f g
4->4  3->3*: a b c d e f g
4->4* 3->4 : a b c d e f g
4->4  3->4*: a b c d e f g
4->4* 3->5 : a b c e d f g
4->4  3->5*: a b c e d f g
4->4* 3->6 : a b c e f d g
4->4  3->6*: a b c e f d g
4->4* 3->7 : a b c e f g d
4->4  3->7*: a b c e f g d
4->4* 4->0 : e a b c d f g
4->4  4->0*: e a b c d f g
4->4* 4->1 : a e b c d f g
4->4  4->1*: a e b c d f g
4->4* 4->2 : a b e c d f g
4->4  4->2*: a b e c d f g
4->4* 4->3 : a b c e d f g
4->4  4->3*: a b c e d f g
4->4* 4->4 : a b c d e f g
4->4  4->4*: a b c d e f g
4->4* 4->5 : a b c d e f g
4->4  4->5*: a b c d e f g
4->4* 4->6 : a b c d f e g
4->4  4->6*: a b c d f e g
4->4* 4->7 : a b c d f g e
4->4  4->7*: a b c d f g e
4->4* 5->0 : f a b c d e g
4->4  5->0*: f a b c d e g
4->4* 5->1 : a f b c d e g
4->4  5->1*: a f b c d e g
4->4* 5->2 : a b f c d e g
4->4  5->2*: a b f c d e g
4->4* 5->3 : a b c f d e g
4->4  5->3*: a b c f d e g
4->4* 5->4 : a b c d f e g
4->4  5->4*: a b c d f e g
4->4* 5->5 : a b c d e f g
4->4  5->5*: a b c d e f g
4->4* 5->6 : a b c d e f g
4->4  5->6*: a b c d e f g
4->4* 5->7 : a b c d e g f
4->4  5->7*: a b c d e g f
4->4* 6->0 : g a b c d e f
4->4  6->0*: g a b c d e f
4->4* 6->1 : a g b c d e f
4->4  6->1*: a g b c d e f
4->4* 6->2 : a b g c d e f
4->4  6->2*: a b g c d e f
4->4* 6->3 : a b c g d e f
4->4  6->3*: a b c g d e f
4->4* 6->4 : a b c d g e f
4->4  6->4*: a b c d g e f
4->4* 6->5 : a b c d e g f
4->4  6->5*: a b c d e g f
4->4* 6->6 : a b c d e f g
4->4  6->6*: a b c d e f g
4->4* 6->7 : a b c d e f g
4->4  6->7*: a b c d e f g
4->5* 0->0 : a b c d e f g
4->5  0->0*: a b c d e f g
4->5* 0->1 : a b c d e f g
4->5  0->1*: a b c d e f g
4->5* 0->2 : b a c d e f g
4->5  0->2*: b a c d e f g
4->5* 0->3 : b c a d e f g
4->5  0->3*: b c a d e f g
4->5* 0->4 : b c d a e f g
4->5  0->4*: b c d a e f g
4->5* 0->5 : b c d e a f g
4->5  0->5*: b c d e a f g
4->5* 0->6 : b c d e f a g
4->5  0->6*: b c d e f a g
4->5* 0->7 : b c d e f g a
4->5  0->7*: b c d e f g a
4->5* 1->0 : b a c d e f g
4->5  1->0*: b a c d e f g
4->5* 1->1 : a b c d e f g
4->5  1->1*: a b c d e f g
4->5* 1->2 : a b c d e f g
4->5  1->2*: a b c d e f g
4->5* 1->3 : a c b d e f g
4->5  1->3*: a c b d e f g
4->5* 1->4 : a c d b e f g
4->5  1->4*: a c d b e f g
4->5* 1->5 : a c d e b f g
4->5  1->5*: a c d e b f g
4->5* 1->6 : a c d e f b g
4->5  1->6*: a c d e f b g
4->5* 1->7 : a c d e f g b
4->5  1->7*: a c d e f g b
4->5* 2->0 : c a b d e f g
4->5  2->0*: c a b d e f g
4->5* 2->1 : a c b d e f g
4->5  2->1*: a c b d e f g
4->5* 2->2 : a b c d e f g
4->5  2->2*: a b c d e f g
4->5* 2->3 : a b c d e f g
4->5  2->3*: a b c d e f g
4->5* 2->4 : a b d c e f g
4->5  2->4*: a b d c e f g
4->5* 2->5 : a b d e c f g
4->5  2->5*: a b d e c f g
4->5* 2->6 : a b d e f c g
4->5  2->6*: a b d e f c g
4->5* 2->7 : a b d e f g c
4->5  2->7*: a b d e f g c
4->5* 3->0 : d a b c e f g
4->5  3->0*: d a b c e f g
4->5* 3->1 : a d b c e f g
4->5  3->1*: a d b c e f g
4->5* 3->2 : a b d c e f g
4->5  3->2*: a b d c e f g
4->5* 3->3 : a b c d e f g
4->5  3->3*: a b c d e f g
4->5* 3->4 : a b c d e f g
4->5  3->4*: a b c d e f g
4->5* 3->5 : a b c e d f g
4->5  3->5*: a b c e d f g
4->5* 3->6 : a b c e f d g
4->5  3->6*: a b c e f d g
4->5* 3->7 : a b c e f g d
4->5  3->7*: a b c e f g d
4->5* 4->0 : e a b c d f g
4->5  4->0*: e a b c d f g
4->5* 4->1 : a e b c d f g
4->5  4->1*: a e b c d f g
4->5* 4->2 : a b e c d f g
4->5  4->2*: a b e c d f g
4->5* 4->3 : a b c e d f g
4->5  4->3*: a b c e d f g
4->5* 4->4 : a b c d e f g
4->5  4->4*: a b c d e f g
4->5* 4->5 : a b c d e f g
4->5  4->5*: a b c d e f g
4->5* 4->6 : a b c d f e g
4->5  4->6*: a b c d f e g
4->5* 4->7 : a b c d f g e
4->5  4->7*: a b c d f g e
4->5* 5->0 : f a b c d e g
4->5  5->0*: f a b c d e g
4->5* 5->1 : a f b c d e g
4->5  5->1*: a f b c d e g
4->5* 5->2 : a b f c d e g
4->5  5->2*: a b f c d e g
4->5* 5->3 : a b c f d e g
4->5  5->3*: a b c f d e g
4->5* 5->4 : a b c d f e g
4->5  5->4*: a b c d f e g
4->5* 5->5 : a b c d e f g
4->5  5->5*: a b c d e f g
4->5* 5->6 : a b c d e f g
4->5  5->6*: a b c d e f g
4->5* 5->7 : a b c d e g f
4->5  5->7*: a b c d e g f
4->5* 6->0 : g a b c d e f
4->5  6->0*: g a b c d e f
4->5* 6->1 : a g b c d e f
4->5  6->1*: a g b c d e f
4->5* 6->2 : a b g c d e f
4->5  6->2*: a b g c d e f
4->5* 6->3 : a b c g d e f
4->5  6->3*: a b c g d e f
4->5* 6->4 : a b c d g e f
4->5  6->4*: a b c d g e f
4->5* 6->5 : a b c d e g f
4->5  6->5*: a b c d e g f
4->5* 6->6 : a b c d e f g
4->5  6->6*: a b c d e f g
4->5* 6->7 : a b c d e f g
4->5  6->7*: a b c d e f g
4->6* 0->0 : a b c d f e g
4->6  0->0*: a b c d f e g
4->6* 0->1 : a b c d f e g
4->6  0->1*: a b c d f e g
4->6* 0->2 : b a c d f e g
4->6  0->2*: b a c d f e g
4->6* 0->3 : b c a d f e g
4->6  0->3*: b c a d f e g
4->6* 0->4 : b c d a f e g
4->6  0->4*: b c d a f e g
4->6* 0->5 : b c d a f e g
4->6  0->5*: b c d a f e g
4->6* 0->6 : b c d f e a g
4->6  0->6*: b c d f a e g
4->6* 0->7 : b c d f e g a
4->6  0->7*: b c d f e g a
4->6* 1->0 : b a c d f e g
4->6  1->0*: b a c d f e g
4->6* 1->1 : a b c d f e g
4->6  1->1*: a b c d f e g
4->6* 1->2 : a b c d f e g
4->6  1->2*: a b c d f e g
4->6* 1->3 : a c b d f e g
4->6  1->3*: a c b d f e g
4->6* 1->4 : a c d b f e g
4->6  1->4*: a c d b f e g
4->6* 1->5 : a c d b f e g
4->6  1->5*: a c d b f e g
4->6* 1->6 : a c d f e b g
4->6  1->6*: a c d f b e g
4->6* 1->7 : a c d f e g b
4->6  1->7*: a c d f e g b
4->6* 2->0 : c a b d f e g
4->6  2->0*: c a b d f e g
4->6* 2->1 : a c b d f e g
4->6  2->1*: a c b d f e g
4->6* 2->2 : a b c d f e g
4->6  2->2*: a b c d f e g
4->6* 2->3 : a b c d f e g
4->6  2->3*: a b c d f e g
4->6* 2->4 : a b d c f e g
4->6  2->4*: a b d c f e g
4->6* 2->5 : a b d c f e g
4->6  2->5*: a b d c f e g
4->6* 2->6 : a b d f e c g
4->6  2->6*: a b d f c e g
4->6* 2->7 : a b d f e g c
4->6  2->7*: a b d f e g c
4->6* 3->0 : d a b c f e g
4->6  3->0*: d a b c f e g
4->6* 3->1 : a d b c f e g
4->6  3->1*: a d b c f e g
4->6* 3->2 : a b d c f e g
4->6  3->2*: a b d c f e g
4->6* 3->3 : a b c d f e g
4->6  3->3*: a b c d f e g
4->6* 3->4 : a b c d f e g
4->6  3->4*: a b c d f e g
4->6* 3->5 : a b c d f e g
4->6  3->5*: a b c d f e g
4->6* 3->6 : a b c f e d g
4->6  3->6*: a b c f d e g
4->6* 3->7 : a b c f e g d
4->6  3->7*: a b c f e g d
4->6* 4->0 : a b c d f e g
4->6  4->0*: e a b c d f g
4->6* 4->1 : a b c d f e g
4->6  4->1*: a e b c d f g
4->6* 4->2 : a b c d f e g
4->6  4->2*: a b e c d f g
4->6* 4->3 : a b c d f e g
4->6  4->3*: a b c e d f g
4->6* 4->4 : a b c d f e g
4->6  4->4*: a b c d f e g
4->6* 4->5 : a b c d f e g
4->6  4->5*: a b c d f e g
4->6* 4->6 : a b c d f e g
4->6  4->6*: a b c d f e g
4->6* 4->7 : a b c d f e g
4->6  4->7*: a b c d f g e
4->6* 5->0 : f a b c d e g
4->6  5->0*: f a b c d e g
4->6* 5->1 : a f b c d e g
4->6  5->1*: a f b c d e g
4->6* 5->2 : a b f c d e g
4->6  5->2*: a b f c d e g
4->6* 5->3 : a b c f d e g
4->6  5->3*: a b c f d e g
4->6* 5->4 : a b c d f e g
4->6  5->4*: a b c d f e g
4->6* 5->5 : a b c d f e g
4->6  5->5*: a b c d f e g
4->6* 5->6 : a b c d f e g
4->6  5->6*: a b c d f e g
4->6* 5->7 : a b c d e g f
4->6  5->7*: a b c d e g f
4->6* 6->0 : g a b c d f e
4->6  6->0*: g a b c d f e
4->6* 6->1 : a g b c d f e
4->6  6->1*: a g b c d f e
4->6* 6->2 : a b g c d f e
4->6  6->2*: a b g c d f e
4->6* 6->3 : a b c g d f e
4->6  6->3*: a b c g d f e
4->6* 6->4 : a b c d g f e
4->6  6->4*: a b c d g f e
4->6* 6->5 : a b c d g f e
4->6  6->5*: a b c d g f e
4->6* 6->6 : a b c d f e g
4->6  6->6*: a b c d f e g
4->6* 6->7 : a b c d f e g
4->6  6->7*: a b c d f e g
4->7* 0->0 : a b c d f g e
4->7  0->0*: a b c d f g e
4->7* 0->1 : a b c d f g e
4->7  0->1*: a b c d f g e
4->7* 0->2 : b a c d f g e
4->7  0->2*: b a c d f g e
4->7* 0->3 : b c a d f g e
4->7  0->3*: b c a d f g e
4->7* 0->4 : b c d a f g e
4->7  0->4*: b c d a f g e
4->7* 0->5 : b c d a f g e
4->7  0->5*: b c d a f g e
4->7* 0->6 : b c d f a g e
4->7  0->6*: b c d f a g e
4->7* 0->7 : b c d f g e a
4->7  0->7*: b c d f g a e
4->7* 1->0 : b a c d f g e
4->7  1->0*: b a c d f g e
4->7* 1->1 : a b c d f g e
4->7  1->1*: a b c d f g e
4->7* 1->2 : a b c d f g e
4->7  1->2*: a b c d f g e
4->7* 1->3 : a c b d f g e
4->7  1->3*: a c b d f g e
4->7* 1->4 : a c d b f g e
4->7  1->4*: a c d b f g e
4->7* 1->5 : a c d b f g e
4->7  1->5*: a c d b f g e
4->7* 1->6 : a c d f b g e
4->7  1->6*: a c d f b g e
4->7* 1->7 : a c d f g e b
4->7  1->7*: a c d f g b e
4->7* 2->0 : c a b d f g e
4->7  2->0*: c a b d f g e
4->7* 2->1 : a c b d f g e
4->7  2->1*: a c b d f g e
4->7* 2->2 : a b c d f g e
4->7  2->2*: a b c d f g e
4->7* 2->3 : a b c d f g e
4->7  2->3*: a b c d f g e
4->7* 2->4 : a b d c f g e
4->7  2->4*: a b d c f g e
4->7* 2->5 : a b d c f g e
4->7  2->5*: a b d c f g e
4->7* 2->6 : a b d f c g e
4->7  2->6*: a b d f c g e
4->7* 2->7 : a b d f g e c
4->7  2->7*: a b d f g c e
4->7* 3->0 : d a b c f g e
4->7  3->0*: d a b c f g e
4->7* 3->1 : a d b c f g e
4->7  3->1*: a d b c f g e
4->7* 3->2 : a b d c f g e
4->7  3->2*: a b d c f g e
4->7* 3->3 : a b c d f g e
4->7  3->3*: a b c d f g e
4->7* 3->4 : a b c d f g e
4->7  3->4*: a b c d f g e
4->7* 3->5 : a b c d f g e
4->7  3->5*: a b c d f g e
4->7* 3->6 : a b c f d g e
4->7  3->6*: a b c f d g e
4->7* 3->7 : a b c f g e d
4->7  3->7*: a b c f g d e
4->7* 4->0 : a b c d f g e
4->7  4->0*: e a b c d f g
4->7* 4->1 : a b c d f g e
4->7  4->1*: a e b c d f g
4->7* 4->2 : a b c d f g e
4->7  4->2*: a b e c d f g
4->7* 4->3 : a b c d f g e
4->7  4->3*: a b c e d f g
4->7* 4->4 : a b c d f g e
4->7  4->4*: a b c d f g e
4->7* 4->5 : a b c d f g e
4->7  4->5*: a b c d f g e
4->7* 4->6 : a b c d f g e
4->7  4->6*: a b c d f e g
4->7* 4->7 : a b c d f g e
4->7  4->7*: a b c d f g e
4->7* 5->0 : f a b c d g e
4->7  5->0*: f a b c d g e
4->7* 5->1 : a f b c d g e
4->7  5->1*: a f b c d g e
4->7* 5->2 : a b f c d g e
4->7  5->2*: a b f c d g e
4->7* 5->3 : a b c f d g e
4->7  5->3*: a b c f d g e
4->7* 5->4 : a b c d f g e
4->7  5->4*: a b c d f g e
4->7* 5->5 : a b c d f g e
4->7  5->5*: a b c d f g e
4->7* 5->6 : a b c d f g e
4->7  5->6*: a b c d f g e
4->7* 5->7 : a b c d g e f
4->7  5->7*: a b c d g f e
4->7* 6->0 : g a b c d f e
4->7  6->0*: g a b c d f e
4->7* 6->1 : a g b c d f e
4->7  6->1*: a g b c d f e
4->7* 6->2 : a b g c d f e
4->7  6->2*: a b g c d f e
4->7* 6->3 : a b c g d f e
4->7  6->3*: a b c g d f e
4->7* 6->4 : a b c d g f e
4->7  6->4*: a b c d g f e
4->7* 6->5 : a b c d g f e
4->7  6->5*: a b c d g f e
4->7* 6->6 : a b c d f g e
4->7  6->6*: a b c d f g e
4->7* 6->7 : a b c d f g e
4->7  6->7*: a b c d f g e
5->0* 0->0 : f a b c d e g
5->0  0->0*: f a b c d e g
5->0* 0->1 : f a b c d e g
5->0  0->1*: f a b c d e g
5->0* 0->2 : f b a c d e g
5->0  0->2*: f b a c d e g
5->0* 0->3 : f b c a d e g
5->0  0->3*: f b c a d e g
5->0* 0->4 : f b c d a e g
5->0  0->4*: f b c d a e g
5->0* 0->5 : f b c d e a g
5->0  0->5*: f b c d e a g
5->0* 0->6 : f b c d e a g
5->0  0->6*: f b c d e a g
5->0* 0->7 : f b c d e g a
5->0  0->7*: f b c d e g a
5->0* 1->0 : f b a c d e g
5->0  1->0*: b f a c d e g
5->0* 1->1 : f a b c d e g
5->0  1->1*: f a b c d e g
5->0* 1->2 : f a b c d e g
5->0  1->2*: f a b c d e g
5->0* 1->3 : f a c b d e g
5->0  1->3*: f a c b d e g
5->0* 1->4 : f a c d b e g
5->0  1->4*: f a c d b e g
5->0* 1->5 : f a c d e b g
5->0  1->5*: f a c d e b g
5->0* 1->6 : f a c d e b g
5->0  1->6*: f a c d e b g
5->0* 1->7 : f a c d e g b
5->0  1->7*: f a c d e g b
5->0* 2->0 : f c a b d e g
5->0  2->0*: c f a b d e g
5->0* 2->1 : f a c b d e g
5->0  2->1*: f a c b d e g
5->0* 2->2 : f a b c d e g
5->0  2->2*: f a b c d e g
5->0* 2->3 : f a b c d e g
5->0  2->3*: f a b c d e g
5->0* 2->4 : f a b d c e g
5->0  2->4*: f a b d c e g
5->0* 2->5 : f a b d e c g
5->0  2->5*: f a b d e c g
5->0* 2->6 : f a b d e c g
5->0  2->6*: f a b d e c g
5->0* 2->7 : f a b d e g c
5->0  2->7*: f a b d e g c
5->0* 3->0 : f d a b c e g
5->0  3->0*: d f a b c e g
5->0* 3->1 : f a d b c e g
5->0  3->1*: f a d b c e g
5->0* 3->2 : f a b d c e g
5->0  3->2*: f a b d c e g
5->0* 3->3 : f a b c d e g
5->0  3->3*: f a b c d e g
5->0* 3->4 : f a b c d e g
5->0  3->4*: f a b c d e g
5->0* 3->5 : f a b c e d g
5->0  3->5*: f a b c e d g
5->0* 3->6 : f a b c e d g
5->0  3->6*: f a b c e d g
5->0* 3->7 : f a b c e g d
5->0  3->7*: f a b c e g d
5->0* 4->0 : f e a b c d g
5->0  4->0*: e f a b c d g
5->0* 4->1 : f a e b c d g
5->0  4->1*: f a e b c d g
5->0* 4->2 : f a b e c d g
5->0  4->2*: f a b e c d g
5->0* 4->3 : f a b c e d g
5->0  4->3*: f a b c e d g
5->0* 4->4 : f a b c d e g
5->0  4->4*: f a b c d e g
5->0* 4->5 : f a b c d e g
5->0  4->5*: f a b c d e g
5->0* 4->6 : f a b c d e g
5->0  4->6*: f a b c d e g
5->0* 4->7 : f a b c d g e
5->0  4->7*: f a b c d g e
5->0* 5->0 : f a b c d e g
5->0  5->0*: f a b c d e g
5->0* 5->1 : f a b c d e g
5->0  5->1*: a f b c d e g
5->0* 5->2 : f a b c d e g
5->0  5->2*: a b f c d e g
5->0* 5->3 : f a b c d e g
5->0  5->3*: a b c f d e g
5->0* 5->4 : f a b c d e g
5->0  5->4*: a b c d f e g
5->0* 5->5 : f a b c d e g
5->0  5->5*: f a b c d e g
5->0* 5->6 : f a b c d e g
5->0  5->6*: f a b c d e g
5->0* 5->7 : f a b c d e g
5->0  5->7*: a b c d e g f
5->0* 6->0 : f g a b c d e
5->0  6->0*: g f a b c d e
5->0* 6->1 : f a g b c d e
5->0  6->1*: f a g b c d e
5->0* 6->2 : f a b g c d e
5->0  6->2*: f a b g c d e
5->0* 6->3 : f a b c g d e
5->0  6->3*: f a b c g d e
5->0* 6->4 : f a b c d g e
5->0  6->4*: f a b c d g e
5->0* 6->5 : f a b c d e g
5->0  6->5*: f a b c d e g
5->0* 6->6 : f a b c d e g
5->0  6->6*: f a b c d e g
5->0* 6->7 : f a b c d e g
5->0  6->7*: f a b c d e g
5->1* 0->0 : a f b c d e g
5->1  0->0*: a f b c d e g
5->1* 0->1 : a f b c d e g
5->1  0->1*: a f b c d e g
5->1* 0->2 : f b a c d e g
5->1  0->2*: f b a c d e g
5->1* 0->3 : f b c a d e g
5->1  0->3*: f b c a d e g
5->1* 0->4 : f b c d a e g
5->1  0->4*: f b c d a e g
5->1* 0->5 : f b c d e a g
5->1  0->5*: f b c d e a g
5->1* 0->6 : f b c d e a g
5->1  0->6*: f b c d e a g
5->1* 0->7 : f b c d e g a
5->1  0->7*: f b c d e g a
5->1* 1->0 : b a f c d e g
5->1  1->0*: b a f c d e g
5->1* 1->1 : a f b c d e g
5->1  1->1*: a f b c d e g
5->1* 1->2 : a f b c d e g
5->1  1->2*: a f b c d e g
5->1* 1->3 : a f c b d e g
5->1  1->3*: a f c b d e g
5->1* 1->4 : a f c d b e g
5->1  1->4*: a f c d b e g
5->1* 1->5 : a f c d e b g
5->1  1->5*: a f c d e b g
5->1* 1->6 : a f c d e b g
5->1  1->6*: a f c d e b g
5->1* 1->7 : a f c d e g b
5->1  1->7*: a f c d e g b
5->1* 2->0 : c a f b d e g
5->1  2->0*: c a f b d e g
5->1* 2->1 : a f c b d e g
5->1  2->1*: a c f b d e g
5->1* 2->2 : a f b c d e g
5->1  2->2*: a f b c d e g
5->1* 2->3 : a f b c d e g
5->1  2->3*: a f b c d e g
5->1* 2->4 : a f b d c e g
5->1  2->4*: a f b d c e g
5->1* 2->5 : a f b d e c g
5->1  2->5*: a f b d e c g
5->1* 2->6 : a f b d e c g
5->1  2->6*: a f b d e c g
5->1* 2->7 : a f b d e g c
5->1  2->7*: a f b d e g c
5->1* 3->0 : d a f b c e g
5->1  3->0*: d a f b c e g
5->1* 3->1 : a f d b c e g
5->1  3->1*: a d f b c e g
5->1* 3->2 : a f b d c e g
5->1  3->2*: a f b d c e g
5->1* 3->3 : a f b c d e g
5->1  3->3*: a f b c d e g
5->1* 3->4 : a f b c d e g
5->1  3->4*: a f b c d e g
5->1* 3->5 : a f b c e d g
5->1  3->5*: a f b c e d g
5->1* 3->6 : a f b c e d g
5->1  3->6*: a f b c e d g
5->1* 3->7 : a f b c e g d
5->1  3->7*: a f b c e g d
5->1* 4->0 : e a f b c d g
5->1  4->0*: e a f b c d g
5->1* 4->1 : a f e b c d g
5->1  4->1*: a e f b c d g
5->1* 4->2 : a f b e c d g
5->1  4->2*: a f b e c d g
5->1* 4->3 : a f b c e d g
5->1  4->3*: a f b c e d g
5->1* 4->4 : a f b c d e g
5->1  4->4*: a f b c d e g
5->1* 4->5 : a f b c d e g
5->1  4->5*: a f b c d e g
5->1* 4->6 : a f b c d e g
5->1  4->6*: a f b c d e g
5->1* 4->7 : a f b c d g e
5->1  4->7*: a f b c d g e
5->1* 5->0 : a f b c d e g
5->1  5->0*: f a b c d e g
5->1* 5->1 : a f b c d e g
5->1  5->1*: a f b c d e g
5->1* 5->2 : a f b c d e g
5->1  5->2*: a b f c d e g
5->1* 5->3 : a f b c d e g
5->1  5->3*: a b c f d e g
5->1* 5->4 : a f b c d e g
5->1  5->4*: a b c d f e g
5->1* 5->5 : a f b c d e g
5->1  5->5*: a f b c d e g
5->1* 5->6 : a f b c d e g
5->1  5->6*: a f b c d e g
5->1* 5->7 : a f b c d e g
5->1  5->7*: a b c d e g f
5->1* 6->0 : g a f b c d e
5->1  6->0*: g a f b c d e
5->1* 6->1 : a f g b c d e
5->1  6->1*: a g f b c d e
5->1* 6->2 : a f b g c d e
5->1  6->2*: a f b g c d e
5->1* 6->3 : a f b c g d e
5->1  6->3*: a f b c g d e
5->1* 6->4 : a f b c d g e
5->1  6->4*: a f b c d g e
5->1* 6->5 : a f b c d e g
5->1  6->5*: a f b c d e g
5->1* 6->6 : a f b c d e g
5->1  6->6*: a f b c d e g
5->1* 6->7 : a f b c d e g
5->1  6->7*: a f b c d e g
5->2* 0->0 : a b f c d e g
5->2  0->0*: a b f c d e g
5->2* 0->1 : a b f c d e g
5->2  0->1*: a b f c d e g
5->2* 0->2 : b f a c d e g
5->2  0->2*: b a f c d e g
5->2* 0->3 : b f c a d e g
5->2  0->3*: b f c a d e g
5->2* 0->4 : b f c d a e g
5->2  0->4*: b f c d a e g
5->2* 0->5 : b f c d e a g
5->2  0->5*: b f c d e a g
5->2* 0->6 : b f c d e a g
5->2  0->6*: b f c d e a g
5->2* 0->7 : b f c d e g a
5->2  0->7*: b f c d e g a
5->2* 1->0 : b a f c d e g
5->2  1->0*: b a f c d e g
5->2* 1->1 : a b f c d e g
5->2  1->1*: a b f c d e g
5->2* 1->2 : a b f c d e g
5->2  1->2*: a b f c d e g
5->2* 1->3 : a f c b d e g
5->2  1->3*: a f c b d e g
5->2* 1->4 : a f c d b e g
5->2  1->4*: a f c d b e g
5->2* 1->5 : a f c d e b g
5->2  1->5*: a f c d e b g
5->2* 1->6 : a f c d e b g
5->2  1->6*: a f c d e b g
5->2* 1->7 : a f c d e g b
5->2  1->7*: a f c d e g b
5->2* 2->0 : c a b f d e g
5->2  2->0*: c a b f d e g
5->2* 2->1 : a c b f d e g
5->2  2->1*: a c b f d e g
5->2* 2->2 : a b f c d e g
5->2  2->2*: a b f c d e g
5->2* 2->3 : a b f c d e g
5->2  2->3*: a b f c d e g
5->2* 2->4 : a b f d c e g
5->2  2->4*: a b f d c e g
5->2* 2->5 : a b f d e c g
5->2  2->5*: a b f d e c g
5->2* 2->6 : a b f d e c g
5->2  2->6*: a b f d e c g
5->2* 2->7 : a b f d e g c
5->2  2->7*: a b f d e g c
5->2* 3->0 : d a b f c e g
5->2  3->0*: d a b f c e g
5->2* 3->1 : a d b f c e g
5->2  3->1*: a d b f c e g
5->2* 3->2 : a b f d c e g
5->2  3->2*: a b d f c e g
5->2* 3->3 : a b f c d e g
5->2  3->3*: a b f c d e g
5->2* 3->4 : a b f c d e g
5->2  3->4*: a b f c d e g
5->2* 3->5 : a b f c e d g
5->2  3->5*: a b f c e d g
5->2* 3->6 : a b f c e d g
5->2  3->6*: a b f c e d g
5->2* 3->7 : a b f c e g d
5->2  3->7*: a b f c e g d
5->2* 4->0 : e a b f c d g
5->2  4->0*: e a b f c d g
5->2* 4->1 : a e b f c d g
5->2  4->1*: a e b f c d g
5->2* 4->2 : a b f e c d g
5->2  4->2*: a b e f c d g
5->2* 4->3 : a b f c e d g
5->2  4->3*: a b f c e d g
5->2* 4->4 : a b f c d e g
5->2  4->4*: a b f c d e g
5->2* 4->5 : a b f c d e g
5->2  4->5*: a b f c d e g
5->2* 4->6 : a b f c d e g
5->2  4->6*: a b f c d e g
5->2* 4->7 : a b f c d g e
5->2  4->7*: a b f c d g e
5->2* 5->0 : a b f c d e g
5->2  5->0*: f a b c d e g
5->2* 5->1 : a b f c d e g
5->2  5->1*: a f b c d e g
5->2* 5->2 : a b f c d e g
5->2  5->2*: a b f c d e g
5->2* 5->3 : a b f c d e g
5->2  5->3*: a b c f d e g
5->2* 5->4 : a b f c d e g
5->2  5->4*: a b c d f e g
5->2* 5->5 : a b f c d e g
5->2  5->5*: a b f c d e g
5->2* 5->6 : a b f c d e g
5->2  5->6*: a b f c d e g
5->2* 5->7 : a b f c d e g
5->2  5->7*: a b c d e g f
5->2* 6->0 : g a b f c d e
5->2  6->0*: g a b f c d e
5->2* 6->1 : a g b f c d e
5->2  6->1*: a g b f c d e
5->2* 6->2 : a b f g c d e
5->2  6->2*: a b g f c d e
5->2* 6->3 : a b f c g d e
5->2  6->3*: a b f c g d e
5->2* 6->4 : a b f c d g e
5->2  6->4*: a b f c d g e
5->2* 6->5 : a b f c d e g
5->2  6->5*: a b f c d e g
5->2* 6->6 : a b f c d e g
5->2  6->6*: a b f c d e g
5->2* 6->7 : a b f c d e g
5->2  6->7*: a b f c d e g
5->3* 0->0 : a b c f d e g
5->3  0->0*: a b c f d e g
5->3* 0->1 : a b c f d e g
5->3  0->1*: a b c f d e g
5->3* 0->2 : b a c f d e g
5->3  0->2*: b a c f d e g
5->3* 0->3 : b c f a d e g
5->3  0->3*: b c a f d e g
5->3* 0->4 : b c f d a e g
5->3  0->4*: b c f d a e g
5->3* 0->5 : b c f d e a g
5->3  0->5*: b c f d e a g
5->3* 0->6 : b c f d e a g
5->3  0->6*: b c f d e a g
5->3* 0->7 : b c f d e g a
5->3  0->7*: b c f d e g a
5->3* 1->0 : b a c f d e g
5->3  1->0*: b a c f d e g
5->3* 1->1 : a b c f d e g
5->3  1->1*: a b c f d e g
5->3* 1->2 : a b c f d e g
5->3  1->2*: a b c f d e g
5->3* 1->3 : a c f b d e g
5->3  1->3*: a c b f d e g
5->3* 1->4 : a c f d b e g
5->3  1->4*: a c f d b e g
5->3* 1->5 : a c f d e b g
5->3  1->5*: a c f d e b g
5->3* 1->6 : a c f d e b g
5->3  1->6*: a c f d e b g
5->3* 1->7 : a c f d e g b
5->3  1->7*: a c f d e g b
5->3* 2->0 : c a b f d e g
5->3  2->0*: c a b f d e g
5->3* 2->1 : a c b f d e g
5->3  2->1*: a c b f d e g
5->3* 2->2 : a b c f d e g
5->3  2->2*: a b c f d e g
5->3* 2->3 : a b c f d e g
5->3  2->3*: a b c f d e g
5->3* 2->4 : a b f d c e g
5->3  2->4*: a b f d c e g
5->3* 2->5 : a b f d e c g
5->3  2->5*: a b f d e c g
5->3* 2->6 : a b f d e c g
5->3  2->6*: a b f d e c g
5->3* 2->7 : a b f d e g c
5->3  2->7*: a b f d e g c
5->3* 3->0 : d a b c f e g
5->3  3->0*: d a b c f e g
5->3* 3->1 : a d b c f e g
5->3  3->1*: a d b c f e g
5->3* 3->2 : a b d c f e g
5->3  3->2*: a b d c f e g
5->3* 3->3 : a b c f d e g
5->3  3->3*: a b c f d e g
5->3* 3->4 : a b c f d e g
5->3  3->4*: a b c f d e g
5->3* 3->5 : a b c f e d g
5->3  3->5*: a b c f e d g
5->3* 3->6 : a b c f e d g
5->3  3->6*: a b c f e d g
5->3* 3->7 : a b c f e g d
5->3  3->7*: a b c f e g d
5->3* 4->0 : e a b c f d g
5->3  4->0*: e a b c f d g
5->3* 4->1 : a e b c f d g
5->3  4->1*: a e b c f d g
5->3* 4->2 : a b e c f d g
5->3  4->2*: a b e c f d g
5->3* 4->3 : a b c f e d g
5->3  4->3*: a b c e f d g
5->3* 4->4 : a b c f d e g
5->3  4->4*: a b c f d e g
5->3* 4->5 : a b c f d e g
5->3  4->5*: a b c f d e g
5->3* 4->6 : a b c f d e g
5->3  4->6*: a b c f d e g
5->3* 4->7 : a b c f d g e
5->3  4->7*: a b c f d g e
5->3* 5->0 : a b c f d e g
5->3  5->0*: f a b c d e g
5->3* 5->1 : a b c f d e g
5->3  5->1*: a f b c d e g
5->3* 5->2 : a b c f d e g
5->3  5->2*: a b f c d e g
5->3* 5->3 : a b c f d e g
5->3  5->3*: a b c f d e g
5->3* 5->4 : a b c f d e g
5->3  5->4*: a b c d f e g
5->3* 5->5 : a b c f d e g
5->3  5->5*: a b c f d e g
5->3* 5->6 : a b c f d e g
5->3  5->6*: a b c f d e g
5->3* 5->7 : a b c f d e g
5->3  5->7*: a b c d e g f
5->3* 6->0 : g a b c f d e
5->3  6->0*: g a b c f d e
5->3* 6->1 : a g b c f d e
5->3  6->1*: a g b c f d e
5->3* 6->2 : a b g c f d e
5->3  6->2*: a b g c f d e
5->3* 6->3 : a b c f g d e
5->3  6->3*: a b c g f d e
5->3* 6->4 : a b c f d g e
5->3  6->4*: a b c f d g e
5->3* 6->5 : a b c f d e g
5->3  6->5*: a b c f d e g
5->3* 6->6 : a b c f d e g
5->3  6->6*: a b c f d e g
5->3* 6->7 : a b c f d e g
5->3  6->7*: a b c f d e g
5->4* 0->0 : a b c d f e g
5->4  0->0*: a b c d f e g
5->4* 0->1 : a b c d f e g
5->4  0->1*: a b c d f e g
5->4* 0->2 : b a c d f e g
5->4  0->2*: b a c d f e g
5->4* 0->3 : b c a d f e g
5->4  0->3*: b c a d f e g
5->4* 0->4 : b c d f a e g
5->4  0->4*: b c d a f e g
5->4* 0->5 : b c d f e a g
5->4  0->5*: b c d f e a g
5->4* 0->6 : b c d f e a g
5->4  0->6*: b c d f e a g
5->4* 0->7 : b c d f e g a
5->4  0->7*: b c d f e g a
5->4* 1->0 : b a c d f e g
5->4  1->0*: b a c d f e g
5->4* 1->1 : a b c d f e g
5->4  1->1*: a b c d f e g
5->4* 1->2 : a b c d f e g
5->4  1->2*: a b c d f e g
5->4* 1->3 : a c b d f e g
5->4  1->3*: a c b d f e g
5->4* 1->4 : a c d f b e g
5->4  1->4*: a c d b f e g
5->4* 1->5 : a c d f e b g
5->4  1->5*: a c d f e b g
5->4* 1->6 : a c d f e b g
5->4  1->6*: a c d f e b g
5->4* 1->7 : a c d f e g b
5->4  1->7*: a c d f e g b
5->4* 2->0 : c a b d f e g
5->4  2->0*: c a b d f e g
5->4* 2->1 : a c b d f e g
5->4  2->1*: a c b d f e g
5->4* 2->2 : a b c d f e g
5->4  2->2*: a b c d f e g
5->4* 2->3 : a b c d f e g
5->4  2->3*: a b c d f e g
5->4* 2->4 : a b d f c e g
5->4  2->4*: a b d c f e g
5->4* 2->5 : a b d f e c g
5->4  2->5*: a b d f e c g
5->4* 2->6 : a b d f e c g
5->4  2->6*: a b d f e c g
5->4* 2->7 : a b d f e g c
5->4  2->7*: a b d f e g c
5->4* 3->0 : d a b c f e g
5->4  3->0*: d a b c f e g
5->4* 3->1 : a d b c f e g
5->4  3->1*: a d b c f e g
5->4* 3->2 : a b d c f e g
5->4  3->2*: a b d c f e g
5->4* 3->3 : a b c d f e g
5->4  3->3*: a b c d f e g
5->4* 3->4 : a b c d f e g
5->4  3->4*: a b c d f e g
5->4* 3->5 : a b c f e d g
5->4  3->5*: a b c f e d g
5->4* 3->6 : a b c f e d g
5->4  3->6*: a b c f e d g
5->4* 3->7 : a b c f e g d
5->4  3->7*: a b c f e g d
5->4* 4->0 : e a b c d f g
5->4  4->0*: e a b c d f g
5->4* 4->1 : a e b c d f g
5->4  4->1*: a e b c d f g
5->4* 4->2 : a b e c d f g
5->4  4->2*: a b e c d f g
5->4* 4->3 : a b c e d f g
5->4  4->3*: a b c e d f g
5->4* 4->4 : a b c d f e g
5->4  4->4*: a b c d f e g
5->4* 4->5 : a b c d f e g
5->4  4->5*: a b c d f e g
5->4* 4->6 : a b c d f e g
5->4  4->6*: a b c d f e g
5->4* 4->7 : a b c d f g e
5->4  4->7*: a b c d f g e
5->4* 5->0 : a b c d f e g
5->4  5->0*: f a b c d e g
5->4* 5->1 : a b c d f e g
5->4  5->1*: a f b c d e g
5->4* 5->2 : a b c d f e g
5->4  5->2*: a b f c d e g
5->4* 5->3 : a b c d f e g
5->4  5->3*: a b c f d e g
5->4* 5->4 : a b c d f e g
5->4  5->4*: a b c d f e g
5->4* 5->5 : a b c d f e g
5->4  5->5*: a b c d f e g
5->4* 5->6 : a b c d f e g
5->4  5->6*: a b c d f e g
5->4* 5->7 : a b c d f e g
5->4  5->7*: a b c d e g f
5->4* 6->0 : g a b c d f e
5->4  6->0*: g a b c d f e
5->4* 6->1 : a g b c d f e
5->4  6->1*: a g b c d f e
5->4* 6->2 : a b g c d f e
5->4  6->2*: a b g c d f e
5->4* 6->3 : a b c g d f e
5->4  6->3*: a b c g d f e
5->4* 6->4 : a b c d f g e
5->4  6->4*: a b c d g f e
5->4* 6->5 : a b c d f e g
5->4  6->5*: a b c d f e g
5->4* 6->6 : a b c d f e g
5->4  6->6*: a b c d f e g
5->4* 6->7 : a b c d f e g
5->4  6->7*: a b c d f e g
5->5* 0->0 : a b c d e f g
5->5  0->0*: a b c d e f g
5->5* 0->1 : a b c d e f g
5->5  0->1*: a b c d e f g
5->5* 0->2 : b a c d e f g
5->5  0->2*: b a c d e f g
5->5* 0->3 : b c a d e f g
5->5  0->3*: b c a d e f g
5->5* 0->4 : b c d a e f g
5->5  0->4*: b c d a e f g
5->5* 0->5 : b c d e a f g
5->5  0->5*: b c d e a f g
5->5* 0->6 : b c d e f a g
5->5  0->6*: b c d e f a g
5->5* 0->7 : b c d e f g a
5->5  0->7*: b c d e f g a
5->5* 1->0 : b a c d e f g
5->5  1->0*: b a c d e f g
5->5* 1->1 : a b c d e f g
5->5  1->1*: a b c d e f g
5->5* 1->2 : a b c d e f g
5->5  1->2*: a b c d e f g
5->5* 1->3 : a c b d e f g
5->5  1->3*: a c b d e f g
5->5* 1->4 : a c d b e f g
5->5  1->4*: a c d b e f g
5->5* 1->5 : a c d e b f g
5->5  1->5*: a c d e b f g
5->5* 1->6 : a c d e f b g
5->5  1->6*: a c d e f b g
5->5* 1->7 : a c d e f g b
5->5  1->7*: a c d e f g b
5->5* 2->0 : c a b d e f g
5->5  2->0*: c a b d e f g
5->5* 2->1 : a c b d e f g
5->5  2->1*: a c b d e f g
5->5* 2->2 : a b c d e f g
5->5  2->2*: a b c d e f g
5->5* 2->3 : a b c d e f g
5->5  2->3*: a b c d e f g
5->5* 2->4 : a b d c e f g
5->5  2->4*: a b d c e f g
5->5* 2->5 : a b d e c f g
5->5  2->5*: a b d e c f g
5->5* 2->6 : a b d e f c g
5->5  2->6*: a b d e f c g
5->5* 2->7 : a b d e f g c
5->5  2->7*: a b d e f g c
5->5* 3->0 : d a b c e f g
5->5  3->0*: d a b c e f g
5->5* 3->1 : a d b c e f g
5->5  3->1*: a d b c e f g
5->5* 3->2 : a b d c e f g
5->5  3->2*: a b d c e f g
5->5* 3->3 : a b c d e f g
5->5  3->3*: a b c d e f g
5->5* 3->4 : a b c d e f g
5->5  3->4*: a b c d e f g
5->5* 3->5 : a b c e d f g
5->5  3->5*: a b c e d f g
5->5* 3->6 : a b c e f d g
5->5  3->6*: a b c e f d g
5->5* 3->7 : a b c e f g d
5->5  3->7*: a b c e f g d
5->5* 4->0 : e a b c d f g
5->5  4->0*: e a b c d f g
5->5* 4->1 : a e b c d f g
5->5  4->1*: a e b c d f g
5->5* 4->2 : a b e c d f g
5->5  4->2*: a b e c d f g
5->5* 4->3 : a b c e d f g
5->5  4->3*: a b c e d f g
5->5* 4->4 : a b c d e f g
5->5  4->4*: a b c d e f g
5->5* 4->5 : a b c d e f g
5->5  4->5*: a b c d e f g
5->5* 4->6 : a b c d f e g
5->5  4->6*: a b c d f e g
5->5* 4->7 : a b c d f g e
5->5  4->7*: a b c d f g e
5->5* 5->0 : f a b c d e g
5->5  5->0*: f a b c d e g
5->5* 5->1 : a f b c d e g
5->5  5->1*: a f b c d e g
5->5* 5->2 : a b f c d e g
5->5  5->2*: a b f c d e g
5->5* 5->3 : a b c f d e g
5->5  5->3*: a b c f d e g
5->5* 5->4 : a b c d f e g
5->5  5->4*: a b c d f e g
5->5* 5->5 : a b c d e f g
5->5  5->5*: a b c d e f g
5->5* 5->6 : a b c d e f g
5->5  5->6*: a b c d e f g
5->5* 5->7 : a b c d e g f
5->5  5->7*: a b c d e g f
5->5* 6->0 : g a b c d e f
5->5  6->0*: g a b c d e f
5->5* 6->1 : a g b c d e f
5->5  6->1*: a g b c d e f
5->5* 6->2 : a b g c d e f
5->5  6->2*: a b g c d e f
5->5* 6->3 : a b c g d e f
5->5  6->3*: a b c g d e f
5->5* 6->4 : a b c d g e f
5->5  6->4*: a b c d g e f
5->5* 6->5 : a b c d e g f
5->5  6->5*: a b c d e g f
5->5* 6->6 : a b c d e f g
5->5  6->6*: a b c d e f g
5->5* 6->7 : a b c d e f g
5->5  6->7*: a b c d e f g
5->6* 0->0 : a b c d e f g
5->6  0->0*: a b c d e f g
5->6* 0->1 : a b c d e f g
5->6  0->1*: a b c d e f g
5->6* 0->2 : b a c d e f g
5->6  0->2*: b a c d e f g
5->6* 0->3 : b c a d e f g
5->6  0->3*: b c a d e f g
5->6* 0->4 : b c d a e f g
5->6  0->4*: b c d a e f g
5->6* 0->5 : b c d e a f g
5->6  0->5*: b c d e a f g
5->6* 0->6 : b c d e f a g
5->6  0->6*: b c d e f a g
5->6* 0->7 : b c d e f g a
5->6  0->7*: b c d e f g a
5->6* 1->0 : b a c d e f g
5->6  1->0*: b a c d e f g
5->6* 1->1 : a b c d e f g
5->6  1->1*: a b c d e f g
5->6* 1->2 : a b c d e f g
5->6  1->2*: a b c d e f g
5->6* 1->3 : a c b d e f g
5->6  1->3*: a c b d e f g
5->6* 1->4 : a c d b e f g
5->6  1->4*: a c d b e f g
5->6* 1->5 : a c d e b f g
5->6  1->5*: a c d e b f g
5->6* 1->6 : a c d e f b g
5->6  1->6*: a c d e f b g
5->6* 1->7 : a c d e f g b
5->6  1->7*: a c d e f g b
5->6* 2->0 : c a b d e f g
5->6  2->0*: c a b d e f g
5->6* 2->1 : a c b d e f g
5->6  2->1*: a c b d e f g
5->6* 2->2 : a b c d e f g
5->6  2->2*: a b c d e f g
5->6* 2->3 : a b c d e f g
5->6  2->3*: a b c d e f g
5->6* 2->4 : a b d c e f g
5->6  2->4*: a b d c e f g
5->6* 2->5 : a b d e c f g
5->6  2->5*: a b d e c f g
5->6* 2->6 : a b d e f c g
5->6  2->6*: a b d e f c g
5->6* 2->7 : a b d e f g c
5->6  2->7*: a b d e f g c
5->6* 3->0 : d a b c e f g
5->6  3->0*: d a b c e f g
5->6* 3->1 : a d b c e f g
5->6  3->1*: a d b c e f g
5->6* 3->2 : a b d c e f g
5->6  3->2*: a b d c e f g
5->6* 3->3 : a b c d e f g
5->6  3->3*: a b c d e f g
5->6* 3->4 : a b c d e f g
5->6  3->4*: a b c d e f g
5->6* 3->5 : a b c e d f g
5->6  3->5*: a b c e d f g
5->6* 3->6 : a b c e f d g
5->6  3->6*: a b c e f d g
5->6* 3->7 : a b c e f g d
5->6  3->7*: a b c e f g d
5->6* 4->0 : e a b c d f g
5->6  4->0*: e a b c d f g
5->6* 4->1 : a e b c d f g
5->6  4->1*: a e b c d f g
5->6* 4->2 : a b e c d f g
5->6  4->2*: a b e c d f g
5->6* 4->3 : a b c e d f g
5->6  4->3*: a b c e d f g
5->6* 4->4 : a b c d e f g
5->6  4->4*: a b c d e f g
5->6* 4->5 : a b c d e f g
5->6  4->5*: a b c d e f g
5->6* 4->6 : a b c d f e g
5->6  4->6*: a b c d f e g
5->6* 4->7 : a b c d f g e
5->6  4->7*: a b c d f g e
5->6* 5->0 : f a b c d e g
5->6  5->0*: f a b c d e g
5->6* 5->1 : a f b c d e g
5->6  5->1*: a f b c d e g
5->6* 5->2 : a b f c d e g
5->6  5->2*: a b f c d e g
5->6* 5->3 : a b c f d e g
5->6  5->3*: a b c f d e g
5->6* 5->4 : a b c d f e g
5->6  5->4*: a b c d f e g
5->6* 5->5 : a b c d e f g
5->6  5->5*: a b c d e f g
5->6* 5->6 : a b c d e f g
5->6  5->6*: a b c d e f g
5->6* 5->7 : a b c d e g f
5->6  5->7*: a b c d e g f
5->6* 6->0 : g a b c d e f
5->6  6->0*: g a b c d e f
5->6* 6->1 : a g b c d e f
5->6  6->1*: a g b c d e f
5->6* 6->2 : a b g c d e f
5->6  6->2*: a b g c d e f
5->6* 6->3 : a b c g d e f
5->6  6->3*: a b c g d e f
5->6* 6->4 : a b c d g e f
5->6  6->4*: a b c d g e f
5->6* 6->5 : a b c d e g f
5->6  6->5*: a b c d e g f
5->6* 6->6 : a b c d e f g
5->6  6->6*: a b c d e f g
5->6* 6->7 : a b c d e f g
5->6  6->7*: a b c d e f g
5->7* 0->0 : a b c d e g f
5->7  0->0*: a b c d e g f
5->7* 0->1 : a b c d e g f
5->7  0->1*: a b c d e g f
5->7* 0->2 : b a c d e g f
5->7  0->2*: b a c d e g f
5->7* 0->3 : b c a d e g f
5->7  0->3*: b c a d e g f
5->7* 0->4 : b c d a e g f
5->7  0->4*: b c d a e g f
5->7* 0->5 : b c d e a g f
5->7  0->5*: b c d e a g f
5->7* 0->6 : b c d e a g f
5->7  0->6*: b c d e a g f
5->7* 0->7 : b c d e g f a
5->7  0->7*: b c d e g a f
5->7* 1->0 : b a c d e g f
5->7  1->0*: b a c d e g f
5->7* 1->1 : a b c d e g f
5->7  1->1*: a b c d e g f
5->7* 1->2 : a b c d e g f
5->7  1->2*: a b c d e g f
5->7* 1->3 : a c b d e g f
5->7  1->3*: a c b d e g f
5->7* 1->4 : a c d b e g f
5->7  1->4*: a c d b e g f
5->7* 1->5 : a c d e b g f
5->7  1->5*: a c d e b g f
5->7* 1->6 : a c d e b g f
5->7  1->6*: a c d e b g f
5->7* 1->7 : a c d e g f b
5->7  1->7*: a c d e g b f
5->7* 2->0 : c a b d e g f
5->7  2->0*: c a b d e g f
5->7* 2->1 : a c b d e g f
5->7  2->1*: a c b d e g f
5->7* 2->2 : a b c d e g f
5->7  2->2*: a b c d e g f
5->7* 2->3 : a b c d e g f
5->7  2->3*: a b c d e g f
5->7* 2->4 : a b d c e g f
5->7  2->4*: a b d c e g f
5->7* 2->5 : a b d e c g f
5->7  2->5*: a b d e c g f
5->7* 2->6 : a b d e c g f
5->7  2->6*: a b d e c g f
5->7* 2->7 : a b d e g f c
5->7  2->7*: a b d e g c f
5->7* 3->0 : d a b c e g f
5->7  3->0*: d a b c e g f
5->7* 3->1 : a d b c e g f
5->7  3->1*: a d b c e g f
5->7* 3->2 : a b d c e g f
5->7  3->2*: a b d c e g f
5->7* 3->3 : a b c d e g f
5->7  3->3*: a b c d e g f
5->7* 3->4 : a b c d e g f
5->7  3->4*: a b c d e g f
5->7* 3->5 : a b c e d g f
5->7  3->5*: a b c e d g f
5->7* 3->6 : a b c e d g f
5->7  3->6*: a b c e d g f
5->7* 3->7 : a b c e g f d
5->7  3->7*: a b c e g d f
5->7* 4->0 : e a b c d g f
5->7  4->0*: e a b c d g f
5->7* 4->1 : a e b c d g f
5->7  4->1*: a e b c d g f
5->7* 4->2 : a b e c d g f
5->7  4->2*: a b e c d g f
5->7* 4->3 : a b c e d g f
5->7  4->3*: a b c e d g f
5->7* 4->4 : a b c d e g f
5->7  4->4*: a b c d e g f
5->7* 4->5 : a b c d e g f
5->7  4->5*: a b c d e g f
5->7* 4->6 : a b c d e g f
5->7  4->6*: a b c d e g f
5->7* 4->7 : a b c d g f e
5->7  4->7*: a b c d g e f
5->7* 5->0 : a b c d e g f
5->7  5->0*: f a b c d e g
5->7* 5->1 : a b c d e g f
5->7  5->1*: a f b c d e g
5->7* 5->2 : a b c d e g f
5->7  5->2*: a b f c d e g
5->7* 5->3 : a b c d e g f
5->7  5->3*: a b c f d e g
5->7* 5->4 : a b c d e g f
5->7  5->4*: a b c d f e g
5->7* 5->5 : a b c d e g f
5->7  5->5*: a b c d e g f
5->7* 5->6 : a b c d e g f
5->7  5->6*: a b c d e g f
5->7* 5->7 : a b c d e g f
5->7  5->7*: a b c d e g f
5->7* 6->0 : g a b c d e f
5->7  6->0*: g a b c d e f
5->7* 6->1 : a g b c d e f
5->7  6->1*: a g b c d e f
5->7* 6->2 : a b g c d e f
5->7  6->2*: a b g c d e f
5->7* 6->3 : a b c g d e f
5->7  6->3*: a b c g d e f
5->7* 6->4 : a b c d g e f
5->7  6->4*: a b c d g e f
5->7* 6->5 : a b c d e g f
5->7  6->5*: a b c d e g f
5->7* 6->6 : a b c d e g f
5->7  6->6*: a b c d e g f
5->7* 6->7 : a b c d e g f
5->7  6->7*: a b c d e g f
6->0* 0->0 : g a b c d e f
6->0  0->0*: g a b c d e f
6->0* 0->1 : g a b c d e f
6->0  0->1*: g a b c d e f
6->0* 0->2 : g b a c d e f
6->0  0->2*: g b a c d e f
6->0* 0->3 : g b c a d e f
6->0  0->3*: g b c a d e f
6->0* 0->4 : g b c d a e f
6->0  0->4*: g b c d a e f
6->0* 0->5 : g b c d e a f
6->0  0->5*: g b c d e a f
6->0* 0->6 : g b c d e f a
6->0  0->6*: g b c d e f a
6->0* 0->7 : g b c d e f a
6->0  0->7*: g b c d e f a
6->0* 1->0 : g b a c d e f
6->0  1->0*: b g a c d e f
6->0* 1->1 : g a b c d e f
6->0  1->1*: g a b c d e f
6->0* 1->2 : g a b c d e f
6->0  1->2*: g a b c d e f
6->0* 1->3 : g a c b d e f
6->0  1->3*: g a c b d e f
6->0* 1->4 : g a c d b e f
6->0  1->4*: g a c d b e f
6->0* 1->5 : g a c d e b f
6->0  1->5*: g a c d e b f
6->0* 1->6 : g a c d e f b
6->0  1->6*: g a c d e f b
6->0* 1->7 : g a c d e f b
6->0  1->7*: g a c d e f b
6->0* 2->0 : g c a b d e f
6->0  2->0*: c g a b d e f
6->0* 2->1 : g a c b d e f
6->0  2->1*: g a c b d e f
6->0* 2->2 : g a b c d e f
6->0  2->2*: g a b c d e f
6->0* 2->3 : g a b c d e f
6->0  2->3*: g a b c d e f
6->0* 2->4 : g a b d c e f
6->0  2->4*: g a b d c e f
6->0* 2->5 : g a b d e c f
6->0  2->5*: g a b d e c f
6->0* 2->6 : g a b d e f c
6->0  2->6*: g a b d e f c
6->0* 2->7 : g a b d e f c
6->0  2->7*: g a b d e f c
6->0* 3->0 : g d a b c e f
6->0  3->0*: d g a b c e f
6->0* 3->1 : g a d b c e f
6->0  3->1*: g a d b c e f
6->0* 3->2 : g a b d c e f
6->0  3->2*: g a b d c e f
6->0* 3->3 : g a b c d e f
6->0  3->3*: g a b c d e f
6->0* 3->4 : g a b c d e f
6->0  3->4*: g a b c d e f
6->0* 3->5 : g a b c e d f
6->0  3->5*: g a b c e d f
6->0* 3->6 : g a b c e f d
6->0  3->6*: g a b c e f d
6->0* 3->7 : g a b c e f d
6->0  3->7*: g a b c e f d
6->0* 4->0 : g e a b c d f
6->0  4->0*: e g a b c d f
6->0* 4->1 : g a e b c d f
6->0  4->1*: g a e b c d f
6->0* 4->2 : g a b e c d f
6->0  4->2*: g a b e c d f
6->0* 4->3 : g a b c e d f
6->0  4->3*: g a b c e d f
6->0* 4->4 : g a b c d e f
6->0  4->4*: g a b c d e f
6->0* 4->5 : g a b c d e f
6->0  4->5*: g a b c d e f
6->0* 4->6 : g a b c d f e
6->0  4->6*: g a b c d f e
6->0* 4->7 : g a b c d f e
6->0  4->7*: g a b c d f e
6->0* 5->0 : g f a b c d e
6->0  5->0*: f g a b c d e
6->0* 5->1 : g a f b c d e
6->0  5->1*: g a f b c d e
6->0* 5->2 : g a b f c d e
6->0  5->2*: g a b f c d e
6->0* 5->3 : g a b c f d e
6->0  5->3*: g a b c f d e
6->0* 5->4 : g a b c d f e
6->0  5->4*: g a b c d f e
6->0* 5->5 : g a b c d e f
6->0  5->5*: g a b c d e f
6->0* 5->6 : g a b c d e f
6->0  5->6*: g a b c d e f
6->0* 5->7 : g a b c d e f
6->0  5->7*: g a b c d e f
6->0* 6->0 : g a b c d e f
6->0  6->0*: g a b c d e f
6->0* 6->1 : g a b c d e f
6->0  6->1*: a g b c d e f
6->0* 6->2 : g a b c d e f
6->0  6->2*: a b g c d e f
6->0* 6->3 : g a b c d e f
6->0  6->3*: a b c g d e f
6->0* 6->4 : g a b c d e f
6->0  6->4*: a b c d g e f
6->0* 6->5 : g a b c d e f
6->0  6->5*: a b c d e g f
6->0* 6->6 : g a b c d e f
6->0  6->6*: g a b c d e f
6->0* 6->7 : g a b c d e f
6->0  6->7*: g a b c d e f
6->1* 0->0 : a g b c d e f
6->1  0->0*: a g b c d e f
6->1* 0->1 : a g b c d e f
6->1  0->1*: a g b c d e f
6->1* 0->2 : g b a c d e f
6->1  0->2*: g b a c d e f
6->1* 0->3 : g b c a d e f
6->1  0->3*: g b c a d e f
6->1* 0->4 : g b c d a e f
6->1  0->4*: g b c d a e f
6->1* 0->5 : g b c d e a f
6->1  0->5*: g b c d e a f
6->1* 0->6 : g b c d e f a
6->1  0->6*: g b c d e f a
6->1* 0->7 : g b c d e f a
6->1  0->7*: g b c d e f a
6->1* 1->0 : b a g c d e f
6->1  1->0*: b a g c d e f
6->1* 1->1 : a g b c d e f
6->1  1->1*: a g b c d e f
6->1* 1->2 : a g b c d e f
6->1  1->2*: a g b c d e f
6->1* 1->3 : a g c b d e f
6->1  1->3*: a g c b d e f
6->1* 1->4 : a g c d b e f
6->1  1->4*: a g c d b e f
6->1* 1->5 : a g c d e b f
6->1  1->5*: a g c d e b f
6->1* 1->6 : a g c d e f b
6->1  1->6*: a g c d e f b
6->1* 1->7 : a g c d e f b
6->1  1->7*: a g c d e f b
6->1* 2->0 : c a g b d e f
6->1  2->0*: c a g b d e f
6->1* 2->1 : a g c b d e f
6->1  2->1*: a c g b d e f
6->1* 2->2 : a g b c d e f
6->1  2->2*: a g b c d e f
6->1* 2->3 : a g b c d e f
6->1  2->3*: a g b c d e f
6->1* 2->4 : a g b d c e f
6->1  2->4*: a g b d c e f
6->1* 2->5 : a g b d e c f
6->1  2->5*: a g b d e c f
6->1* 2->6 : a g b d e f c
6->1  2->6*: a g b d e f c
6->1* 2->7 : a g b d e f c
6->1  2->7*: a g b d e f c
6->1* 3->0 : d a g b c e f
6->1  3->0*: d a g b c e f
6->1* 3->1 : a g d b c e f
6->1  3->1*: a d g b c e f
6->1* 3->2 : a g b d c e f
6->1  3->2*: a g b d c e f
6->1* 3->3 : a g b c d e f
6->1  3->3*: a g b c d e f
6->1* 3->4 : a g b c d e f
6->1  3->4*: a g b c d e f
6->1* 3->5 : a g b c e d f
6->1  3->5*: a g b c e d f
6->1* 3->6 : a g b c e f d
6->1  3->6*: a g b c e f d
6->1* 3->7 : a g b c e f d
6->1  3->7*: a g b c e f d
6->1* 4->0 : e a g b c d f
6->1  4->0*: e a g b c d f
6->1* 4->1 : a g e b c d f
6->1  4->1*: a e g b c d f
6->1* 4->2 : a g b e c d f
6->1  4->2*: a g b e c d f
6->1* 4->3 : a g b c e d f
6->1  4->3*: a g b c e d f
6->1* 4->4 : a g b c d e f
6->1  4->4*: a g b c d e f
6->1* 4->5 : a g b c d e f
6->1  4->5*: a g b c d e f
6->1* 4->6 : a g b c d f e
6->1  4->6*: a g b c d f e
6->1* 4->7 : a g b c d f e
6->1  4->7*: a g b c d f e
6->1* 5->0 : f a g b c d e
6->1  5->0*: f a g b c d e
6->1* 5->1 : a g f b c d e
6->1  5->1*: a f g b c d e
6->1* 5->2 : a g b f c d e
6->1  5->2*: a g b f c d e
6->1* 5->3 : a g b c f d e
6->1  5->3*: a g b c f d e
6->1* 5->4 : a g b c d f e
6->1  5->4*: a g b c d f e
6->1* 5->5 : a g b c d e f
6->1  5->5*: a g b c d e f
6->1* 5->6 : a g b c d e f
6->1  5->6*: a g b c d e f
6->1* 5->7 : a g b c d e f
6->1  5->7*: a g b c d e f
6->1* 6->0 : a g b c d e f
6->1  6->0*: g a b c d e f
6->1* 6->1 : a g b c d e f
6->1  6->1*: a g b c d e f
6->1* 6->2 : a g b c d e f
6->1  6->2*: a b g c d e f
6->1* 6->3 : a g b c d e f
6->1  6->3*: a b c g d e f
6->1* 6->4 : a g b c d e f
6->1  6->4*: a b c d g e f
6->1* 6->5 : a g b c d e f
6->1  6->5*: a b c d e g f
6->1* 6->6 : a g b c d e f
6->1  6->6*: a g b c d e f
6->1* 6->7 : a g b c d e f
6->1  6->7*: a g b c d e f
6->2* 0->0 : a b g c d e f
6->2  0->0*: a b g c d e f
6->2* 0->1 : a b g c d e f
6->2  0->1*: a b g c d e f
6->2* 0->2 : b g a c d e f
6->2  0->2*: b a g c d e f
6->2* 0->3 : b g c a d e f
6->2  0->3*: b g c a d e f
6->2* 0->4 : b g c d a e f
6->2  0->4*: b g c d a e f
6->2* 0->5 : b g c d e a f
6->2  0->5*: b g c d e a f
6->2* 0->6 : b g c d e f a
6->2  0->6*: b g c d e f a
6->2* 0->7 : b g c d e f a
6->2  0->7*: b g c d e f a
6->2* 1->0 : b a g c d e f
6->2  1->0*: b a g c d e f
6->2* 1->1 : a b g c d e f
6->2  1->1*: a b g c d e f
6->2* 1->2 : a b g c d e f
6->2  1->2*: a b g c d e f
6->2* 1->3 : a g c b d e f
6->2  1->3*: a g c b d e f
6->2* 1->4 : a g c d b e f
6->2  1->4*: a g c d b e f
6->2* 1->5 : a g c d e b f
6->2  1->5*: a g c d e b f
6->2* 1->6 : a g c d e f b
6->2  1->6*: a g c d e f b
6->2* 1->7 : a g c d e f b
6->2  1->7*: a g c d e f b
6->2* 2->0 : c a b g d e f
6->2  2->0*: c a b g d e f
6->2* 2->1 : a c b g d e f
6->2  2->1*: a c b g d e f
6->2* 2->2 : a b g c d e f
6->2  2->2*: a b g c d e f
6->2* 2->3 : a b g c d e f
6->2  2->3*: a b g c d e f
6->2* 2->4 : a b g d c e f
6->2  2->4*: a b g d c e f
6->2* 2->5 : a b g d e c f
6->2  2->5*: a b g d e c f
6->2* 2->6 : a b g d e f c
6->2  2->6*: a b g d e f c
6->2* 2->7 : a b g d e f c
6->2  2->7*: a b g d e f c
6->2* 3->0 : d a b g c e f
6->2  3->0*: d a b g c e f
6->2* 3->1 : a d b g c e f
6->2  3->1*: a d b g c e f
6->2* 3->2 : a b g d c e f
6->2  3->2*: a b d g c e f
6->2* 3->3 : a b g c d e f
6->2  3->3*: a b g c d e f
6->2* 3->4 : a b g c d e f
6->2  3->4*: a b g c d e f
6->2* 3->5 : a b g c e d f
6->2  3->5*: a b g c e d f
6->2* 3->6 : a b g c e f d
6->2  3->6*: a b g c e f d
6->2* 3->7 : a b g c e f d
6->2  3->7*: a b g c e f d
6->2* 4->0 : e a b g c d f
6->2  4->0*: e a b g c d f
6->2* 4->1 : a e b g c d f
6->2  4->1*: a e b g c d f
6->2* 4->2 : a b g e c d f
6->2  4->2*: a b e g c d f
6->2* 4->3 : a b g c e d f
6->2  4->3*: a b g c e d f
6->2* 4->4 : a b g c d e f
6->2  4->4*: a b g c d e f
6->2* 4->5 : a b g c d e f
6->2  4->5*: a b g c d e f
6->2* 4->6 : a b g c d f e
6->2  4->6*: a b g c d f e
6->2* 4->7 : a b g c d f e
6->2  4->7*: a b g c d f e
6->2* 5->0 : f a b g c d e
6->2  5->0*: f a b g c d e
6->2* 5->1 : a f b g c d e
6->2  5->1*: a f b g c d e
6->2* 5->2 : a b g f c d e
6->2  5->2*: a b f g c d e
6->2* 5->3 : a b g c f d e
6->2  5->3*: a b g c f d e
6->2* 5->4 : a b g c d f e
6->2  5->4*: a b g c d f e
6->2* 5->5 : a b g c d e f
6->2  5->5*: a b g c d e f
6->2* 5->6 : a b g c d e f
6->2  5->6*: a b g c d e f
6->2* 5->7 : a b g c d e f
6->2  5->7*: a b g c d e f
6->2* 6->0 : a b g c d e f
6->2  6->0*: g a b c d e f
6->2* 6->1 : a b g c d e f
6->2  6->1*: a g b c d e f
6->2* 6->2 : a b g c d e f
6->2  6->2*: a b g c d e f
6->2* 6->3 : a b g c d e f
6->2  6->3*: a b c g d e f
6->2* 6->4 : a b g c d e f
6->2  6->4*: a b c d g e f
6->2* 6->5 : a b g c d e f
6->2  6->5*: a b c d e g f
6->2* 6->6 : a b g c d e f
6->2  6->6*: a b g c d e f
6->2* 6->7 : a b g c d e f
6->2  6->7*: a b g c d e f
6->3* 0->0 : a b c g d e f
6->3  0->0*: a b c g d e f
6->3* 0->1 : a b c g d e f
6->3  0->1*: a b c g d e f
6->3* 0->2 : b a c g d e f
6->3  0->2*: b a c g d e f
6->3* 0->3 : b c g a d e f
6->3  0->3*: b c a g d e f
6->3* 0->4 : b c g d a e f
6->3  0->4*: b c g d a e f
6->3* 0->5 : b c g d e a f
6->3  0->5*: b c g d e a f
6->3* 0->6 : b c g d e f a
6->3  0->6*: b c g d e f a
6->3* 0->7 : b c g d e f a
6->3  0->7*: b c g d e f a
6->3* 1->0 : b a c g d e f
6->3  1->0*: b a c g d e f
6->3* 1->1 : a b c g d e f
6->3  1->1*: a b c g d e f
6->3* 1->2 : a b c g d e f
6->3  1->2*: a b c g d e f
6->3* 1->3 : a c g b d e f
6->3  1->3*: a c b g d e f
6->3* 1->4 : a c g d b e f
6->3  1->4*: a c g d b e f
6->3* 1->5 : a c g d e b f
6->3  1->5*: a c g d e b f
6->3* 1->6 : a c g d e f b
6->3  1->6*: a c g d e f b
6->3* 1->7 : a c g d e f b
6->3  1->7*: a c g d e f b
6->3* 2->0 : c a b g d e f
6->3  2->0*: c a b g d e f
6->3* 2->1 : a c b g d e f
6->3  2->1*: a c b g d e f
6->3* 2->2 : a b c g d e f
6->3  2->2*: a b c g d e f
6->3* 2->3 : a b c g d e f
6->3  2->3*: a b c g d e f
6->3* 2->4 : a b g d c e f
6->3  2->4*: a b g d c e f
6->3* 2->5 : a b g d e c f
6->3  2->5*: a b g d e c f
6->3* 2->6 : a b g d e f c
6->3  2->6*: a b g d e f c
6->3* 2->7 : a b g d e f c
6->3  2->7*: a b g d e f c
6->3* 3->0 : d a b c g e f
6->3  3->0*: d a b c g e f
6->3* 3->1 : a d b c g e f
6->3  3->1*: a d b c g e f
6->3* 3->2 : a b d c g e f
6->3  3->2*: a b d c g e f
6->3* 3->3 : a b c g d e f
6->3  3->3*: a b c g d e f
6->3* 3->4 : a b c g d e f
6->3  3->4*: a b c g d e f
6->3* 3->5 : a b c g e d f
6->3  3->5*: a b c g e d f
6->3* 3->6 : a b c g e f d
6->3  3->6*: a b c g e f d
6->3* 3->7 : a b c g e f d
6->3  3->7*: a b c g e f d
6->3* 4->0 : e a b c g d f
6->3  4->0*: e a b c g d f
6->3* 4->1 : a e b c g d f
6->3  4->1*: a e b c g d f
6->3* 4->2 : a b e c g d f
6->3  4->2*: a b e c g d f
6->3* 4->3 : a b c g e d f
6->3  4->3*: a b c e g d f
6->3* 4->4 : a b c g d e f
6->3  4->4*: a b c g d e f
6->3* 4->5 : a b c g d e f
6->3  4->5*: a b c g d e f
6->3* 4->6 : a b c g d f e
6->3  4->6*: a b c g d f e
6->3* 4->7 : a b c g d f e
6->3  4->7*: a b c g d f e
6->3* 5->0 : f a b c g d e
6->3  5->0*: f a b c g d e
6->3* 5->1 : a f b c g d e
6->3  5->1*: a f b c g d e
6->3* 5->2 : a b f c g d e
6->3  5->2*: a b f c g d e
6->3* 5->3 : a b c g f d e
6->3  5->3*: a b c f g d e
6->3* 5->4 : a b c g d f e
6->3  5->4*: a b c g d f e
6->3* 5->5 : a b c g d e f
6->3  5->5*: a b c g d e f
6->3* 5->6 : a b c g d e f
6->3  5->6*: a b c g d e f
6->3* 5->7 : a b c g d e f
6->3  5->7*: a b c g d e f
6->3* 6->0 : a b c g d e f
6->3  6->0*: g a b c d e f
6->3* 6->1 : a b c g d e f
6->3  6->1*: a g b c d e f
6->3* 6->2 : a b c g d e f
6->3  6->2*: a b g c d e f
6->3* 6->3 : a b c g d e f
6->3  6->3*: a b c g d e f
6->3* 6->4 : a b c g d e f
6->3  6->4*: a b c d g e f
6->3* 6->5 : a b c g d e f
6->3  6->5*: a b c d e g f
6->3* 6->6 : a b c g d e f
6->3  6->6*: a b c g d e f
6->3* 6->7 : a b c g d e f
6->3  6->7*: a b c g d e f
6->4* 0->0 : a b c d g e f
6->4  0->0*: a b c d g e f
6->4* 0->1 : a b c d g e f
6->4  0->1*: a b c d g e f
6->4* 0->2 : b a c d g e f
6->4  0->2*: b a c d g e f
6->4* 0->3 : b c a d g e f
6->4  0->3*: b c a d g e f
6->4* 0->4 : b c d g a e f
6->4  0->4*: b c d a g e f
6->4* 0->5 : b c d g e a f
6->4  0->5*: b c d g e a f
6->4* 0->6 : b c d g e f a
6->4  0->6*: b c d g e f a
6->4* 0->7 : b c d g e f a
6->4  0->7*: b c d g e f a
6->4* 1->0 : b a c d g e f
6->4  1->0*: b a c d g e f
6->4* 1->1 : a b c d g e f
6->4  1->1*: a b c d g e f
6->4* 1->2 : a b c d g e f
6->4  1->2*: a b c d g e f
6->4* 1->3 : a c b d g e f
6->4  1->3*: a c b d g e f
6->4* 1->4 : a c d g b e f
6->4  1->4*: a c d b g e f
6->4* 1->5 : a c d g e b f
6->4  1->5*: a c d g e b f
6->4* 1->6 : a c d g e f b
6->4  1->6*: a c d g e f b
6->4* 1->7 : a c d g e f b
6->4  1->7*: a c d g e f b
6->4* 2->0 : c a b d g e f
6->4  2->0*: c a b d g e f
6->4* 2->1 : a c b d g e f
6->4  2->1*: a c b d g e f
6->4* 2->2 : a b c d g e f
6->4  2->2*: a b c d g e f
6->4* 2->3 : a b c d g e f
6->4  2->3*: a b c d g e f
6->4* 2->4 : a b d g c e f
6->4  2->4*: a b d c g e f
6->4* 2->5 : a b d g e c f
6->4  2->5*: a b d g e c f
6->4* 2->6 : a b d g e f c
6->4  2->6*: a b d g e f c
6->4* 2->7 : a b d g e f c
6->4  2->7*: a b d g e f c
6->4* 3->0 : d a b c g e f
6->4  3->0*: d a b c g e f
6->4* 3->1 : a d b c g e f
6->4  3->1*: a d b c g e f
6->4* 3->2 : a b d c g e f
6->4  3->2*: a b d c g e f
6->4* 3->3 : a b c d g e f
6->4  3->3*: a b c d g e f
6->4* 3->4 : a b c d g e f
6->4  3->4*: a b c d g e f
6->4* 3->5 : a b c g e d f
6->4  3->5*: a b c g e d f
6->4* 3->6 : a b c g e f d
6->4  3->6*: a b c g e f d
6->4* 3->7 : a b c g e f d
6->4  3->7*: a b c g e f d
6->4* 4->0 : e a b c d g f
6->4  4->0*: e a b c d g f
6->4* 4->1 : a e b c d g f
6->4  4->1*: a e b c d g f
6->4* 4->2 : a b e c d g f
6->4  4->2*: a b e c d g f
6->4* 4->3 : a b c e d g f
6->4  4->3*: a b c e d g f
6->4* 4->4 : a b c d g e f
6->4  4->4*: a b c d g e f
6->4* 4->5 : a b c d g e f
6->4  4->5*: a b c d g e f
6->4* 4->6 : a b c d g f e
6->4  4->6*: a b c d g f e
6->4* 4->7 : a b c d g f e
6->4  4->7*: a b c d g f e
6->4* 5->0 : f a b c d g e
6->4  5->0*: f a b c d g e
6->4* 5->1 : a f b c d g e
6->4  5->1*: a f b c d g e
6->4* 5->2 : a b f c d g e
6->4  5->2*: a b f c d g e
6->4* 5->3 : a b c f d g e
6->4  5->3*: a b c f d g e
6->4* 5->4 : a b c d g f e
6->4  5->4*: a b c d f g e
6->4* 5->5 : a b c d g e f
6->4  5->5*: a b c d g e f
6->4* 5->6 : a b c d g e f
6->4  5->6*: a b c d g e f
6->4* 5->7 : a b c d g e f
6->4  5->7*: a b c d g e f
6->4* 6->0 : a b c d g e f
6->4  6->0*: g a b c d e f
6->4* 6->1 : a b c d g e f
6->4  6->1*: a g b c d e f
6->4* 6->2 : a b c d g e f
6->4  6->2*: a b g c d e f
6->4* 6->3 : a b c d g e f
6->4  6->3*: a b c g d e f
6->4* 6->4 : a b c d g e f
6->4  6->4*: a b c d g e f
6->4* 6->5 : a b c d g e f
6->4  6->5*: a b c d e g f
6->4* 6->6 : a b c d g e f
6->4  6->6*: a b c d g e f
6->4* 6->7 : a b c d g e f
6->4  6->7*: a b c d g e f
6->5* 0->0 : a b c d e g f
6->5  0->0*: a b c d e g f
6->5* 0->1 : a b c d e g f
6->5  0->1*: a b c d e g f
6->5* 0->2 : b a c d e g f
6->5  0->2*: b a c d e g f
6->5* 0->3 : b c a d e g f
6->5  0->3*: b c a d e g f
6->5* 0->4 : b c d a e g f
6->5  0->4*: b c d a e g f
6->5* 0->5 : b c d e g a f
6->5  0->5*: b c d e a g f
6->5* 0->6 : b c d e g f a
6->5  0->6*: b c d e g f a
6->5* 0->7 : b c d e g f a
6->5  0->7*: b c d e g f a
6->5* 1->0 : b a c d e g f
6->5  1->0*: b a c d e g f
6->5* 1->1 : a b c d e g f
6->5  1->1*: a b c d e g f
6->5* 1->2 : a b c d e g f
6->5  1->2*: a b c d e g f
6->5* 1->3 : a c b d e g f
6->5  1->3*: a c b d e g f
6->5* 1->4 : a c d b e g f
6->5  1->4*: a c d b e g f
6->5* 1->5 : a c d e g b f
6->5  1->5*: a c d e b g f
6->5* 1->6 : a c d e g f b
6->5  1->6*: a c d e g f b
6->5* 1->7 : a c d e g f b
6->5  1->7*: a c d e g f b
6->5* 2->0 : c a b d e g f
6->5  2->0*: c a b d e g f
6->5* 2->1 : a c b d e g f
6->5  2->1*: a c b d e g f
6->5* 2->2 : a b c d e g f
6->5  2->2*: a b c d e g f
6->5* 2->3 : a b c d e g f
6->5  2->3*: a b c d e g f
6->5* 2->4 : a b d c e g f
6->5  2->4*: a b d c e g f
6->5* 2->5 : a b d e g c f
6->5  2->5*: a b d e c g f
6->5* 2->6 : a b d e g f c
6->5  2->6*: a b d e g f c
6->5* 2->7 : a b d e g f c
6->5  2->7*: a b d e g f c
6->5* 3->0 : d a b c e g f
6->5  3->0*: d a b c e g f
6->5* 3->1 : a d b c e g f
6->5  3->1*: a d b c e g f
6->5* 3->2 : a b d c e g f
6->5  3->2*: a b d c e g f
6->5* 3->3 : a b c d e g f
6->5  3->3*: a b c d e g f
6->5* 3->4 : a b c d e g f
6->5  3->4*: a b c d e g f
6->5* 3->5 : a b c e g d f
6->5  3->5*: a b c e d g f
6->5* 3->6 : a b c e g f d
6->5  3->6*: a b c e g f d
6->5* 3->7 : a b c e g f d
6->5  3->7*: a b c e g f d
6->5* 4->0 : e a b c d g f
6->5  4->0*: e a b c d g f
6->5* 4->1 : a e b c d g f
6->5  4->1*: a e b c d g f
6->5* 4->2 : a b e c d g f
6->5  4->2*: a b e c d g f
6->5* 4->3 : a b c e d g f
6->5  4->3*: a b c e d g f
6->5* 4->4 : a b c d e g f
6->5  4->4*: a b c d e g f
6->5* 4->5 : a b c d e g f
6->5  4->5*: a b c d e g f
6->5* 4->6 : a b c d g f e
6->5  4->6*: a b c d g f e
6->5* 4->7 : a b c d g f e
6->5  4->7*: a b c d g f e
6->5* 5->0 : f a b c d e g
6->5  5->0*: f a b c d e g
6->5* 5->1 : a f b c d e g
6->5  5->1*: a f b c d e g
6->5* 5->2 : a b f c d e g
6->5  5->2*: a b f c d e g
6->5* 5->3 : a b c f d e g
6->5  5->3*: a b c f d e g
6->5* 5->4 : a b c d f e g
6->5  5->4*: a b c d f e g
6->5* 5->5 : a b c d e g f
6->5  5->5*: a b c d e g f
6->5* 5->6 : a b c d e g f
6->5  5->6*: a b c d e g f
6->5* 5->7 : a b c d e g f
6->5  5->7*: a b c d e g f
6->5* 6->0 : a b c d e g f
6->5  6->0*: g a b c d e f
6->5* 6->1 : a b c d e g f
6->5  6->1*: a g b c d e f
6->5* 6->2 : a b c d e g f
6->5  6->2*: a b g c d e f
6->5* 6->3 : a b c d e g f
6->5  6->3*: a b c g d e f
6->5* 6->4 : a b c d e g f
6->5  6->4*: a b c d g e f
6->5* 6->5 : a b c d e g f
6->5  6->5*: a b c d e g f
6->5* 6->6 : a b c d e g f
6->5  6->6*: a b c d e g f
6->5* 6->7 : a b c d e g f
6->5  6->7*: a b c d e g f
6->6* 0->0 : a b c d e f g
6->6  0->0*: a b c d e f g
6->6* 0->1 : a b c d e f g
6->6  0->1*: a b c d e f g
6->6* 0->2 : b a c d e f g
6->6  0->2*: b a c d e f g
6->6* 0->3 : b c a d e f g
6->6  0->3*: b c a d e f g
6->6* 0->4 : b c d a e f g
6->6  0->4*: b c d a e f g
6->6* 0->5 : b c d e a f g
6->6  0->5*: b c d e a f g
6->6* 0->6 : b c d e f a g
6->6  0->6*: b c d e f a g
6->6* 0->7 : b c d e f g a
6->6  0->7*: b c d e f g a
6->6* 1->0 : b a c d e f g
6->6  1->0*: b a c d e f g
6->6* 1->1 : a b c d e f g
6->6  1->1*: a b c d e f g
6->6* 1->2 : a b c d e f g
6->6  1->2*: a b c d e f g
6->6* 1->3 : a c b d e f g
6->6  1->3*: a c b d e f g
6->6* 1->4 : a c d b e f g
6->6  1->4*: a c d b e f g
6->6* 1->5 : a c d e b f g
6->6  1->5*: a c d e b f g
6->6* 1->6 : a c d e f b g
6->6  1->6*: a c d e f b g
6->6* 1->7 : a c d e f g b
6->6  1->7*: a c d e f g b
6->6* 2->0 : c a b d e f g
6->6  2->0*: c a b d e f g
6->6* 2->1 : a c b d e f g
6->6  2->1*: a c b d e f g
6->6* 2->2 : a b c d e f g
6->6  2->2*: a b c d e f g
6->6* 2->3 : a b c d e f g
6->6  2->3*: a b c d e f g
6->6* 2->4 : a b d c e f g
6->6  2->4*: a b d c e f g
6->6* 2->5 : a b d e c f g
6->6  2->5*: a b d e c f g
6->6* 2->6 : a b d e f c g
6->6  2->6*: a b d e f c g
6->6* 2->7 : a b d e f g c
6->6  2->7*: a b d e f g c
6->6* 3->0 : d a b c e f g
6->6  3->0*: d a b c e f g
6->6* 3->1 : a d b c e f g
6->6  3->1*: a d b c e f g
6->6* 3->2 : a b d c e f g
6->6  3->2*: a b d c e f g
6->6* 3->3 : a b c d e f g
6->6  3->3*: a b c d e f g
6->6* 3->4 : a b c d e f g
6->6  3->4*: a b c d e f g
6->6* 3->5 : a b c e d f g
6->6  3->5*: a b c e d f g
6->6* 3->6 : a b c e f d g
6->6  3->6*: a b c e f d g
6->6* 3->7 : a b c e f g d
6->6  3->7*: a b c e f g d
6->6* 4->0 : e a b c d f g
6->6  4->0*: e a b c d f g
6->6* 4->1 : a e b c d f g
6->6  4->1*: a e b c d f g
6->6* 4->2 : a b e c d f g
6->6  4->2*: a b e c d f g
6->6* 4->3 : a b c e d f g
6->6  4->3*: a b c e d f g
6->6* 4->4 : a b c d e f g
6->6  4->4*: a b c d e f g
6->6* 4->5 : a b c d e f g
6->6  4->5*: a b c d e f g
6->6* 4->6 : a b c d f e g
6->6  4->6*: a b c d f e g
6->6* 4->7 : a b c d f g e
6->6  4->7*: a b c d f g e
6->6* 5->0 : f a b c d e g
6->6  5->0*: f a b c d e g
6->6* 5->1 : a f b c d e g
6->6  5->1*: a f b c d e g
6->6* 5->2 : a b f c d e g
6->6  5->2*: a b f c d e g
6->6* 5->3 : a b c f d e g
6->6  5->3*: a b c f d e g
6->6* 5->4 : a b c d f e g
6->6  5->4*: a b c d f e g
6->6* 5->5 : a b c d e f g
6->6  5->5*: a b c d e f g
6->6* 5->6 : a b c d e f g
6->6  5->6*: a b c d e f g
6->6* 5->7 : a b c d e g f
6->6  5->7*: a b c d e g f
6->6* 6->0 : g a b c d e f
6->6  6->0*: g a b c d e f
6->6* 6->1 : a g b c d e f
6->6  6->1*: a g b c d e f
6->6* 6->2 : a b g c d e f
6->6  6->2*: a b g c d e f
6->6* 6->3 : a b c g d e f
6->6  6->3*: a b c g d e f
6->6* 6->4 : a b c d g e f
6->6  6->4*: a b c d g e f
6->6* 6->5 : a b c d e g f
6->6  6->5*: a b c d e g f
6->6* 6->6 : a b c d e f g
6->6  6->6*: a b c d e f g
6->6* 6->7 : a b c d e f g
6->6  6->7*: a b c d e f g
6->7* 0->0 : a b c d e f g
6->7  0->0*: a b c d e f g
6->7* 0->1 : a b c d e f g
6->7  0->1*: a b c d e f g
6->7* 0->2 : b a c d e f g
6->7  0->2*: b a c d e f g
6->7* 0->3 : b c a d e f g
6->7  0->3*: b c a d e f g
6->7* 0->4 : b c d a e f g
6->7  0->4*: b c d a e f g
6->7* 0->5 : b c d e a f g
6->7  0->5*: b c d e a f g
6->7* 0->6 : b c d e f a g
6->7  0->6*: b c d e f a g
6->7* 0->7 : b c d e f g a
6->7  0->7*: b c d e f g a
6->7* 1->0 : b a c d e f g
6->7  1->0*: b a c d e f g
6->7* 1->1 : a b c d e f g
6->7  1->1*: a b c d e f g
6->7* 1->2 : a b c d e f g
6->7  1->2*: a b c d e f g
6->7* 1->3 : a c b d e f g
6->7  1->3*: a c b d e f g
6->7* 1->4 : a c d b e f g
6->7  1->4*: a c d b e f g
6->7* 1->5 : a c d e b f g
6->7  1->5*: a c d e b f g
6->7* 1->6 : a c d e f b g
6->7  1->6*: a c d e f b g
6->7* 1->7 : a c d e f g b
6->7  1->7*: a c d e f g b
6->7* 2->0 : c a b d e f g
6->7  2->0*: c a b d e f g
6->7* 2->1 : a c b d e f g
6->7  2->1*: a c b d e f g
6->7* 2->2 : a b c d e f g
6->7  2->2*: a b c d e f g
6->7* 2->3 : a b c d e f g
6->7  2->3*: a b c d e f g
6->7* 2->4 : a b d c e f g
6->7  2->4*: a b d c e f g
6->7* 2->5 : a b d e c f g
6->7  2->5*: a b d e c f g
6->7* 2->6 : a b d e f c g
6->7  2->6*: a b d e f c g
6->7* 2->7 : a b d e f g c
6->7  2->7*: a b d e f g c
6->7* 3->0 : d a b c e f g
6->7  3->0*: d a b c e f g
6->7* 3->1 : a d b c e f g
6->7  3->1*: a d b c e f g
6->7* 3->2 : a b d c e f g
6->7  3->2*: a b d c e f g
6->7* 3->3 : a b c d e f g
6->7  3->3*: a b c d e f g
6->7* 3->4 : a b c d e f g
6->7  3->4*: a b c d e f g
6->7* 3->5 : a b c e d f g
6->7  3->5*: a b c e d f g
6->7* 3->6 : a b c e f d g
6->7  3->6*: a b c e f d g
6->7* 3->7 : a b c e f g d
6->7  3->7*: a b c e f g d
6->7* 4->0 : e a b c d f g
6->7  4->0*: e a b c d f g
6->7* 4->1 : a e b c d f g
6->7  4->1*: a e b c d f g
6->7* 4->2 : a b e c d f g
6->7  4->2*: a b e c d f g
6->7* 4->3 : a b c e d f g
6->7  4->3*: a b c e d f g
6->7* 4->4 : a b c d e f g
6->7  4->4*: a b c d e f g
6->7* 4->5 : a b c d e f g
6->7  4->5*: a b c d e f g
6->7* 4->6 : a b c d f e g
6->7  4->6*: a b c d f e g
6->7* 4->7 : a b c d f g e
6->7  4->7*: a b c d f g e
6->7* 5->0 : f a b c d e g
6->7  5->0*: f a b c d e g
6->7* 5->1 : a f b c d e g
6->7  5->1*: a f b c d e g
6->7* 5->2 : a b f c d e g
6->7  5->2*: a b f c d e g
6->7* 5->3 : a b c f d e g
6->7  5->3*: a b c f d e g
6->7* 5->4 : a b c d f e g
6->7  5->4*: a b c d f e g
6->7* 5->5 : a b c d e f g
6->7  5->5*: a b c d e f g
6->7* 5->6 : a b c d e f g
6->7  5->6*: a b c d e f g
6->7* 5->7 : a b c d e g f
6->7  5->7*: a b c d e g f
6->7* 6->0 : g a b c d e f
6->7  6->0*: g a b c d e f
6->7* 6->1 : a g b c d e f
6->7  6->1*: a g b c d e f
6->7* 6->2 : a b g c d e f
6->7  6->2*: a b g c d e f
6->7* 6->3 : a b c g d e f
6->7  6->3*: a b c g d e f
6->7* 6->4 : a b c d g e f
6->7  6->4*: a b c d g e f
6->7* 6->5 : a b c d e g f
6->7  6->5*: a b c d e g f
6->7* 6->6 : a b c d e f g
6->7  6->6*: a b c d e f g
6->7* 6->7 : a b c d e f g
6->7  6->7*: a b c d e f g''';
