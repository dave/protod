// Code generated by protoc-gen-go. DO NOT EDIT.
// versions:
// 	protoc-gen-go v1.21.0
// 	protoc        v3.11.4
// source: pstore/pstore.proto

package pstore

import (
	delta "github.com/dave/protod/delta"
	_ "github.com/dave/protod/google/protobuf"
	proto "github.com/golang/protobuf/proto"
	any "github.com/golang/protobuf/ptypes/any"
	protoreflect "google.golang.org/protobuf/reflect/protoreflect"
	protoimpl "google.golang.org/protobuf/runtime/protoimpl"
	reflect "reflect"
	sync "sync"
)

const (
	// Verify that this generated code is sufficiently up-to-date.
	_ = protoimpl.EnforceVersion(20 - protoimpl.MinVersion)
	// Verify that runtime/protoimpl is sufficiently up-to-date.
	_ = protoimpl.EnforceVersion(protoimpl.MaxVersion - 20)
)

// This is a compile-time assertion that a sufficiently up-to-date version
// of the legacy proto package is being used.
const _ = proto.ProtoPackageIsVersion4

type Payload struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields
}

func (x *Payload) Reset() {
	*x = Payload{}
	if protoimpl.UnsafeEnabled {
		mi := &file_pstore_pstore_proto_msgTypes[0]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *Payload) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*Payload) ProtoMessage() {}

func (x *Payload) ProtoReflect() protoreflect.Message {
	mi := &file_pstore_pstore_proto_msgTypes[0]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use Payload.ProtoReflect.Descriptor instead.
func (*Payload) Descriptor() ([]byte, []int) {
	return file_pstore_pstore_proto_rawDescGZIP(), []int{0}
}

//  message Add {
//    message Request {
//      string documentType = 1;
//      string documentId = 2;
//      string stateId = 3; // unique id for the first state, should be a random string
//      google.protobuf.Any value = 4;
//    }
//    message Response {
//      int64 state = 1; // if document being added already exists, value will be set to the supplied value, however the state returned will be > 1
//    }
//  }
type Payload_Get struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields
}

func (x *Payload_Get) Reset() {
	*x = Payload_Get{}
	if protoimpl.UnsafeEnabled {
		mi := &file_pstore_pstore_proto_msgTypes[1]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *Payload_Get) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*Payload_Get) ProtoMessage() {}

func (x *Payload_Get) ProtoReflect() protoreflect.Message {
	mi := &file_pstore_pstore_proto_msgTypes[1]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use Payload_Get.ProtoReflect.Descriptor instead.
func (*Payload_Get) Descriptor() ([]byte, []int) {
	return file_pstore_pstore_proto_rawDescGZIP(), []int{0, 0}
}

type Payload_Edit struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields
}

func (x *Payload_Edit) Reset() {
	*x = Payload_Edit{}
	if protoimpl.UnsafeEnabled {
		mi := &file_pstore_pstore_proto_msgTypes[2]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *Payload_Edit) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*Payload_Edit) ProtoMessage() {}

func (x *Payload_Edit) ProtoReflect() protoreflect.Message {
	mi := &file_pstore_pstore_proto_msgTypes[2]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use Payload_Edit.ProtoReflect.Descriptor instead.
func (*Payload_Edit) Descriptor() ([]byte, []int) {
	return file_pstore_pstore_proto_rawDescGZIP(), []int{0, 1}
}

type Payload_Refresh struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields
}

func (x *Payload_Refresh) Reset() {
	*x = Payload_Refresh{}
	if protoimpl.UnsafeEnabled {
		mi := &file_pstore_pstore_proto_msgTypes[3]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *Payload_Refresh) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*Payload_Refresh) ProtoMessage() {}

