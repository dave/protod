package pdelta_tests

import (
	"encoding/json"
	"reflect"

	"google.golang.org/protobuf/encoding/protojson"
	"google.golang.org/protobuf/proto"
)

//func TestFuzzer(t *testing.T) {
//	message := &Person{}
//	ops := fuzzer.All(message)
//	for i, op := range ops {
//		fmt.Println(i, op.Debug())
//	}
//}
//
//func TestSingle(t *testing.T) {
//	p := mustPerson(`{"name":"a","cases":{"Cr2XdBjb3UcylPTJ6EU5":{"name":"MGAlPoo2h5yGPSG06GJB"}},"company":{"flags":{"-872":"gYacSXXsUH2gs3nijFSA"},"ceo":{"cases":{"gPVX7vGHN8gM50w3Nd8C":{"name":"jIGLrc4toMyDFeNbH49C","items":[{"title":"BGVvSkLSHYkwqcOg9FOM"},{"title":"viEAyVWRxrVRbEBlmAHW"}],"flags":{"-57":"RnvYVzuWx9TwFBYiwqN6"}}},"company":{"ceo":{"name":"ahmyWZL0rvz9Xb4AkE1n"}}}}}`)
//	op := mustOp(`{"type":"Insert","location":[{"field":{"name":"company","number":5}},{"field":{"name":"ceo","number":14}},{"field":{"name":"typeList","number":8}},{"index":"0"}],"scalar":{"enum":1}}`)
//	if err := pdelta.Apply(op, p); err != nil {
//		t.Fatal(err)
//	}
//}

func mustJson(message proto.Message) string {
	b, err := protojson.Marshal(message)
	if err != nil {
		panic(err)
	}
	return string(b)
}

func compareProto(m1, m2 proto.Message) bool {
	m1b, err := protojson.Marshal(m1)
	if err != nil {
		panic(err)
	}
	m2b, err := protojson.Marshal(m2)
	if err != nil {
		panic(err)
	}
	var i1, i2 interface{}
	if err := json.Unmarshal(m1b, &i1); err != nil {
		panic(err)
	}
	if err := json.Unmarshal(m2b, &i2); err != nil {
		panic(err)
	}
	return reflect.DeepEqual(i1, i2)
}
