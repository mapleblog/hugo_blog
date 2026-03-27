### :open_file_folder: file_folder:Pin a folder to taskbar ( Windows 10 & 11 )
Windows 11 does not natively allow you to drag and drop folders directly onto the taskbar. To do this, you must use a workaround that involves creating a shortcut that uses the **Explorer.exe** prefix.



#### Step-by-Step Guide



:one: ​**Create a Desktop Shortcut**:

- Find the folder you want to pin in **File Explorer**.
- Right-click the folder, select **Show more options**, then choose **Send to** > **Desktop (create shortcut)**.



:two: **Modify the Shortcut Properties**:
- Go to your desktop, right-click the new shortcut, and select **Properties**.
- In the **Shortcut** tab, find the **Target** field.
- At the very beginning of the existing path, type `explorer` (the word explorer followed by a **space**).
  - *Example*: If the target was `C:\Work`, it should now look like `explorer C:\Work`.
- Click **Apply** and then **OK**.



:three: ​**Change the Icon (Optional but recommended)**:
- The icon will likely change to a generic File Explorer icon. To change it back, go to **Properties** > **Shortcut** tab > **Change Icon...**.
- Type `imageres.dll` into the box and press **Enter** to see standard Windows folder icons. Select one and click **OK**.



:four: ​**Pin to Taskbar**:
- Right-click your modified desktop shortcut.
- Select **Show more options** and then click **Pin to taskbar**.
- You can now safely delete the shortcut from your desktop; the pinned version will remain. 