func (x *Payload_Refresh) ProtoReflect() protoreflect.Message {
	mi := &file_pstore_pstore_proto_msgTypes[3]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use Payload_Refresh.ProtoReflect.Descriptor instead.
func (*Payload_Refresh) Descriptor() ([]byte, []int) {
	return file_pstore_pstore_proto_rawDescGZIP(), []int{0, 2}
}

type Payload_Get_Request struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	DocumentType string `protobuf:"bytes,1,opt,name=documentType,proto3" json:"documentType,omitempty"`
	DocumentId   string `protobuf:"bytes,2,opt,name=documentId,proto3" json:"documentId,omitempty"`
	Create       bool   `protobuf:"varint,3,opt,name=create,proto3" json:"create,omitempty"`
}

func (x *Payload_Get_Request) Reset() {
	*x = Payload_Get_Request{}
	if protoimpl.UnsafeEnabled {
		mi := &file_pstore_pstore_proto_msgTypes[4]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *Payload_Get_Request) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*Payload_Get_Request) ProtoMessage() {}

func (x *Payload_Get_Request) ProtoReflect() protoreflect.Message {
	mi := &file_pstore_pstore_proto_msgTypes[4]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use Payload_Get_Request.ProtoReflect.Descriptor instead.
func (*Payload_Get_Request) Descriptor() ([]byte, []int) {
	return file_pstore_pstore_proto_rawDescGZIP(), []int{0, 0, 0}
}

func (x *Payload_Get_Request) GetDocumentType() string {
	if x != nil {
		return x.DocumentType
	}
	return ""
}

func (x *Payload_Get_Request) GetDocumentId() string {
	if x != nil {
		return x.DocumentId
	}
	return ""
}

func (x *Payload_Get_Request) GetCreate() bool {
	if x != nil {
		return x.Create
	}
	return false
}

type Payload_Get_Response struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	State int64    `protobuf:"varint,1,opt,name=state,proto3" json:"state,omitempty"`
	Value *any.Any `protobuf:"bytes,2,opt,name=value,proto3" json:"value,omitempty"`
}

func (x *Payload_Get_Response) Reset() {
	*x = Payload_Get_Response{}
	if protoimpl.UnsafeEnabled {
		mi := &file_pstore_pstore_proto_msgTypes[5]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *Payload_Get_Response) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*Payload_Get_Response) ProtoMessage() {}

func (x *Payload_Get_Response) ProtoReflect() protoreflect.Message {
	mi := &file_pstore_pstore_proto_msgTypes[5]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use Payload_Get_Response.ProtoReflect.Descriptor instead.
func (*Payload_Get_Response) Descriptor() ([]byte, []int) {
	return file_pstore_pstore_proto_rawDescGZIP(), []int{0, 0, 1}
}

func (x *Payload_Get_Response) GetState() int64 {
	if x != nil {
		return x.State
	}
	return 0
}

func (x *Payload_Get_Response) GetValue() *any.Any {
	if x != nil {
		return x.Value
	}
	return nil
}

type Payload_Edit_Request struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	DocumentType string    `protobuf:"bytes,1,opt,name=documentType,proto3" json:"documentType,omitempty"`
	DocumentId   string    `protobuf:"bytes,2,opt,name=documentId,proto3" json:"documentId,omitempty"`
	StateId      string    `protobuf:"bytes,3,opt,name=stateId,proto3" json:"stateId,omitempty"` // unique id for the new state, should be a random string
	State        int64     `protobuf:"varint,4,opt,name=state,proto3" json:"state,omitempty"`    // state of the document that this op is acting on
	Op           *delta.Op `protobuf:"bytes,5,opt,name=op,proto3" json:"op,omitempty"`           // operation
}

func (x *Payload_Edit_Request) Reset() {
	*x = Payload_Edit_Request{}
	if protoimpl.UnsafeEnabled {
		mi := &file_pstore_pstore_proto_msgTypes[6]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *Payload_Edit_Request) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*Payload_Edit_Request) ProtoMessage() {}

