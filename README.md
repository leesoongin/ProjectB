 # 프로젝트 B

<br>

## 발생했던 문제

1. 로그인 화면 - AutoLayout
2. Signup - 키보드 이슈


## 처음 써봄

1. UIButton의 isEnabled 속성 
2. ImagePicker 의  allowsEditing, sourceType 속성
3. modal, Navigation 을 상황에 맞게 사용
4. dateFormatter 형식
5. dataPicker 사용법

<br>

---

<br>

## 로그인화면 

<br>

<p><img width="400" height="500" alt="스크린샷 2021-08-20 오후 6 06 37" src="https://user-images.githubusercontent.com/55231029/130416373-064b61fd-6241-4f5d-b170-cb1ddea3cfb4.png">
  <img width="400" height="500" alt="스크린샷 2021-08-20 오후 6 06 37" src="https://user-images.githubusercontent.com/55231029/130422284-c27470d5-eda8-4d97-801a-8c0cb90ae632.png">
</p>

<br>

### 오토레이아웃

부스트 코스의 프로젝트 B 요구사항은 아니지만 ID, Password 를 입력할 때 `키보드 가림 현상` 을 방지하기 위해 `AutoLayout` 을 설정 했다.

>**왜?**
>
기기마다의 **사이즈가 다르기** 때문.
가장 작은 사이즈인 **아이폰4s 에서의 테스트 결과 `ID` , `Password` 를 입력할 때 입력창이 `키보드에 가려짐` 을 확인** 했음
키보드 가림 현상을 방지하는 방법은 많겠지만, 예전에 배웠던 AutoLayout 강의에서 해봤던 기억이 있어 `AutoLayout` 으로 도전!

<br>

**어떻게 했냐!**

1. 우선 id, password, sign in, sign up 버튼을 StackView 에 담아두었어요.

2. 그리고 나서 StackView의 Bottom Margin을 SuperView 에 설정했구요.

3. 키보드가 올라올때에 키보드 노티피케이션을 이용해 키보드 높이 정보를 받아오고, 이때 StackView의 Bottom Margin 값을 키보드 높이로 설정해주면 전체적인 뷰 컴포넌트들이 위로 올라가게 되어서 키보드에 가려지는 현상을 막을 수가 있어요.

4. 마찬가지로 키보드가 내려갈 때에는 StackView의 Bottom Margin을 원상태로 돌려주면 이전과 같은 화면으로 돌려줄 수가 있어요.


<br>

검색이나 강의를 보면서 키보드에 가려질때 처리하는 방법을 많이 배웠었는데, 정말 많은 방법이 있는 것 같아요. 상황에 따라 해줘야하는 작업들이 다 달라서 딱 이거다! 하는 정답은 없었던 것 같아요..

예전에 배웠던걸 복습도 해볼겸해서 만들어봤는데 잘 하진 못했지만 어떻게 해야할까 고민해볼 수 있었던 시간이었던 것 같네요 👍


<br>

---

<br>

## Signup 1 , ImagePicker

<br>

<p><img width="400" height="500" alt="스크린샷 2021-08-20 오후 6 06 37" src="https://user-images.githubusercontent.com/55231029/130416675-e002a87d-6c70-4235-8521-a3264c062260.png">
  <img width="400" height="500" alt="스크린샷 2021-08-20 오후 6 06 37" src="https://user-images.githubusercontent.com/55231029/130417369-f25dc6a1-c299-4c09-ace5-eadd58f1aa8e.png">
  <img width="400" height="500" alt="스크린샷 2021-08-20 오후 6 06 37" src="https://user-images.githubusercontent.com/55231029/130417047-494a030e-0e6f-414d-b76f-869f492d0ffe.png">
</p>

<br>

**1. 키보드 이슈**


![](https://images.velog.io/images/tnddls2ek/post/f0cd962a-888b-4a7e-814f-546da1984d0a/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA%202021-08-23%20%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE%206.31.12.png)

큰 문제가 발생하지는 않았지만 비밀번호, 비밀번호 확인 TextField 를 터치했을때 위와 같은 메세지 로그가 찍히는걸 확인했다. 

앱이 크래시가 나거나 하진 않았지만 너무 찝찝한 마음에 알아보던 도중,, 키보드 확장에 관한 문제인 것을 확인했다.

[Apple application(_:shouldAllowExtensionPointIdentifier:) 문서](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1623122-application)

내용을 확인해보면 **"앱 확장을 사용할 수 있는 권한을 부여하도록 대리인에게 요청합니다."** 라는 문구를 확인할 수 있고, 문서에서 설명하고 있는 `Delegate Method` 를 사용해서 **`키보드 앱 확장` 을 허용하지 않게 되면** 저 에러 메세지는 발생하지 않게 된다.

> 해결법!
>
**AppDelegate 에 작성**
>
```swift
func application(_ application: UIApplication, shouldAllowExtensionPointIdentifier extensionPointIdentifier: UIApplication.ExtensionPointIdentifier) -> Bool {
        if extensionPointIdentifier == UIApplication.ExtensionPointIdentifier.keyboard {
            return false
        }
        return true
    }
```

<br>



**2. UIButton의 isEnabled 속성**


[Apple isEnabled 문서](https://developer.apple.com/documentation/uikit/uicontrol/1618217-isenabled)

UIButton 이 상속하고 있는 UIControl 의 프로퍼티 `isEnabled`

`true` 라면 **사용 가능**, `false` 라면 **사용 불가 **


<br>

**3. ImagePicker 의  allowsEditing, sourceType 속성**

- `allowsEditing` 은 ImagePicker 에서 사용자가 선택한 이미지 혹은 동영상을 편집할 수 있는지에 대한 여부를 나타내는 프로퍼티이다.
[Apple ImagePicker - allowsEditing 문서](https://developer.apple.com/documentation/uikit/uiimagepickercontroller/1619137-allowsediting)

- `sourceType` 은 사용가능한 미디어 유형을 결정할 때 사용하는 프로퍼티
[Apple ImagePicker - sourceType 문서](https://developer.apple.com/documentation/uikit/uiimagepickercontroller/sourcetype)

<br>

---

<br>

## Signup 2

<p><img width="400" height="500" alt="스크린샷 2021-08-20 오후 6 06 37" src="https://user-images.githubusercontent.com/55231029/130417459-eecd402d-600b-4159-9467-37ec6934f2e3.png">
</p>

<br>

**1. dateFormatter **

- dateStyle  

[Apple DateFormatter - dateStyle 문서](https://developer.apple.com/documentation/foundation/dateformatter/1415411-datestyle)

- timeStyle

[Apple DateFormatter - timeStyle 문서](https://developer.apple.com/documentation/foundation/dateformatter/1413467-timestyle)

두 종류가 존재한다. 이거에 대해서는 나중에 자세히 해보는게 나을것 같다.


<br>

**2. dataPicker 사용법 **

<br>
