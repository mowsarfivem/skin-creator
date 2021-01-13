local a={255,255,255}local b={0,0,0}local c={"commonmenu","interaction_bgd"}local d={{name="Vide"}}local e,f=.24,.175;local g,h=.225,.035;local j,k=.225,.0675;local l={}local m=.25;local n=DrawSprite;local BeginTextCommandWidth=BeginTextCommandWidth;local AddTextComponentSubstringPlayerName=AddTextComponentSubstringPlayerName;local SetTextFont=SetTextFont;local SetTextScale=SetTextScale;local EndTextCommandGetWidth=EndTextCommandGetWidth;local GetControlNormal=GetControlNormal;local RequestStreamedTextureDict=RequestStreamedTextureDict;local SetStreamedTextureDictAsNoLongerNeeded=SetStreamedTextureDictAsNoLongerNeeded;local IsControlPressed=IsControlPressed;local IsDisabledControlPressed=IsDisabledControlPressed;local IsControlJustPressed=IsControlJustPressed;local UpdateOnscreenKeyboard=UpdateOnscreenKeyboard;local SetTextDropShadow=SetTextDropShadow;local SetTextEdge=SetTextEdge;local SetTextColour=SetTextColour;local SetTextJustification=SetTextJustification;local SetTextWrap=SetTextWrap;local SetTextEntry=SetTextEntry;local AddTextComponentString=AddTextComponentString;local DrawText=DrawText;local DrawRect=DrawRect;local AddTextEntry=AddTextEntry;local DisplayOnscreenKeyboard=DisplayOnscreenKeyboard;local GetOnscreenKeyboardResult=GetOnscreenKeyboardResult;local ShowCursorThisFrame=ShowCursorThisFrame;local DisableControlAction=DisableControlAction;local o={[0]={"commonmenu","shop_box_blank"},[1]={"commonmenu","shop_box_tickb"},[2]={"commonmenu","shop_box_tick"}}local function p(q,r,s)BeginTextCommandWidth("STRING")AddTextComponentSubstringPlayerName(q)SetTextFont(r or 0)SetTextScale(1.0,s or 0)return EndTextCommandGetWidth(true)end;function IsMouseInBounds(t,u,v,w)local x,y=GetControlNormal(0,239)+v/2,GetControlNormal(0,240)+w/2;return x>=t and x<=t+v and(y>u and y<u+w)end;function l:resetMenu()self.Data={back={},currentMenu="",intY=f,intX=e}self.Pag={1,10,1,1}self.Base={Header=c,Color=b,HeaderColor=a,Title=GM and GM.State.user and GM.State.user.name or"Menu",Checkbox={Icon=o}}self.Menu={}self.Events={}self.tempData={}self.IsVisible=false end;function stringsplit(z,A)if not z then return end;if A==nil then A="%s"end;local B={}i=1;for q in string.gmatch(z,"([^"..A.."]+)")do B[i]=q;i=i+1 end;return B end;function SetMenuVisible(C)IsVisible=C end;function l:CloseMenu(D)if self.IsVisible and(not self.Base.Blocked or D)then self.IsVisible=false;if self.Events["onExited"]then self.Events["onExited"](self.Data,self,true)end;SetMenuVisible(false)self:resetMenu()end end;function l:GetButtons(E)local F=E or self.Data.currentMenu;local G=self.Menu and self.Menu[F]local allButtons=G and G.b;if not allButtons then return{}end;local H={}allButtons=type(allButtons)=="function"and allButtons(self,F)or allButtons;if not allButtons or type(allButtons)~="table"then return{}end;if self.Events and self.Events["onLoadButtons"]then allButtons=self.Events["onLoadButtons"](self,F,allButtons)or allButtons end;for I,J in pairs(allButtons)do if J and type(J)=="table"and(J.canSee and(type(J.canSee)=="function"and J.canSee()or J.canSee==true)or J.canSee==nil)and(not G.filter or string.find(string.lower(J.name),G.filter))then if J.customSlidenum then J.slidenum=type(J.customSlidenum)=="function"and J.customSlidenum()or J.customSlidenum end;local K=type(J.slidemax)=="function"and J.slidemax(J,self)or J.slidemax;if type(K)=="number"then local L={}for i=0,K do L[#L+1]=i end;K=L end;if K then J.slidenum=J.slidenum or 1;local M=K[J.slidenum]if M then J.slidename=M and type(M)=="table"and M.name or tostring(M)end end;H[#H+1]=J end end;if#H<=0 then H=d end;self.tempData={H,#H}return H,#H end;function l:OpenMenu(N,O)if N and not self.Menu[N]then print("[pMenu] "..N.." cannot be opened, the menu doesn't exist.")return end;local P,Q=self:GetButtons(N)if not O and self.Data and self.Data.back then self.Data.back[#self.Data.back+1]=self.Data.currentMenu end;if O then self.Data.back[#self.Data.back]=nil end;local R=O and self.Pag[4]or 1;local K=math.max(10,math.min(R))self.Pag={K-9,K,R,self.Pag[3]or 1}self.tempData={P,Q}self.Data.currentMenu=N;if self.Events and self.Events["onButtonSelected"]then self.Events["onButtonSelected"](self.Data.currentMenu,self.Pag[3],self.Data.back,P[1]or{},self)end end;function l:Back()local S=#self.Data.back;if S==0 and not self.Base.Blocked then self:CloseMenu()elseif S>0 and not self.Base.BackBlocked then self:OpenMenu(self.Data.back[#self.Data.back],true)if self.Events["onBack"]then self.Events["onBack"](self.Data,self)end end end;function l:CreateMenu(T,U)if self.Base and self.Base.Blocked and self.IsVisible and IsMenuOpened()or not T then return end;if not self.IsVisible and T then self:resetMenu()T.Base=T.Base or{}for V,J in pairs(T.Base)do if V=="Header"then RequestStreamedTextureDict(J[1])SetStreamedTextureDictAsNoLongerNeeded(J[1])end;self.Base[V]=J end;T.Data=T.Data or{}for V,J in pairs(T.Data)do self.Data[V]=J end;T.Events=T.Events or{}for V,J in pairs(T.Events)do self.Events[V]=J end;T.Menu=T.Menu or{}for V,J in pairs(T.Menu)do self.Menu[V]=J end;self.Data.temp=U;self.Base.CustomHeader=self.Base.Header and self.Base.Header[2]~="interaction_bgd"f=self.Base.CustomHeader and.205 or.17;if self.Events["onButtonSelected"]then local allButtons,W=self:GetButtons()self.tempData={allButtons,W}self.Events["onButtonSelected"](self.Data.currentMenu,1,{},allButtons[1]or{},self)end;self:OpenMenu(self.Data.currentMenu)local X=self.Base and self.Base.Blocked or not self.IsVisible;self.IsVisible=X;SetMenuVisible(X)if self.IsVisible and self.Events and self.Events["onOpened"]then self.Events["onOpened"](self.Data,self)end else self:CloseMenu(true)end end;local Y;function l:ProcessControl()local Z,_,a0,a1=IsControlPressed(1,172),IsControlPressed(1,173),IsControlPressed(1,175),IsControlPressed(1,174)local a2=self.Menu and self.Menu[self.Data.currentMenu]local a3,Q=table.unpack(self.tempData)local a4=a3 and a3[self.Pag[3]]if a2 and a2.refresh and(not Y or GetGameTimer()>=Y)then Y=GetGameTimer()+(a2.refresh==true and 1 or a2.refresh)self:GetButtons()end;if(Z or _)and Q and self.Pag[3]then if _ and self.Pag[3]<Q or Z and self.Pag[3]>1 then self.Pag[3]=self.Pag[3]+(_ and 1 or-1)if Q>10 and(Z and self.Pag[3]<self.Pag[1]or _ and self.Pag[3]>self.Pag[2])then self.Pag[1]=self.Pag[1]+(_ and 1 or-1)self.Pag[2]=self.Pag[2]+(_ and 1 or-1)end else self.Pag={Z and Q-9 or 1,Z and Q or 10,_ and 1 or Q,self.Pag[4]or 1}if Q>10 and(Z and self.Pag[3]>self.Pag[2]or _ and self.Pag[3]<self.Pag[1])then self.Pag[1]=self.Pag[1]+(_ and-1 or 1)self.Pag[2]=self.Pag[2]+(_ and-1 or 1)end end;local a5=a3[self.Pag[3]]if self.Events["onButtonSelected"]and a5 and self:canUseButton(a5)then self.Events["onButtonSelected"](self.Data.currentMenu,self.Pag[3],self.Data.back,a5,self)end;Citizen.Wait(125)end;if(a0 or a1)and a4 and self:canUseButton(a4)then local a6=a4.slide or a2.slide or self.Events["onSlide"]if a2.slidemax or a4 and a4.slidemax or self.Events["onSlide"]or a6 then local a7=a2.slidemax and a2 or a4.slidemax and a4;if a7 and not a7.slidefilter or a7 and not tableHasValue(a7.slidefilter,self.Pag[3])then a4.slidenum=a4.slidenum or 0;local K=type(a7.slidemax)=="function"and(a7.slidemax(a4,self)or 0)or a7.slidemax;if type(K)=="number"then local L={}for i=0,K do L[#L+1]=i end;K=L end;a4.slidenum=a4.slidenum+(a0 and 1 or-1)if a0 and a4.slidenum>#K or a1 and a4.slidenum<1 then a4.slidenum=a0 and 1 or#K end;local M=K[a4.slidenum]a4.slidename=M and type(M)=="table"and M.name or tostring(M)local a8=p(a4.slidename,0,0.35)a4.offset=a8;if a6 then a6(self.Data,a4,self.Pag[3],self)end;Citizen.Wait(a2.slidertime or 175)end end;if a4.parentSlider~=nil and self:canUseButton(a4)and(a1 and a4.parentSlider<1.5+m or a0 and a4.parentSlider>.5-m)then a4.parentSlider=a1 and round(a4.parentSlider+.01,2)or round(a4.parentSlider-.01,2)if self.Events["onSlider"]then self.Events["onSlider"](self,self.Data,a4,self.Pag[3],allButtons,a4.parentSlider-m)end;Citizen.Wait(10)end end;if a2 and a2.extra or a4 and a4.opacity then if a4.advSlider and IsDisabledControlPressed(0,24)then local a9,aa,ab=table.unpack(self.Data.advSlider)local ac,ad=IsMouseInBounds(a9-0.01,self.Height,.015,.03),IsMouseInBounds(a9-ab+0.01,self.Height,.015,.03)if ac or ad then local ae=1;a4.advSlider[3]=math.max(a4.advSlider[1],math.min(a4.advSlider[2],ad and a4.advSlider[3]-ae or ac and a4.advSlider[3]+ae))self.Events["onAdvSlide"](self,self.Data,a4,self.Pag[3],a3)end;Citizen.Wait(75)end end;if IsControlJustPressed(1,202)and UpdateOnscreenKeyboard()~=0 then self:Back()Citizen.Wait(100)end;if self.Pag[3]and Q and self.Pag[3]>Q then self.Pag={1,10,1,self.Pag[4]or 1}end end;function DrawText2(af,ag,ah,ai,aj,ak,al,am,an)SetTextFont(af)SetTextScale(ah,ah)if al then SetTextDropShadow(0,0,0,0,0)SetTextEdge(0,0,0,0,0)end;SetTextColour(ak[1],ak[2],ak[3],255)if am==0 then SetTextCentre(true)else SetTextJustification(am or 1)if am==2 then SetTextWrap(.0,an or ai)end end;SetTextEntry("STRING")AddTextComponentString(ag)DrawText(ai,aj)end;function l:canUseButton(ao)if not ao.role then return true end;if not GM or not GM.State or not GM.State.user or not GetLinkedRoles then return false end;if ao.role then local ap=GM.State.user.group;return ap and tableHasValue(GetLinkedRoles(ap),ao.role)end;return false end;function l:getHelpTextForBlockedButton(ao)if ao.role then return"Vous n'avez pas le grade requis."end end;function l:drawMenuButton(ao,aq,ar,as,at,au,av)local aw,ax,ay=as and(ao.colorSelected or{255,255,255,255})or(ao.colorFree or{0,0,0,100}),.0,self.Menu[self.Data.currentMenu]DrawRect(aq,ar,at,au,aw[1],aw[2],aw[3],aw[4])aw=as and b or a;local az=(ao.r and((GM and(GM.jobRank<ao.r or GM.copRank<ao.r)or ao.rfunc and not ao.rfunc())and"~r~"or"")or"")..(self.Events["setPrefix"]and self.Events["setPrefix"](ao,self.Data)or"")or""DrawText2(0,(ao.price and"> "or"")..az..(ao.name or""),.275,aq-at/2+.005,ar-au/2+.0025,aw)local aA=ay and ay.checkbox or ao.checkbox~=nil and ao.checkbox;local a6=ao.slidemax and ao or ay;local aB=a6 and a6.slidemax and(not a6.slidefilter or not tableHasValue(a6.slidefilter,av))local aC=self:canUseButton(ao)if aC then if ao.name and self.Menu[string.lower(ao.name)]and not ay.item and not aB then n("commonmenutu","arrowright",aq+at/2.2,ar,.009,.018,0.0,aw[1],aw[2],aw[3],255)ax=.0125 end;if aA~=nil and(ao.checkbox~=nil or ay and ay.checkbox~=nil)then local C=aA~=nil and(type(aA)=="function"and aA(GetPlayerPed(-1),ao,self.Base.currentMenu,self))or aA;if ao.locked then C=C and C==true and 2 or 0 else C=C and C==true and 1 or 0 end;if not self.Base.Checkbox["Icon"]or self.Base.Checkbox["Icon"][C]then local aD=self.Base.Checkbox["Icon"]and self.Base.Checkbox["Icon"][C]if aD and aD[1]and aD[2]then local aE=as and C==0 and b or a;n(aD[1],aD[2],aq+at/2.2,ar,.023,.045,0.0,aE[1],aE[2],aE[3],255)return end end elseif aB or ao.ask or ao.slidename then local K=aB and a6 and(type(a6.slidemax)=="function"and a6.slidemax(ao,self)or a6.slidemax)if K and type(K)=="number"and K>0 or type(K)=="table"and#K>0 or not aB then local aF=aB and ao.slidenum or 1;local aG=ao.ask and(type(ao.ask)=="function"and ao.ask(self)or ao.askValue or ao.ask)or(ao.slidename or(type(K)=="number"and aF-1 or type(K[aF])=="table"and K[aF].name or tostring(K[aF])))aG=tostring(aG)if as and aB then n("commonmenu","arrowright",aq+at/2-.01025,ar+0.0004,.009,.018,0.0,aw[1],aw[2],aw[3],255)ao.offset=p(aG,0,.275)n("commonmenu","arrowleft",aq+at/2-ao.offset-.016,ar+0.0004,.009,.018,0.0,aw[1],aw[2],aw[3],255)end;local aH=(not as or ao.ask)and-.004 or-.0135;DrawText2(0,aG,.275,aq+at/2+aH,ar-au/2+.00375,aw,false,2)aq=as and aq-.0275 or aq-.0125 end end;if ao.parentSlider~=nil then local aI,aJ=aq+.0925,ar+0.005;local aK,aL=.1,0.01;local aM="mpleaderboard"n(aM,"leaderboard_female_icon",aq+at/2-.01025,ar+0.0004,.0156,.0275,0.0,aw[1],aw[2],aw[3],255)n(aM,"leaderboard_male_icon",aq-.015,ar+0.0004,.0156,.0275,0.0,aw[1],aw[2],aw[3],255)local aN=aK*ao.parentSlider;DrawRect(aI-aK/2,aJ-aL/2,aK,aL,4,32,57,255)DrawRect(aI-aN/2,aJ-aL/2,aK*m,aL,57,116,200,255)DrawRect(aI-aK/2,aJ-aL/2,.002,aL+0.005,aw[1],aw[2],aw[3],255)end;local aO=self.Events["setBonus"]and self.Events["setBonus"](ao,self.Data.currentMenu,self)or ao.amount and ao.amount or ao.price and"~g~"..math.floor(ao.price).."$"if aO and string.len(aO)>0 then DrawText2(0,aO,.275,aq+at/2-.005-ax,ar-au/2+.00375,aw,true,2)end else n("commonmenu","shop_lock",aq+at/2.15,ar,.02,.034,0.0,aw[1],aw[2],aw[3],255)end end;local function aP(q,aQ)if tostring(q)then local aR=g+.025;local aS=0;local aT=""local aU=stringsplit(tostring(q)," ")for i=1,#aU do local aV=p(aU[i],0,aQ)aS=aS+aV;if aS>aR then aT=aT.."\n"..aU[i].." "aS=aV+0.003 else aT=aT..aU[i].." "aS=aS+0.003 end end;return aT end end;function l:DrawButtons(aW)local aX,aY=0.0175,0.0475;for av,aZ in ipairs(aW)do local a_=av>=self.Pag[1]and av<=self.Pag[2]if a_ then local as=av==self.Pag[3]self:drawMenuButton(aZ,self.Width-g/2,self.Height,as,g,h-0.005,av)self.Height=self.Height+aY-aX;if not aZ.locked and as and IsControlJustPressed(1,201)and aZ.name~="Vide"and self:canUseButton(aZ)then if self.Events["setCheckbox"]then self.Events["setCheckbox"](self.Data,aZ)end;local b0=aZ.slide or self.Events["onSlide"]if b0 or aZ.checkbox~=nil then if not b0 then aZ.checkbox=not aZ.checkbox else b0(self.Data,aZ,av,self)end end;local b1,b2=self.Events["onSelected"],false;if b1 then if aZ.slidemax and not aZ.slidenum and type(aZ.slidemax)=="table"then aZ.slidenum=1;aZ.slidename=aZ.slidemax[1]end;aZ.slidenum=aZ.slidenum or 1;if aZ.ask and not aZ.askX then if aZ.name then AddTextEntry('FMMC_KEY_TIP8',aZ.askTitle or aZ.name)end;local b3=type(aZ.ask)=="function"and aZ.ask(self)or aZ.ask;DisplayOnscreenKeyboard(false,"FMMC_KEY_TIP8","",b3 or"","","","",60)while UpdateOnscreenKeyboard()==0 do Citizen.Wait(50)if UpdateOnscreenKeyboard()==1 and GetOnscreenKeyboardResult()and string.len(GetOnscreenKeyboardResult())>=1 then aZ.askValue=GetOnscreenKeyboardResult()end end end;b2=b1(self,self.Data,aZ,self.Pag[3],aW)end;if not b2 and self.Menu[string.lower(aZ.name)]then self:OpenMenu(string.lower(aZ.name))end end end end end;function l:DrawHeader(b4)local b5,b6=table.unpack(self.Base.Header)local b7=b5 and string.len(b5)>0;local a2=self.Menu[self.Data.currentMenu]local b8=a2 and a2["customSub"]and a2["customSub"]()or string.format("%s/%s",self.Pag[3],b4)if b7 then local au=self.Base.CustomHeader and 0.1025 or k;n(b5,b6,self.Width-j/2,self.Height-au/2,j,au,.0,self.Base.HeaderColor[1],self.Base.HeaderColor[2],self.Base.HeaderColor[3],215)self.Height=self.Height-0.03;if not self.Base.CustomHeader then DrawText2(1,self.Base.Title,.7,self.Width-j/2,self.Height-au/2+.0125,a,false,0)end end;self.Height=self.Height+0.06;local b9,ba=g,h-.005;DrawRect(self.Width-b9/2,self.Height-ba/2,b9,ba,self.Base.Color[1],self.Base.Color[2],self.Base.Color[3],255)self.Height=self.Height+0.005;DrawText2(0,firstToUpper(self.Data.currentMenu),.275,self.Width-b9+.005,self.Height-ba-0.0015,a,true)self.Height=self.Height+0.005;DrawText2(0,b8,.275,self.Width-b9/2+.11,self.Height-h,a,true,2)if a2 and a2.charCreator then local j,k=.225,.21;self.Height=self.Height+k-0.01;local bb="pause_menu_pages_char_mom_dad"local bc="char_creator_portraits"n(bb,"mumdadbg",self.Width-j/2,self.Height-k/2,j,k,0.0,255,255,255,255)if a2.father then j,k=.11875,.2111;n(bc,a2.father,self.Width-j/2,self.Height-k/2,j,k,0.0,255,255,255,255)end;if a2.mother then j,k=.11875,.2111;local bd=self.Width-.1;n(bc,a2.mother,bd-j/2,self.Height-k/2,j,k,0.0,255,255,255,255)self.Height=self.Height+0.01 end end;self.Height=self.Height+0.005 end;function l:DrawHelpers(aW)local be=self.Base;local a2=self.Data.currentMenu;local bf=aW[self.Pag[3]]local bg=bf and bf.Description or self.Menu[a2]and self.Menu[a2].Description or be.Description;if bf and not self:canUseButton(bf)then bg=self:getHelpTextForBlockedButton(bf)end;if bg then local au,s=0.0275,0.275;self.Height=self.Height-0.015;DrawRect(self.Width-g/2,self.Height,g,0.0025,0,0,0,255)local bh=aP(bg,s)local bi=#stringsplit(bh,"\n")local bj=au+bi*0.016;self.Height=self.Height+au/2;local aX=0.015;DrawSprite("commonmenu","gradient_bgd",self.Width-g/2,self.Height+bj/2-aX,g,bj,.0,255,255,255,255)DrawText2(0,bh,s,self.Width-g+.005,self.Height-aX+0.005,a)end end;function round(bk,bl)local bm=10^(bl or 0)return math.floor(bk*bm+0.5)/bm end;function l:DrawExtra(aW)local ao=aW[self.Pag[3]]if not ao or not self:canUseButton(ao)then return end;ShowCursorThisFrame()DisableControlAction(0,1,true)DisableControlAction(0,2,true)DisableControlAction(0,24,true)DisableControlAction(0,25,true)if ao and ao.opacity~=nil then local aK,aL=g,0.055;self.Height=self.Height-0.01;n("commonmenu","gradient_bgd",self.Width-aK/2,self.Height+aL/2,aK,aL,0.0,255,255,255,255)self.Height=self.Height+0.005;DrawText2(0,"0%",0.275,self.Width-g+.005,self.Height,a,false,1)DrawText2(0,"Opacité",0.275,self.Width-g/2,self.Height,a,false,0)DrawText2(0,"100%",0.275,self.Width-0.005,self.Height,a,false,2)self.Height=self.Height+.033;local b9,ba=.215,0.015;local bn=b9*(1-ao.opacity)local aI,aJ=self.Width-b9/2-0.005,self.Height;local bd=self.Width-bn/2-0.005;DrawRect(aI,aJ,b9,ba,245,245,245,255)DrawRect(bd,aJ,bn,ba,87,87,87,255)if IsDisabledControlPressed(0,24)and IsMouseInBounds(aI,aJ,b9,ba)then local bo=GetControlNormal(0,239)-aL/2;ao.opacity=round(math.max(0.0,math.min(1.0,bo/b9)),2)self.Events["onSlide"](self.Data,ao,self.Pag[3],self)end;self.Height=self.Height+0.025 end;if ao and ao.advSlider~=nil then local aK,aL=g,0.055;n("commonmenu","gradient_bgd",self.Width-aK/2,self.Height+aL/2,aK,aL,0.0,255,255,255,255)self.Height=self.Height+0.005;ao.advSlider[3]=ao.advSlider[3]or 0;DrawText2(0,tostring(ao.advSlider[1]),0.275,self.Width-g+.005,self.Height,a,false,1)DrawText2(0,"Variations disponibles",0.275,self.Width-g/2,self.Height,a,false,0)DrawText2(0,tostring(ao.advSlider[2]),0.275,self.Width-0.005,self.Height,a,false,2)self.Height=self.Height+.03;n("commonmenu","arrowright",self.Width-0.01,self.Height,.015,.03,0.0,255,255,255,255)n("commonmenu","arrowleft",self.Width-aK+0.01,self.Height,.015,.03,0.0,255,255,255,255)local b9,ba=.19,0.015;local aI,aJ=self.Width-aK/2,self.Height;DrawRect(aI,aJ,b9,ba,87,87,87,255)local bp=b9/(ao.advSlider[2]+1)local bq=ao.advSlider[2]*bp/2;local bd=aI-bq+bp*ao.advSlider[3]/ao.advSlider[2]*ao.advSlider[2]DrawRect(bd,aJ,bp,ba,245,245,245,255)self.Data.advSlider={self.Width,self.Height,aK}end end;function l:Draw()local aW,b4=table.unpack(self.tempData)self.Height=self.Base and self.Base.intY or f;self.Width=self.Base and self.Base.intX or e;if aW and b4 and not self.Invisible then self:DrawHeader(b4)self:DrawButtons(aW)self:DrawHelpers(aW)local a2,bf=self.Menu[self.Data.currentMenu],self.Pag[3]and aW and aW[self.Pag[3]]if a2 and(a2.extra or bf and bf.opacity)then self:DrawExtra(aW)end;if a2 and a2.useFilter then local br=75;DisableControlAction(1,br,true)if IsDisabledControlJustPressed(1,br)then AskEntry(function(bs)a2.filter=bs and string.len(bs)>0 and string.lower(bs)or false;self:GetButtons()end,"Filtre",30,a2.filter)end end end;if self.Events and self.Events["onRender"]then self.Events["onRender"](self,aW,aW[self.Pag[3]],self.Pag[3])end end;function CloseMenu(bt)return l:CloseMenu(bt)end;function CreateMenu(bu,U)return l:CreateMenu(bu,U)end;function OpenMenu(N)return l:OpenMenu(N)end;function AskEntry(bv,bw,bx,by)AddTextEntry('FMMC_KEY_TIP8',bw or"Montant")DisplayOnscreenKeyboard(false,"FMMC_KEY_TIP8","",by,"","","",bx or 60)while UpdateOnscreenKeyboard()==0 do Citizen.Wait(10)if UpdateOnscreenKeyboard()>=1 then bv(GetOnscreenKeyboardResult())break end end end;Citizen.CreateThread(function()while true do Citizen.Wait(0)if l.IsVisible then l:Draw()end end end)Citizen.CreateThread(function()while true do Citizen.Wait(0)if l.IsVisible and not l.Invisible then l:ProcessControl()end end end)function firstToUpper(q)return q:gsub("^%l",string.upper)end;function DrawSub(bz,bA)ClearPrints()BeginTextCommandPrint('STRING')AddTextComponentSubstringPlayerName(bz)EndTextCommandPrint(bA,1)end;function KeyboardInput(bB,bC,bD)AddTextEntry("FMMC_KEY_TIP1",bB)DisplayOnscreenKeyboard(1,"FMMC_KEY_TIP1","",bC,"","","",bD)blockinput=true;while UpdateOnscreenKeyboard()~=1 and UpdateOnscreenKeyboard()~=2 do Citizen.Wait(0)end;if UpdateOnscreenKeyboard()~=2 then local bE=GetOnscreenKeyboardResult()Citizen.Wait(500)blockinput=false;return bE else Citizen.Wait(500)blockinput=false;return nil end end;function RefreshMenu(bF)return l:resetMenu(bF)end