func (x *Payload_Edit_Request) ProtoReflect() protoreflect.Message {
	mi := &file_pstore_pstore_proto_msgTypes[6]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use Payload_Edit_Request.ProtoReflect.Descriptor instead.
func (*Payload_Edit_Request) Descriptor() ([]byte, []int) {
	return file_pstore_pstore_proto_rawDescGZIP(), []int{0, 1, 0}
}

func (x *Payload_Edit_Request) GetDocumentType() string {
	if x != nil {
		return x.DocumentType
	}
	return ""
}

func (x *Payload_Edit_Request) GetDocumentId() string {
	if x != nil {
		return x.DocumentId
	}
	return ""
}

func (x *Payload_Edit_Request) GetStateId() string {
	if x != nil {
		return x.StateId
	}
	return ""
}

func (x *Payload_Edit_Request) GetState() int64 {
	if x != nil {
		return x.State
	}
	return 0
}

func (x *Payload_Edit_Request) GetOp() *delta.Op {
	if x != nil {
		return x.Op
	}
	return nil
}

type Payload_Edit_Response struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	State int64     `protobuf:"varint,1,opt,name=state,proto3" json:"state,omitempty"` // state of the document after the op from the client and the response op have been applied
	Op    *delta.Op `protobuf:"bytes,2,opt,name=op,proto3" json:"op,omitempty"`        // response op that must be applied to the document in order to get to the server state
}

func (x *Payload_Edit_Response) Reset() {
	*x = Payload_Edit_Response{}
	if protoimpl.UnsafeEnabled {
		mi := &file_pstore_pstore_proto_msgTypes[7]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *Payload_Edit_Response) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*Payload_Edit_Response) ProtoMessage() {}

func (x *Payload_Edit_Response) ProtoReflect() protoreflect.Message {
	mi := &file_pstore_pstore_proto_msgTypes[7]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use Payload_Edit_Response.ProtoReflect.Descriptor instead.
func (*Payload_Edit_Response) Descriptor() ([]byte, []int) {
	return file_pstore_pstore_proto_rawDescGZIP(), []int{0, 1, 1}
}

func (x *Payload_Edit_Response) GetState() int64 {
	if x != nil {
		return x.State
	}
	return 0
}

func (x *Payload_Edit_Response) GetOp() *delta.Op {
	if x != nil {
		return x.Op
	}
	return nil
}

type Payload_Refresh_Request struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	DocumentType string `protobuf:"bytes,1,opt,name=documentType,proto3" json:"documentType,omitempty"` // document type
	DocumentId   string `protobuf:"bytes,2,opt,name=documentId,proto3" json:"documentId,omitempty"`     // document id
}

func (x *Payload_Refresh_Request) Reset() {
	*x = Payload_Refresh_Request{}
	if protoimpl.UnsafeEnabled {
		mi := &file_pstore_pstore_proto_msgTypes[8]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *Payload_Refresh_Request) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*Payload_Refresh_Request) ProtoMessage() {}

