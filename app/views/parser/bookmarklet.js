// https://github.com/dankogai/js-deflate/blob/master/rawdeflate.js
// http://www.stringify.com/static/js/base64.js

(function(){
 // Get the encoding stuff out of the way
 // if(typeof window.btoa=='undefined'){window.btoa=function(a){var b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=';var d=[];var c=0;while(c<a.length){var e=a.charCodeAt(c++);var f=a.charCodeAt(c++);var g=a.charCodeAt(c++);var h=(e<<16)+((f||0)<<8)+(g||0);var i=(h&(63<<18))>>18;var j=(h&(63<<12))>>12;var k=isNaN(f)?64:(h&(63<<6))>>6;var l=isNaN(g)?64:(h&63);d[d.length]=b.charAt(i);d[d.length]=b.charAt(j);d[d.length]=b.charAt(k);d[d.length]=b.charAt(l)}return d.join('')}}var o=32768;var r=0;var s=1;var t=2;var u=6;var x=true;var y=32768;var z=64;var A=1024*8;var B=2*o;var C=3;var D=258;var E=16;var F=0x2000;var G=13;if(F>y)alert("error: zip_INBUFSIZ is too small");if((o<<1)>(1<<E))alert("error: zip_WSIZE is too large");if(G>E-1)alert("error: zip_HASH_BITS is too large");if(G<8||D!=258)alert("error: Code too clever");var H=F;var I=1<<G;var J=I-1;var K=o-1;var L=0;var M=4096;var N=D+C+1;var O=o-N;var P=1;var Q=15;var R=7;var S=29;var T=256;var U=256;var V=T+1+S;var W=30;var X=19;var Y=16;var Z=17;var ba=18;var bb=2*V+1;var bc=parseInt((G+C-1)/C);var bd;var be,zip_qtail;var bf;var bg=null;var bh,zip_outoff;var bi;var bj;var bk;var bl;var bm;var bn;var bo;var bp;var bq;var br;var bs;var bt;var bu;var bv;var bw;var bx;var by;var bz;var bA;var bB;var bC;var bD;var bE;var bF;var bG;var bH;var bI;var bJ;var bK;var bL;var bM;var bN;var bO;var bP;var bQ;var bR;var bS;var bT;var bU;var bV;var bW;var bX;var bY;var bZ;var ca;var cb;var cc;var cd;var ce;var cf;var cg=function(){this.fc=0;this.dl=0};var ch=function(){this.dyn_tree=null;this.static_tree=null;this.extra_bits=null;this.extra_base=0;this.elems=0;this.max_length=0;this.max_code=0};var ci=function(a,b,c,d){this.good_length=a;this.max_lazy=b;this.nice_length=c;this.max_chain=d};var cj=function(){this.next=null;this.len=0;this.ptr=new Array(A);this.off=0};var ck=new Array(0,0,0,0,0,0,0,0,1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5,0);var cl=new Array(0,0,0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10,11,11,12,12,13,13);var cm=new Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,3,7);var cn=new Array(16,17,18,0,8,7,9,6,10,5,11,4,12,3,13,2,14,1,15);var co=new Array(new ci(0,0,0,0),new ci(4,4,8,4),new ci(4,5,16,8),new ci(4,6,32,32),new ci(4,4,16,16),new ci(8,16,32,32),new ci(8,16,128,128),new ci(8,32,128,256),new ci(32,128,258,1024),new ci(32,258,258,4096));var cp=function(a){var i;if(!a)a=u;else if(a<1)a=1;else if(a>9)a=9;bC=a;bf=false;by=false;if(bg!=null)return;bd=be=zip_qtail=null;bg=new Array(A);bj=new Array(B);bk=new Array(H);bl=new Array(y+z);bm=new Array(1<<E);bF=new Array(bb);for(i=0;i<bb;i++)bF[i]=new cg();bG=new Array(2*W+1);for(i=0;i<2*W+1;i++)bG[i]=new cg();bH=new Array(V+2);for(i=0;i<V+2;i++)bH[i]=new cg();bI=new Array(W);for(i=0;i<W;i++)bI[i]=new cg();bJ=new Array(2*X+1);for(i=0;i<2*X+1;i++)bJ[i]=new cg();bK=new ch();bL=new ch();bM=new ch();bN=new Array(Q+1);bO=new Array(2*V+1);bR=new Array(2*V+1);bS=new Array(D-C+1);bT=new Array(512);bU=new Array(S);bV=new Array(W);bW=new Array(parseInt(F/8))};var cq=function(){bd=be=zip_qtail=null;bg=null;bj=null;bk=null;bl=null;bm=null;bF=null;bG=null;bH=null;bI=null;bJ=null;bK=null;bL=null;bM=null;bN=null;bO=null;bR=null;bS=null;bT=null;bU=null;bV=null;bW=null};var cr=function(p){p.next=bd;bd=p};var cs=function(){var p;if(bd!=null){p=bd;bd=bd.next}else p=new cj();p.next=null;p.len=p.off=0;return p};var ct=function(i){return bm[o+i]};var cu=function(i,a){return bm[o+i]=a};var cv=function(c){bg[zip_outoff+bh++]=c;if(zip_outoff+bh==A)db()};var cw=function(w){w&=0xffff;if(zip_outoff+bh<A-2){bg[zip_outoff+bh++]=(w&0xff);bg[zip_outoff+bh++]=(w>>>8)}else{cv(w&0xff);cv(w>>>8)}};var cx=function(){bq=((bq<<bc)^(bj[bw+C-1]&0xff))&J;br=ct(bq);bm[bw&K]=br;cu(bq,bw)};var cy=function(c,a){cY(a[c].fc,a[c].dl)};var cz=function(a){return(a<256?bT[a]:bT[256+(a>>7)])&0xff};var cA=function(a,n,m){return a[n].fc<a[m].fc||(a[n].fc==a[m].fc&&bR[n]<=bR[m])};var cB=function(a,b,n){var i;for(i=0;i<n&&cf<ce.length;i++)a[b+i]=ce.charCodeAt(cf++)&0xff;return i};var cC=function(){var j;for(j=0;j<I;j++)bm[o+j]=0;bB=co[bC].max_lazy;bD=co[bC].good_length;if(!x)bE=co[bC].nice_length;bA=co[bC].max_chain;bw=0;bp=0;bz=cB(bj,0,2*o);if(bz<=0){by=true;bz=0;return}by=false;while(bz<N&&!by)cE();bq=0;for(j=0;j<C-1;j++){bq=((bq<<bc)^(bj[j]&0xff))&J}};var cD=function(a){var b=bA;var c=bw;var d;var e;var f=bv;var g=(bw>O?bw-O:L);var h=bw+D;var i=bj[c+f-1];var j=bj[c+f];if(bv>=bD)b>>=2;do{d=a;if(bj[d+f]!=j||bj[d+f-1]!=i||bj[d]!=bj[c]||bj[++d]!=bj[c+1]){continue}c+=2;d++;do{}while(bj[++c]==bj[++d]&&bj[++c]==bj[++d]&&bj[++c]==bj[++d]&&bj[++c]==bj[++d]&&bj[++c]==bj[++d]&&bj[++c]==bj[++d]&&bj[++c]==bj[++d]&&bj[++c]==bj[++d]&&c<h);e=D-(h-c);c=h-D;if(e>f){bx=a;f=e;if(x){if(e>=D)break}else{if(e>=bE)break}i=bj[c+f-1];j=bj[c+f]}}while((a=bm[a&K])>g&&--b!=0);return f};var cE=function(){var n,m;var a=B-bz-bw;if(a==-1){a--}else if(bw>=o+O){for(n=0;n<o;n++)bj[n]=bj[n+o];bx-=o;bw-=o;bp-=o;for(n=0;n<I;n++){m=ct(n);cu(n,m>=o?m-o:L)}for(n=0;n<o;n++){m=bm[n];bm[n]=(m>=o?m-o:L)}a+=o}if(!by){n=cB(bj,bw+bz,a);if(n<=0)by=true;else bz+=n}};var cF=function(){while(bz!=0&&be==null){var a;cx();if(br!=L&&bw-br<=O){bu=cD(br);if(bu>bz)bu=bz}if(bu>=C){a=cV(bw-bx,bu-C);bz-=bu;if(bu<=bB){bu--;do{bw++;cx()}while(--bu!=0);bw++}else{bw+=bu;bu=0;bq=bj[bw]&0xff;bq=((bq<<bc)^(bj[bw+1]&0xff))&J}}else{a=cV(0,bj[bw]&0xff);bz--;bw++}if(a){cU(0);bp=bw}while(bz<N&&!by)cE()}};var cG=function(){while(bz!=0&&be==null){cx();bv=bu;bs=bx;bu=C-1;if(br!=L&&bv<bB&&bw-br<=O){bu=cD(br);if(bu>bz)bu=bz;if(bu==C&&bw-bx>M){bu--}}if(bv>=C&&bu<=bv){var a;a=cV(bw-1-bs,bv-C);bz-=bv-1;bv-=2;do{bw++;cx()}while(--bv!=0);bt=0;bu=C-1;bw++;if(a){cU(0);bp=bw}}else if(bt!=0){if(cV(0,bj[bw-1]&0xff)){cU(0);bp=bw}bw++;bz--}else{bt=1;bw++;bz--}while(bz<N&&!by)cE()}};var cH=function(){if(by)return;bn=0;bo=0;cK();cC();be=null;bh=0;zip_outoff=0;if(bC<=3){bv=C-1;bu=0}else{bu=C-1;bt=0}bi=false};var cI=function(a,b,c){var n;if(!bf){cH();bf=true;if(bz==0){bi=true;return 0}}if((n=cJ(a,b,c))==c)return c;if(bi)return n;if(bC<=3)cF();else cG();if(bz==0){if(bt!=0)cV(0,bj[bw-1]&0xff);cU(1);bi=true}return n+cJ(a,n+b,c-n)};var cJ=function(a,b,c){var n,i,j;n=0;while(be!=null&&n<c){i=c-n;if(i>be.len)i=be.len;for(j=0;j<i;j++)a[b+n+j]=be.ptr[be.off+j];be.off+=i;be.len-=i;n+=i;if(be.len==0){var p;p=be;be=be.next;cr(p)}}if(n==c)return n;if(zip_outoff<bh){i=c-n;if(i>bh-zip_outoff)i=bh-zip_outoff;for(j=0;j<i;j++)a[b+n+j]=bg[zip_outoff+j];zip_outoff+=i;n+=i;if(bh==zip_outoff)bh=zip_outoff=0}return n};var cK=function(){var n;var a;var b;var c;var d;if(bI[0].dl!=0)return;bK.dyn_tree=bF;bK.static_tree=bH;bK.extra_bits=ck;bK.extra_base=T+1;bK.elems=V;bK.max_length=Q;bK.max_code=0;bL.dyn_tree=bG;bL.static_tree=bI;bL.extra_bits=cl;bL.extra_base=0;bL.elems=W;bL.max_length=Q;bL.max_code=0;bM.dyn_tree=bJ;bM.static_tree=null;bM.extra_bits=cm;bM.extra_base=0;bM.elems=X;bM.max_length=R;bM.max_code=0;b=0;for(c=0;c<S-1;c++){bU[c]=b;for(n=0;n<(1<<ck[c]);n++)bS[b++]=c}bS[b-1]=c;d=0;for(c=0;c<16;c++){bV[c]=d;for(n=0;n<(1<<cl[c]);n++){bT[d++]=c}}d>>=7;for(;c<W;c++){bV[c]=d<<7;for(n=0;n<(1<<(cl[c]-7));n++)bT[256+d++]=c}for(a=0;a<=Q;a++)bN[a]=0;n=0;while(n<=143){bH[n++].dl=8;bN[8]++}while(n<=255){bH[n++].dl=9;bN[9]++}while(n<=279){bH[n++].dl=7;bN[7]++}while(n<=287){bH[n++].dl=8;bN[8]++}cO(bH,V+1);for(n=0;n<W;n++){bI[n].dl=5;bI[n].fc=cZ(n,5)}cL()};var cL=function(){var n;for(n=0;n<V;n++)bF[n].fc=0;for(n=0;n<W;n++)bG[n].fc=0;for(n=0;n<X;n++)bJ[n].fc=0;bF[U].fc=1;cc=cd=0;bX=bY=bZ=0;ca=0;cb=1};var cM=function(a,k){var v=bO[k];var j=k<<1;while(j<=bP){if(j<bP&&cA(a,bO[j+1],bO[j]))j++;if(cA(a,v,bO[j]))break;bO[k]=bO[j];k=j;j<<=1}bO[k]=v};var cN=function(a){var b=a.dyn_tree;var c=a.extra_bits;var d=a.extra_base;var e=a.max_code;var g=a.max_length;var i=a.static_tree;var h;var n,m;var j;var k;var f;var l=0;for(j=0;j<=Q;j++)bN[j]=0;b[bO[bQ]].dl=0;for(h=bQ+1;h<bb;h++){n=bO[h];j=b[b[n].dl].dl+1;if(j>g){j=g;l++}b[n].dl=j;if(n>e)continue;bN[j]++;k=0;if(n>=d)k=c[n-d];f=b[n].fc;cc+=f*(j+k);if(i!=null)cd+=f*(i[n].dl+k)}if(l==0)return;do{j=g-1;while(bN[j]==0)j--;bN[j]--;bN[j+1]+=2;bN[g]--;l-=2}while(l>0);for(j=g;j!=0;j--){n=bN[j];while(n!=0){m=bO[--h];if(m>e)continue;if(b[m].dl!=j){cc+=(j-b[m].dl)*b[m].fc;b[m].fc=j}n--}}};var cO=function(a,b){var c=new Array(Q+1);var d=0;var e;var n;for(e=1;e<=Q;e++){d=((d+bN[e-1])<<1);c[e]=d}for(n=0;n<=b;n++){var f=a[n].dl;if(f==0)continue;a[n].fc=cZ(c[f]++,f)}};var cP=function(a){var b=a.dyn_tree;var c=a.static_tree;var d=a.elems;var n,m;var e=-1;var f=d;bP=0;bQ=bb;for(n=0;n<d;n++){if(b[n].fc!=0){bO[++bP]=e=n;bR[n]=0}else b[n].dl=0}while(bP<2){var g=bO[++bP]=(e<2?++e:0);b[g].fc=1;bR[g]=0;cc--;if(c!=null)cd-=c[g].dl}a.max_code=e;for(n=bP>>1;n>=1;n--)cM(b,n);do{n=bO[P];bO[P]=bO[bP--];cM(b,P);m=bO[P];bO[--bQ]=n;bO[--bQ]=m;b[f].fc=b[n].fc+b[m].fc;if(bR[n]>bR[m]+1)bR[f]=bR[n];else bR[f]=bR[m]+1;b[n].dl=b[m].dl=f;bO[P]=f++;cM(b,P)}while(bP>=2);bO[--bQ]=bO[P];cN(a);cO(b,e)};var cQ=function(a,b){var n;var c=-1;var d;var e=a[0].dl;var f=0;var g=7;var h=4;if(e==0){g=138;h=3}a[b+1].dl=0xffff;for(n=0;n<=b;n++){d=e;e=a[n+1].dl;if(++f<g&&d==e)continue;else if(f<h)bJ[d].fc+=f;else if(d!=0){if(d!=c)bJ[d].fc++;bJ[Y].fc++}else if(f<=10)bJ[Z].fc++;else bJ[ba].fc++;f=0;c=d;if(e==0){g=138;h=3}else if(d==e){g=6;h=3}else{g=7;h=4}}};var cR=function(a,b){var n;var c=-1;var d;var e=a[0].dl;var f=0;var g=7;var h=4;if(e==0){g=138;h=3}for(n=0;n<=b;n++){d=e;e=a[n+1].dl;if(++f<g&&d==e){continue}else if(f<h){do{cy(d,bJ)}while(--f!=0)}else if(d!=0){if(d!=c){cy(d,bJ);f--}cy(Y,bJ);cY(f-3,2)}else if(f<=10){cy(Z,bJ);cY(f-3,3)}else{cy(ba,bJ);cY(f-11,7)}f=0;c=d;if(e==0){g=138;h=3}else if(d==e){g=6;h=3}else{g=7;h=4}}};var cS=function(){var a;cQ(bF,bK.max_code);cQ(bG,bL.max_code);cP(bM);for(a=X-1;a>=3;a--){if(bJ[cn[a]].dl!=0)break}cc+=3*(a+1)+5+5+4;return a};var cT=function(a,b,c){var d;cY(a-257,5);cY(b-1,5);cY(c-4,4);for(d=0;d<c;d++){cY(bJ[cn[d]].dl,3)}cR(bF,a-1);cR(bG,b-1)};var cU=function(a){var b,static_lenb;var c;var d;d=bw-bp;bW[bZ]=ca;cP(bK);cP(bL);c=cS();b=(cc+3+7)>>3;static_lenb=(cd+3+7)>>3;if(static_lenb<=b)b=static_lenb;if(d+4<=b&&bp>=0){var i;cY((r<<1)+a,3);da();cw(d);cw(~d);for(i=0;i<d;i++)cv(bj[bp+i])}else if(static_lenb==b){cY((s<<1)+a,3);cW(bH,bI)}else{cY((t<<1)+a,3);cT(bK.max_code+1,bL.max_code+1,c+1);cW(bF,bG)}cL();if(a!=0)da()};var cV=function(a,b){bl[bX++]=b;if(a==0){bF[b].fc++}else{a--;bF[bS[b]+T+1].fc++;bG[cz(a)].fc++;bk[bY++]=a;ca|=cb}cb<<=1;if((bX&7)==0){bW[bZ++]=ca;ca=0;cb=1}if(bC>2&&(bX&0xfff)==0){var c=bX*8;var d=bw-bp;var e;for(e=0;e<W;e++){c+=bG[e].fc*(5+cl[e])}c>>=3;if(bY<parseInt(bX/2)&&c<parseInt(d/2))return true}return(bX==F-1||bY==H)};var cW=function(a,b){var c;var d;var e=0;var f=0;var g=0;var h=0;var i;var j;if(bX!=0)do{if((e&7)==0)h=bW[g++];d=bl[e++]&0xff;if((h&1)==0){cy(d,a)}else{i=bS[d];cy(i+T+1,a);j=ck[i];if(j!=0){d-=bU[i];cY(d,j)}c=bk[f++];i=cz(c);cy(i,b);j=cl[i];if(j!=0){c-=bV[i];cY(c,j)}}h>>=1}while(e<bX);cy(U,a)};var cX=16;var cY=function(a,b){if(bo>cX-b){bn|=(a<<bo);cw(bn);bn=(a>>(cX-bo));bo+=b-cX}else{bn|=a<<bo;bo+=b}};var cZ=function(a,b){var c=0;do{c|=a&1;a>>=1;c<<=1}while(--b>0);return c>>1};var da=function(){if(bo>8){cw(bn)}else if(bo>0){cv(bn)}bn=0;bo=0};var db=function(){if(bh!=0){var q,i;q=cs();if(be==null)be=zip_qtail=q;else zip_qtail=zip_qtail.next=q;q.len=bh-zip_outoff;for(i=0;i<q.len;i++)q.ptr[i]=bg[zip_outoff+i];bh=zip_outoff=0}};var dc=function(a,b){var i,j;ce=a;cf=0;if(typeof b=="undefined")b=u;cp(b);var c=new Array(1024);var d=[];while((i=cI(c,0,c.length))>0){var e=new Array(i);for(j=0;j<i;j++){e[j]=String.fromCharCode(c[j])}d[d.length]=e.join("")}ce=null;return d.join("")};if(!window.RawDeflate)RawDeflate={};RawDeflate.deflate=dc;

// NobleCount plugin
(function(c){c.fn.NobleCount=function(i,h){var j;var g=false;if(typeof i=="string"){j=c.extend({},c.fn.NobleCount.settings,h);if(typeof h!="undefined"){g=((typeof h.max_chars=="number")?true:false)}return this.each(function(){var k=c(this);f(k,i,j,g)})}return this};c.fn.NobleCount.settings={on_negative:null,on_positive:null,on_update:null,max_chars:140,block_negative:false,cloak:false,in_dom:false};function f(g,m,n,h){var l=n.max_chars;var j=c(m);if(!h){var k=j.text();var i=(/^[1-9]\d*$/).test(k);if(i){l=k}}b(g,j,n,l,true);c(g).keydown(function(o){b(g,j,n,l,false);if(a(o,g,n,l)==false){return false}});c(g).keyup(function(o){b(g,j,n,l,false);if(a(o,g,n,l)==false){return false}})}function a(k,g,l,j){if(l.block_negative){var h=k.which;var i;if(typeof document.selection!="undefined"){i=(document.selection.createRange().text.length>0)}else{i=(g[0].selectionStart!=g[0].selectionEnd)}if((!((e(g,j)<1)&&(h>47||h==32||h==0||h==13)&&!k.ctrlKey&&!k.altKey&&!i))==false){return false}}return true}function e(g,h){return h-(c(g).val()).length}function b(g,i,l,j,h){var k=e(g,j);if(k<0){d(l.on_negative,l.on_positive,g,i,l,k)}else{d(l.on_positive,l.on_negative,g,i,l,k)}if(l.cloak){if(l.in_dom){i.attr("data-noblecount",k)}}else{i.text(k)}if(!h&&jQuery.isFunction(l.on_update)){l.on_update(g,i,l,k)}}function d(i,g,h,j,l,k){if(i!=null){if(typeof i=="string"){j.addClass(i)}else{if(jQuery.isFunction(i)){i(h,j,l,k)}}}if(g!=null){if(typeof g=="string"){j.removeClass(g)}}}})(jQuery);

 //Load in jquery to be used
 if (typeof jQuery == 'undefined') 
 {
 // Create the new script
 var e = document.createElement('script');
 // Set the onload event listener
 e.onload = function() 
 {
 start_bookmarklet();
 };
 // Set the attribute and source
 e.setAttribute('type', 'text/javascript');
 e.setAttribute('src', '//ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js');
 // Append to body
 document.body.appendChild(e);
 } else
 { // Start the bookmarklet
	 start_bookmarklet();
 }

	/**
	 * Start the bookmarklet up
	 */
	function start_bookmarklet()
	{
		/**
		 * Initiate the prototype
		 */
		function sl_bookmarklet()
		{
			var self = this,
				tmp;
			
			// Wipe out any previous stuff going on with the bookmarklet (double click)
			jQuery('.sl-bookmarklet').remove();
			
			// Contents before we start placing our content on top
			this.page_contents = document.body.innerHTML;
			
			// Form URL
			//this.form_url = 'http://app.shoplift.com.patrick/items';
			this.form_url = 'http://mccreary.no-ip.biz:3000/items';
			
			// Starting CSS reset
			this.defaultCSS = {
				display : 'block',
				margin : 0,
				padding : 0,
				border : 0,
				color : '#FFF',
				'font-size' : 14,
				'line-height' : 'normal',
				'font-family' : 'Verdanna',
				'vertical-align' : 'baseline',
				'text-shadow' : 'none',
				'text-align' : 'left',
				outline : 0
			};
			
			// Min height / width for images
			this.min = {
				height : 100,
				width : 100
			}
			
			// URLs we need for form submissions
			//this.submit_url = 'http://shoplift.it.patrick/items';
			this.submit_url = 'http://mccreary.no-ip.biz:3000/items';
			
			// Create the elements we need
			this.el = {
				container : jQuery('<div class="sl-bookmarklet"></div>')
					.css(jQuery.extend(
						{},
						this.defaultCSS,
						{
							position : 'fixed',
							width : '100%',
							height : '100%',
							'z-index' : 2147483647,
							top : 0,
							left : 0,
							cursor : 'pointer'
						}
					))
					.appendTo(document.body),
				background : jQuery('<div title="close" class="sl-bookmarklet"><div/>')
					.css(jQuery.extend(
						{},
						this.defaultCSS,
						{
							position : 'absolute',
							width : '100%',
							height : '100%',
							background : '#000',
							top : 0,
							left : 0,
							'opacity':.5
						}))
					.click(function(){
						self.destroy();
					}),
				iframe : jQuery('<iframe style="display:none !important;" action="' + this.form_url + '" class="sl-bookmarklet"></iframe>'),
				form : jQuery('<form class="sl-bookmarklet" action="' + this.form_url + '"  method="post"></form>')
					.css(jQuery.extend(
						{},
						this.defaultCSS,
						{
							display : 'none',
							position : 'absolute',
							width : 460,
							height : 410,
							background : '#000',
							top : '50%',
							left : '50%',
							'margin-left' : -250,
							'margin-top' : -225,
							cursor : 'auto',
							padding : 20
						}
					)),
				error : jQuery('<div class="sl-bookmarklet">There was a problem lifting the item.</div>')
					.css(jQuery.extend(
						{},
						this.defaultCSS,
						{
							position : 'absolute',
							width : 300,
							height : 200,
							background : '#000',
							'text-align' : 'center',
							'line-height' : '200px',
							display : 'none',
							left : '50%',
							top : '50%',
							cursor : 'auto',
							'font-weight' : 'bold'
						}
					))
			};
			
			// Additional elements that we need to append
			this.el.container.append(this.el.background,this.el.form,this.el.error,this.el.iframe);
							
			// Setup loading message
			this.setError('Parsing page...');
			this.displayError();
			
			// Parse the content
			if(this.assembleForm(this.parse()))
			{
				this.displayForm();
			} else
			{
				this.displayError();
			}
		}
		
		/**
		 * Parse the page for data
		 */
		sl_bookmarklet.prototype.parse = function()
		{
			var self = this,
				fb = {
					title : 'og:title',
					url : 'og:url',
					images : 'og:image',
					retailer : 'og:site_name',
					description : 'og:description',
					url : 'og:url'
				},
				parsed = {
					title : null,
					price : null,
					retailer : null,
					hashtags : [],
					description : null,
					images : [],
					url : escape(document.location.href)
				},
				price_regex = /\$\d[\d.,]*/g,
				tmp;
			
			// Check first for facebook meta tags
			for(var i in fb)
			{ // Loop and query
				tmp = jQuery('meta[property="' + fb[i] + '"]');
				
				if(tmp.length)
				{
					// Images has to be an array
					if(i == 'images')
					{
						parsed[i] = [tmp.attr('content')];
					} else
					{
						parsed[i] = tmp.attr('content');
					}
				}
			}
			
			// Find the keywords
			if((tmp = jQuery('meta[name="keywords"]')).length)
			{ //Split the keywords out
				tmp = tmp.attr('content').split(',');
				//Iterate over and create hashtag
				while(tmp.length > 0)
				{
					parsed.hashtags.push(
						'#' + 
						tmp.pop()
							.replace(/[-_]/g,' ')
							.replace(/[^a-zA-Z 0-9]+/g,'')
							.toLowerCase()
							.replace(/\b[a-z]/g,function(letter){
								return letter.toUpperCase();
							})
							.replace(/\s/g,'')
					);
				}
			}
			
			// Grab description from meta tag if not set already
			if(!parsed.description)
			{
				if((tmp = jQuery('meta[name="description"]')).length)
				{
					parsed.description = tmp.attr('content').trim();
				} 
			}
			
			// Grab the title from meta tag if not already set
			if(!parsed.title)
			{
				if((tmp = jQuery('meta[name="title"]')).length)
				{
					parsed.title = tmp.attr('content').trim();
				} else
				{
					parsed.title = document.title;
				}
			}
			
			// See if we have a price in the description or title
			if(parsed.title)
			{
				parsed.price = (tmp = parsed.title.match(price_regex)) ? tmp[0] : null;
			} else if(parsed.description)
			{
				parsed.price = (tmp = parsed.description.match(price_regex)) ? tmp[0] : null;
			}

			// Use the referrer for url
			if(!parsed.url || parsed.url.length <= 0) {
				parsed.url = escape(document.URL);
			}

			// Use the url if no retailer parsed
			if(!parsed.retailer || parsed.retailer.length <= 0) {
				parsed.retailer = parsed.url;
			}
			
			// Reset tmp
			tmp = {};
			
			// Couldn't get the price, so we start searching everything
			if(!parsed.price || parsed.price === undefined)
			{
				// All elements with price points ($ required)
				jQuery('*',document.body)
					.filter(function()
					{
						return price_regex.test(jQuery(this).text());
					})
					.each(function(){
						var el = jQuery(this);
						tmp.new_height = Number(getComputedStyle(this, '').fontSize.match(/(\d+)px/)[1]);
												
						// First time through
						if(!parsed.price)
						{
							parsed.price = jQuery(this).text().match(price_regex)[0];
							tmp.old_height = tmp.new_height;
						} else
						{
							// Taller font-size (more prominant)
							if(tmp.new_height > tmp.old_height)
							{
								tmp.old_height = tmp.new_height;
								parsed.price = jQuery(this).text().match(price_regex)[0];
							}
						}
					});
					
				if(!parsed.price)
				{
					parsed.price = '';
				}
			}
			
			// Grab all the images you can find (if no fb image set)
			if(!parsed.images.length)
			{	
				tmp = [];
				
				jQuery('img')
					.filter(function(){
						return jQuery(this).height() >= self.min.height && jQuery(this).width() > self.min.width;
					})
					.filter(':visible')
					.each(function(index,el)
					{
						// Order by size with largest being last
						var size = jQuery(this).height() * jQuery(this).width();
						
						for(var i=0;i<=parsed.images.length;i++)
						{
							// No more images
							if(i==parsed.images.length)
							{
								parsed.images.push(jQuery(this).attr('src'));
								tmp.push(size);
								break;
							} else if(size < tmp[i])
							{ //smaller image
									parsed.images.splice(i-1,0,jQuery(this).attr('src'));
									tmp.splice(i-1,0,size);
									break;
							}
						}
						
					});
			}
			
			return parsed;
		}
		
		/**
		 * Assemble the form elements
		 */
		sl_bookmarklet.prototype.assembleForm = function(parsed)
		{
			// Make sure the data is set
			if(!parsed || !parsed.url)
			{
				this.setError('Couldn\'t parse the page');
				return false;
			} else if(!parsed.images.length)
			{
				this.setError('No product images found :(');
				return false;
			}
			
			// Set all the styles, and build the elements
			var self = this,
				i_style = jQuery.extend({},this.defaultCSS,{width:285,height:18,marginLeft:5,color:'#000'}),
				h_style = jQuery.extend({},this.defaultCSS,{width:450,'float':'left',position:'relative'}),
				r_style = jQuery.extend({},this.defaultCSS,{width:285,marginLeft:5,'float':'left',position:'relative',paddingTop:5}),
				f_style = jQuery.extend({},this.defaultCSS,{width:460,'float':'left',position:'relative'}),
				t_style = jQuery.extend({},this.defaultCSS,{width:450,'float':'left',position:'relative',padding:5,height:80,'max-width':460,'max-height':100,color:'#000'}),
				c_style = jQuery.extend({},this.defaultCSS,{'float':'left',position:'relative',fontSize:14}),
				inputs = {
					name : jQuery('<input type="text" name="name" value="' + parsed.title + '" />')
						.css(jQuery.extend({},r_style,i_style)),
					description : jQuery('<textarea name="description">' + parsed.description + '</textarea>')
						.css(t_style),
					brand : jQuery('<input type="text" name="brand" />')
						.css(jQuery.extend({},r_style,i_style)),
					retailer : jQuery('<input type="hidden" name="retailer" value="' + parsed.retailer + '"/>'),
					url : jQuery('<input type="hidden" name="url" value="' + parsed.url + '"/>'),
					price : jQuery('<input type="text" name="price" value="' + parsed.price.replace('$','') + '"/>')
						.css(jQuery.extend({},r_style,i_style)),
					image : jQuery('<input type="hidden" name="image" />'),
					comment : jQuery('<textarea name="comment" maxlength="140"></textarea>')
						.attr('id', 'comment_area')
						.css(t_style),
					submit : jQuery('<input type="submit" value="Shoplift It"/>')
						.css(jQuery.extend({},r_style,{color:'#000',width:'auto','margin-top':10}))
				},
				label = jQuery('<label />');
			
			// Setupt the form and append elements
			this.el.form
				.submit(function(){
					self.validateForm(inputs);
                    if (window.console) console.log(' in submit function invocation');
					return false;
				})
				.append(
					label.clone().text('Shoplift This Item').css(jQuery.extend({},h_style,{'font-size':18,paddingBottom:15})),
					inputs.image,
					assembleImageGallery(parsed.images,inputs.image),
					label.clone().text('Brand').css(jQuery.extend({},r_style,{'padding-top':0,'margin-bottom':3})),
					inputs.brand,
					label.clone().text('Item Name').css(jQuery.extend({},r_style,{'margin-top':6,'margin-bottom':3})),
					inputs.name,
					inputs.retailer,
					inputs.url,
					label.clone().text('Price').css(jQuery.extend({},r_style,{'margin-top':6,'margin-bottom':3})),
					//jQuery('<div>$</div>').css(jQuery.extend({},r_style,{width : 10})),
					inputs.price,
					label.clone()
						.css({'float':'right','width':'100%'}),
					label.clone().text('Comment (')
						.css(jQuery.extend({},c_style))
						.after(jQuery('<span></span> ').css(c_style).attr('id', 'comment_char_count'))
						.after(label.clone().text('characters left)')
							.css(jQuery.extend({},c_style,{'marginLeft':4}))),
					inputs.comment.css('height',50),
					inputs.submit.css({marginLeft:0})
				);
			return true;
			
			/**
			 * Create image gallery
			 */
			function assembleImageGallery(images,input)
			{
				// Setup the styling for everything
				var img_style = jQuery.extend(
						{},
						self.defaultCSS,
						{
							position : 'absolute',
							top : 0,
							left : 0,
							right : 0,
							bottom : 0,
							margin : 'auto',
							'max-width' : '100%',
							'max-height' : '100%'
						}
					),
					img_holder_style = jQuery.extend(
						{},
						self.defaultCSS,
						{
							position : 'relative',
							'float' : 'left',
							'text-align' : 'center',
							width : 150,
							height : 150,
							overflow : 'hidden',
							'line-height' : '150px',
							background : '#FFF'
						}
					),
					btn_style = jQuery.extend(
						{},
						self.defaultCSS,
						{
							position : 'relative',
							'float' : 'left',
							cursor : 'pointer',
							'font-size' : '18px',
							'line-height' : '25px',
							width : 25,
							background : '#999',
							'text-align' : 'center',
							margin : '5px 45px 0 45px'
						}
					),
					container_style = jQuery.extend(
						{},
						self.defaultCSS,
						{
							position : 'relative',
							'float' : 'left',
							width : 150,
							'text-align' : 'center',
							'margin-right' : 15,
							'padding-bottom' : 10
						}
					),
					container = jQuery('<div></div>').css(container_style),
					imageHolder = jQuery('<div></div>').css(img_holder_style).appendTo(container),
					prev = jQuery('<div>&lsaquo;</div>').css(jQuery.extend({},btn_style,{'margin-right':5})),
					next = jQuery('<div>&rsaquo;</div>').css(jQuery.extend({},btn_style,{'margin-left':5})),
					image_el = [],
					current = 0,
					new_images = images;
				
				// We have more than one image	
				if(images.length > 1)
				{
					// Add the buttons
					container.append(prev,next);
					// Set next click
					next.click(function(){
						// Track which image we are on
						current++;
						// Circle back to first image if we are on last
						if(current >= image_el.length)
						{
							current = 0;
						}
						// Place the image in the holder
						imageHolder.html(image_el[current]);
						// Update the input value
						input.val(image_el[current].attr('src'));
						// Make sure nothing else happens for the click
						return false;
					});
					
					prev.click(function(){
						// Track which image we are on
						current--;
						// On first image, so we go to last image
						if(current < 0)
						{
							current = image_el.length-1;
						}
						// Add image to holder
						imageHolder.html(image_el[current]);
						// Update input value
						input.val(image_el[current].attr('src'));
						// Make sure nothing else happens for the click
						return false;
					});
				}
					
				// Create the image objects
				while(new_images.length > 0)
				{
					image_el.push(jQuery('<img src="' + new_images.pop() + '" />').css(img_style));
				}
				
				// Add the first image
				imageHolder.html(image_el[current]);
				// Set the input value for the first image
				input.val(image_el[current].attr('src'));
				
				// Return the div container
				return container;
			}
			
		}
		
		/**
		 * Display the form
		 */
		sl_bookmarklet.prototype.displayForm = function()
		{
			var self = this;
			// Hide the error message (just in case it's up!)
			this.el.error.hide();
			// Show the form
			this.el.form.show();
			
			$('#comment_area').NobleCount('#comment_char_count', {max_chars: 140});
		}
		
		/**
		 * Display the error message
		 */
		sl_bookmarklet.prototype.displayError = function()
		{
			// Hide the form
			this.el.form.hide();
			// Show the error and make sure it is centered
			this.el.error
				.show()
				.css({
					'margin-top' : this.el.error.height()/-2,
					'margin-left' : this.el.error.width()/-2
				});
		}
		
		/**
		 * Set the error message
		 */
		sl_bookmarklet.prototype.setError = function(str)
		{
			this.el.error.text(str);
		}
		
		/**
		 * Check the form for validity
		 */
		sl_bookmarklet.prototype.validateForm = function(inputs)
		{
			// Start with valid equal true for the checks
			var self = this,
				valid = true;
			
			// Iterate over inputs
			for(var i in inputs)
			{
				// Something already valid to validate, so let's skip to the error message
				if(!valid)
				{
					break;
				}
				
				// Pull out the value from the input
				var value = inputs[i].val().trim();
				
				switch (i)
				{
					// Special case with the price
					case 'price':
						valid = value != '' && /^[$]?([0-9][0-9]?([,][0-9]{3}){0,4}([.][0-9]{0,4})?)$|^[$]?([0-9]{1,14})?([.][0-9]{1,4})$|^[$]?[0-9]{1,14}$/.test(value);
						break;
					// Make sure this stuff isn't empty
					case 'brand': case 'image': case 'retailer': case 'url': case 'name':
						valid = value != '';
						break;
					default:
						break;
				}
			}
			
			// Check if form is valid
			if(!valid)
			{ // Alert that there is a problem with form
				alert('Make sure to provide all the nessary and valid data')
			} else
			{ // Everything check's out, so submit the form
				this.submitForm();
			}
			
		}
		
		/**
		 * Submit the form through the iframe
		 */
		sl_bookmarklet.prototype.submitForm = function()
		{
			var self = this,
				ifrm = this.el.iframe[0].contentWindow.document;
			
			// Open the iFrame for writing and clone in the form for submission
			ifrm.open();
			this.el.form.clone().appendTo(jQuery('body',ifrm)).submit();
jQuery('form.sl-bookmarklet').submit();
			// Set the message and display it
			this.setError('Product added!');
			this.displayError();
			// Timeout for hiding the message
			setTimeout(function(){self.destroy()},1000);
		}
		
		/**
		 * Remove the container and the script for the bookmarklet
		 */
		sl_bookmarklet.prototype.destroy = function()
		{
			this.el.container.remove();
			jQuery('#shoplift-bookmarklet-script').remove();
		}
		
		// Start it all off by creating a new bookmarklet
		new sl_bookmarklet();
	}
})();
