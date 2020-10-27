#include <bits/stdc++.h>
using namespace std;

struct Trie_Node{
    map < char, struct Trie_Node* > character;
    bool endofword = false ;
    int pass=0;
};

struct Trie_Node root;

void insertWord(string str);
struct Trie_Node* Get_newNode();
bool FindWords(string str);

int main(){
    int t;
    cin>>t;
    while(t--){
        int n;
        cin>>n;

        string str[n];
        for(int i=0;i<n;i++){
            cin>>str[i];
            insertWord(str[i]);
        }

        string wrd;
        cin>>wrd;

        bool c=FindWords(wrd);
        if(c){
            cout<<"1"<<endl;
        }
        else{
            cout<<"0"<<endl;
        }
        root.character.clear();

    }

}

bool FindWords(string str){
    struct Trie_Node *temp;
    temp = &root ;

    for(int i=0;i<str.size();i++){
        char ch= str[i];
        if(temp->character.find(str[i]) == temp->character.end()){
            return false;
        }
        temp=temp->character[ch];
    }

    return temp->endofword;
}


//Creating New Node
struct Trie_Node * Get_newNode(){
    struct Trie_Node *newNode;
    newNode = new struct Trie_Node;
    newNode->endofword = false ;
    return newNode;
}



//Inserting on The Trie Tree
void insertWord(string str){
    struct Trie_Node *temp ;
    temp = &root ;

    for(int i=0;i<str.size();i++){
        char ch = str[i];

        if(temp->character.find(ch) == temp->character.end()){
            temp->character[ch];
            temp->character[ch] = Get_newNode();
        }
        temp->pass++;
        temp = temp->character[ch];
    }
    temp->pass++;
    temp->endofword = true;
}