func (x *Payload_Refresh_Request) ProtoReflect() protoreflect.Message {
	mi := &file_pstore_pstore_proto_msgTypes[8]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use Payload_Refresh_Request.ProtoReflect.Descriptor instead.
func (*Payload_Refresh_Request) Descriptor() ([]byte, []int) {
	return file_pstore_pstore_proto_rawDescGZIP(), []int{0, 2, 0}
}

func (x *Payload_Refresh_Request) GetDocumentType() string {
	if x != nil {
		return x.DocumentType
	}
	return ""
}

func (x *Payload_Refresh_Request) GetDocumentId() string {
	if x != nil {
		return x.DocumentId
	}
	return ""
}

var File_pstore_pstore_proto protoreflect.FileDescriptor

var file_pstore_pstore_proto_rawDesc = []byte{
	0x0a, 0x13, 0x70, 0x73, 0x74, 0x6f, 0x72, 0x65, 0x2f, 0x70, 0x73, 0x74, 0x6f, 0x72, 0x65, 0x2e,
	0x70, 0x72, 0x6f, 0x74, 0x6f, 0x12, 0x06, 0x70, 0x73, 0x74, 0x6f, 0x72, 0x65, 0x1a, 0x11, 0x64,
	0x65, 0x6c, 0x74, 0x61, 0x2f, 0x64, 0x65, 0x6c, 0x74, 0x61, 0x2e, 0x70, 0x72, 0x6f, 0x74, 0x6f,
	0x1a, 0x19, 0x67, 0x6f, 0x6f, 0x67, 0x6c, 0x65, 0x2f, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x62, 0x75,
	0x66, 0x2f, 0x61, 0x6e, 0x79, 0x2e, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x1a, 0x22, 0x67, 0x6f, 0x6f,
	0x67, 0x6c, 0x65, 0x2f, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x62, 0x75, 0x66, 0x2f, 0x64, 0x61, 0x72,
	0x74, 0x5f, 0x6f, 0x70, 0x74, 0x69, 0x6f, 0x6e, 0x73, 0x2e, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x22,
	0x81, 0x04, 0x0a, 0x07, 0x50, 0x61, 0x79, 0x6c, 0x6f, 0x61, 0x64, 0x1a, 0xba, 0x01, 0x0a, 0x03,
	0x47, 0x65, 0x74, 0x1a, 0x65, 0x0a, 0x07, 0x52, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x12, 0x22,
	0x0a, 0x0c, 0x64, 0x6f, 0x63, 0x75, 0x6d, 0x65, 0x6e, 0x74, 0x54, 0x79, 0x70, 0x65, 0x18, 0x01,
	0x20, 0x01, 0x28, 0x09, 0x52, 0x0c, 0x64, 0x6f, 0x63, 0x75, 0x6d, 0x65, 0x6e, 0x74, 0x54, 0x79,
	0x70, 0x65, 0x12, 0x1e, 0x0a, 0x0a, 0x64, 0x6f, 0x63, 0x75, 0x6d, 0x65, 0x6e, 0x74, 0x49, 0x64,
	0x18, 0x02, 0x20, 0x01, 0x28, 0x09, 0x52, 0x0a, 0x64, 0x6f, 0x63, 0x75, 0x6d, 0x65, 0x6e, 0x74,
	0x49, 0x64, 0x12, 0x16, 0x0a, 0x06, 0x63, 0x72, 0x65, 0x61, 0x74, 0x65, 0x18, 0x03, 0x20, 0x01,
	0x28, 0x08, 0x52, 0x06, 0x63, 0x72, 0x65, 0x61, 0x74, 0x65, 0x1a, 0x4c, 0x0a, 0x08, 0x52, 0x65,
	0x73, 0x70, 0x6f, 0x6e, 0x73, 0x65, 0x12, 0x14, 0x0a, 0x05, 0x73, 0x74, 0x61, 0x74, 0x65, 0x18,
	0x01, 0x20, 0x01, 0x28, 0x03, 0x52, 0x05, 0x73, 0x74, 0x61, 0x74, 0x65, 0x12, 0x2a, 0x0a, 0x05,
	0x76, 0x61, 0x6c, 0x75, 0x65, 0x18, 0x02, 0x20, 0x01, 0x28, 0x0b, 0x32, 0x14, 0x2e, 0x67, 0x6f,
	0x6f, 0x67, 0x6c, 0x65, 0x2e, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x62, 0x75, 0x66, 0x2e, 0x41, 0x6e,
	0x79, 0x52, 0x05, 0x76, 0x61, 0x6c, 0x75, 0x65, 0x1a, 0xde, 0x01, 0x0a, 0x04, 0x45, 0x64, 0x69,
	0x74, 0x1a, 0x98, 0x01, 0x0a, 0x07, 0x52, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x12, 0x22, 0x0a,
	0x0c, 0x64, 0x6f, 0x63, 0x75, 0x6d, 0x65, 0x6e, 0x74, 0x54, 0x79, 0x70, 0x65, 0x18, 0x01, 0x20,
	0x01, 0x28, 0x09, 0x52, 0x0c, 0x64, 0x6f, 0x63, 0x75, 0x6d, 0x65, 0x6e, 0x74, 0x54, 0x79, 0x70,
	0x65, 0x12, 0x1e, 0x0a, 0x0a, 0x64, 0x6f, 0x63, 0x75, 0x6d, 0x65, 0x6e, 0x74, 0x49, 0x64, 0x18,
	0x02, 0x20, 0x01, 0x28, 0x09, 0x52, 0x0a, 0x64, 0x6f, 0x63, 0x75, 0x6d, 0x65, 0x6e, 0x74, 0x49,
	0x64, 0x12, 0x18, 0x0a, 0x07, 0x73, 0x74, 0x61, 0x74, 0x65, 0x49, 0x64, 0x18, 0x03, 0x20, 0x01,
	0x28, 0x09, 0x52, 0x07, 0x73, 0x74, 0x61, 0x74, 0x65, 0x49, 0x64, 0x12, 0x14, 0x0a, 0x05, 0x73,
	0x74, 0x61, 0x74, 0x65, 0x18, 0x04, 0x20, 0x01, 0x28, 0x03, 0x52, 0x05, 0x73, 0x74, 0x61, 0x74,
	0x65, 0x12, 0x19, 0x0a, 0x02, 0x6f, 0x70, 0x18, 0x05, 0x20, 0x01, 0x28, 0x0b, 0x32, 0x09, 0x2e,
	0x64, 0x65, 0x6c, 0x74, 0x61, 0x2e, 0x4f, 0x70, 0x52, 0x02, 0x6f, 0x70, 0x1a, 0x3b, 0x0a, 0x08,
	0x52, 0x65, 0x73, 0x70, 0x6f, 0x6e, 0x73, 0x65, 0x12, 0x14, 0x0a, 0x05, 0x73, 0x74, 0x61, 0x74,
	0x65, 0x18, 0x01, 0x20, 0x01, 0x28, 0x03, 0x52, 0x05, 0x73, 0x74, 0x61, 0x74, 0x65, 0x12, 0x19,
	0x0a, 0x02, 0x6f, 0x70, 0x18, 0x02, 0x20, 0x01, 0x28, 0x0b, 0x32, 0x09, 0x2e, 0x64, 0x65, 0x6c,
	0x74, 0x61, 0x2e, 0x4f, 0x70, 0x52, 0x02, 0x6f, 0x70, 0x1a, 0x58, 0x0a, 0x07, 0x52, 0x65, 0x66,
	0x72, 0x65, 0x73, 0x68, 0x1a, 0x4d, 0x0a, 0x07, 0x52, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x12,
	0x22, 0x0a, 0x0c, 0x64, 0x6f, 0x63, 0x75, 0x6d, 0x65, 0x6e, 0x74, 0x54, 0x79, 0x70, 0x65, 0x18,
	0x01, 0x20, 0x01, 0x28, 0x09, 0x52, 0x0c, 0x64, 0x6f, 0x63, 0x75, 0x6d, 0x65, 0x6e, 0x74, 0x54,
	0x79, 0x70, 0x65, 0x12, 0x1e, 0x0a, 0x0a, 0x64, 0x6f, 0x63, 0x75, 0x6d, 0x65, 0x6e, 0x74, 0x49,
	0x64, 0x18, 0x02, 0x20, 0x01, 0x28, 0x09, 0x52, 0x0a, 0x64, 0x6f, 0x63, 0x75, 0x6d, 0x65, 0x6e,
	0x74, 0x49, 0x64, 0x42, 0x2f, 0x5a, 0x24, 0x67, 0x69, 0x74, 0x68, 0x75, 0x62, 0x2e, 0x63, 0x6f,
	0x6d, 0x2f, 0x64, 0x61, 0x76, 0x65, 0x2f, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x64, 0x2f, 0x70, 0x73,
	0x74, 0x6f, 0x72, 0x65, 0x3b, 0x70, 0x73, 0x74, 0x6f, 0x72, 0x65, 0x8a, 0x43, 0x06, 0x70, 0x72,
	0x6f, 0x74, 0x6f, 0x64, 0x62, 0x06, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x33,
}

var (
	file_pstore_pstore_proto_rawDescOnce sync.Once
	file_pstore_pstore_proto_rawDescData = file_pstore_pstore_proto_rawDesc
)

func file_pstore_pstore_proto_rawDescGZIP() []byte {
	file_pstore_pstore_proto_rawDescOnce.Do(func() {
		file_pstore_pstore_proto_rawDescData = protoimpl.X.CompressGZIP(file_pstore_pstore_proto_rawDescData)
	})
	return file_pstore_pstore_proto_rawDescData
}

var file_pstore_pstore_proto_msgTypes = make([]protoimpl.MessageInfo, 9)
var file_pstore_pstore_proto_goTypes = []interface{}{
	(*Payload)(nil),                 // 0: pstore.Payload
	(*Payload_Get)(nil),             // 1: pstore.Payload.Get
	(*Payload_Edit)(nil),            // 2: pstore.Payload.Edit
	(*Payload_Refresh)(nil),         // 3: pstore.Payload.Refresh
	(*Payload_Get_Request)(nil),     // 4: pstore.Payload.Get.Request
	(*Payload_Get_Response)(nil),    // 5: pstore.Payload.Get.Response
	(*Payload_Edit_Request)(nil),    // 6: pstore.Payload.Edit.Request
	(*Payload_Edit_Response)(nil),   // 7: pstore.Payload.Edit.Response
	(*Payload_Refresh_Request)(nil), // 8: pstore.Payload.Refresh.Request
	(*any.Any)(nil),                 // 9: google.protobuf.Any
	(*delta.Op)(nil),                // 10: delta.Op
}
var file_pstore_pstore_proto_depIdxs = []int32{
	9,  // 0: pstore.Payload.Get.Response.value:type_name -> google.protobuf.Any
	10, // 1: pstore.Payload.Edit.Request.op:type_name -> delta.Op
	10, // 2: pstore.Payload.Edit.Response.op:type_name -> delta.Op
	3,  // [3:3] is the sub-list for method output_type
	3,  // [3:3] is the sub-list for method input_type
	3,  // [3:3] is the sub-list for extension type_name
	3,  // [3:3] is the sub-list for extension extendee
	0,  // [0:3] is the sub-list for field type_name
}

func init() { file_pstore_pstore_proto_init() }
func file_pstore_pstore_proto_init() {
	if File_pstore_pstore_proto != nil {
		return
	}
	if !protoimpl.UnsafeEnabled {
		file_pstore_pstore_proto_msgTypes[0].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*Payload); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_pstore_pstore_proto_msgTypes[1].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*Payload_Get); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_pstore_pstore_proto_msgTypes[2].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*Payload_Edit); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_pstore_pstore_proto_msgTypes[3].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*Payload_Refresh); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_pstore_pstore_proto_msgTypes[4].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*Payload_Get_Request); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_pstore_pstore_proto_msgTypes[5].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*Payload_Get_Response); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_pstore_pstore_proto_msgTypes[6].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*Payload_Edit_Request); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_pstore_pstore_proto_msgTypes[7].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*Payload_Edit_Response); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_pstore_pstore_proto_msgTypes[8].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*Payload_Refresh_Request); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
	}
	type x struct{}
	out := protoimpl.TypeBuilder{
		File: protoimpl.DescBuilder{
			GoPackagePath: reflect.TypeOf(x{}).PkgPath(),
			RawDescriptor: file_pstore_pstore_proto_rawDesc,
			NumEnums:      0,
			NumMessages:   9,
			NumExtensions: 0,
			NumServices:   0,
		},
		GoTypes:           file_pstore_pstore_proto_goTypes,
		DependencyIndexes: file_pstore_pstore_proto_depIdxs,
		MessageInfos:      file_pstore_pstore_proto_msgTypes,
	}.Build()
	File_pstore_pstore_proto = out.File
	file_pstore_pstore_proto_rawDesc = nil
	file_pstore_pstore_proto_goTypes = nil
	file_pstore_pstore_proto_depIdxs = nil
}
