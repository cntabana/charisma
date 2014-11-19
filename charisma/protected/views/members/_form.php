<div class="form">


<?php $form = $this->beginWidget('GxActiveForm', array(
	'id' => 'members-form',
	'enableAjaxValidation' => false,
	'htmlOptions' => array(
        'enctype' => 'multipart/form-data',
    ),
));
?>

	<p class="note">
		<?php echo Yii::t('app', 'Fields with'); ?> <span class="required">*</span> <?php echo Yii::t('app', 'are required'); ?>.
	</p>

	<?php echo $form->errorSummary($model); ?>
<table width='100%'>
	  <tr>
	  	<td><div class="row">
		<?php echo $form->labelEx($model,'title'); ?>
		<?php echo $form->dropDownList($model,'title',array('Dr'=>'Dr','Mr'=>'Mr','Miss'=>'Miss','Prof'=>'Prof','Rev'=>'Rev'), array('prompt'=>'Select Title')); ?>
	    <?php echo $form->error($model,'title'); ?>
		</div><!-- row -->
	</td>
	  	<td>
<div class="row">
		<?php echo $form->labelEx($model,'firstname'); ?>
		<?php echo $form->textField($model, 'firstname', array('maxlength' => 20)); ?>
		<?php echo $form->error($model,'firstname'); ?>
		</div><!-- row -->
		
		
	  	</td>
	<td>  	
<div class="row">
		<?php echo $form->labelEx($model,'lastname'); ?>
		<?php echo $form->textField($model, 'lastname', array('maxlength' => 20)); ?>
		<?php echo $form->error($model,'lastname'); ?>
		</div><!-- row -->
	  	</td>
	  </tr>


	   <tr>
	   	<td>
<div class="row">
		<?php echo $form->labelEx($model,'middlename'); ?>
		<?php echo $form->textField($model, 'middlename', array('maxlength' => 20)); ?>
		<?php echo $form->error($model,'middlename'); ?>
		</div><!-- row -->
	  	</td>
	  	
	  	<td>
<div class="row">
		<?php echo $form->labelEx($model,'birthday'); ?>
		<?php $form->widget('zii.widgets.jui.CJuiDatePicker', array(
			'model' => $model,
			'attribute' => 'birthday',
			'value' => $model->birthday,
			'options' => array(
				'showButtonPanel' => true,
				'changeYear' => true,
				'dateFormat' => 'yy-mm-dd',
				),
			));
; ?>
<?php echo $form->error($model,'birthday'); ?>
</div>
	  	</td>
	  	<td>
<!-- row -->
		<div class="row">
		<?php echo $form->labelEx($model,'sex'); ?>
		<?php echo $form->dropDownList($model,'sex',array('0'=>'Male','1'=>'Female'), array('prompt'=>'Select Gender')); ?>
		<?php echo $form->error($model,'sex'); ?>
		</div><!-- row -->

	  	</td>
	  	
	  </tr>

	   <tr>
	  	<td>

<div class="row">
		<?php echo $form->labelEx($model,'cardnumber'); ?>
		<?php echo $form->textField($model, 'cardnumber', array('maxlength' => 15)); ?>
		<?php echo $form->error($model,'cardnumber'); ?>
		</div><!-- row -->
		
		
		
	  	</td>
	  	<td>
	  		<div class="row">
		<?php echo $form->labelEx($model,'issuedate'); ?>
		<?php $form->widget('zii.widgets.jui.CJuiDatePicker', array(
			'model' => $model,
			'attribute' => 'issuedate',
			'value' => $model->issuedate,
			'options' => array(
				'showButtonPanel' => true,
				'changeYear' => true,
				'dateFormat' => 'yy-mm-dd',
				),
			));
     ; ?>
		
<?php echo $form->error($model,'issuedate'); ?>
		</div><!-- row -->
		
	  	</td>
	  	<td>
	  		<div class="row">
		<?php echo $form->labelEx($model,'expireddate'); ?>
		<?php $form->widget('zii.widgets.jui.CJuiDatePicker', array(
			'model' => $model,
			'attribute' => 'expireddate',
			'value' => $model->expireddate,
			'options' => array(
				'showButtonPanel' => true,
				'changeYear' => true,
				'dateFormat' => 'yy-mm-dd',
				),
			));
; ?>
<?php echo $form->error($model,'expireddate'); ?>
		</div><!-- row -->

</td>
	  </tr>
	  <tr>
	  	<td>
<div class="row">
		<?php echo $form->labelEx($model,'email'); ?>
		<?php echo $form->textField($model, 'email', array('maxlength' => 50)); ?>
		<?php echo $form->error($model,'email'); ?>
		</div><!-- row -->

		
</td>
<td>  
<div class="row">
		<?php echo $form->labelEx($model,'iddistrict'); ?>
		<?php
        $district = CHtml::listData(District::model()->findAll(array('order'=>'district')), 'id', 'district');
		echo CHtml::activeDropDownList($model, 'iddistrict', $district, array('id'=>'id_district','prompt'=>'Select Colleges')); 
		?>
		<?php echo $form->error($model,'iddistrict'); ?>
		</div><!-- row -->
</td>
<td>
<div class="row">
		<?php echo $form->labelEx($model,'idsector'); ?>
		<?php 
		$sector= CHtml::listData(Sector::model()->findAll('iddistrict=:iddistrict', array(':iddistrict'=>$model->iddistrict)), 'id', 'sector'); 
		echo CHtml::activeDropDownList($model, 'idsector', $sector, array('id'=>'id_umurenge','prompt'=>'Select Department')); 
		ECascadeDropDown::master('id_district')->setDependent('id_umurenge',array('dependentLoadingLabel'=>'Loading Departments ...'),'site/citydata'); 
		?>
		<?php echo $form->error($model,'idsector'); ?>
		</div><!-- row -->
</td>

</tr>
	   <tr>
	  	<td><div class="row">
		<?php echo $form->labelEx($model,'address'); ?>
		<?php echo $form->textField($model, 'address', array('maxlength' => 30)); ?>
		<?php echo $form->error($model,'address'); ?>
		</div><!-- row -->
	</td>
	  	<td><div class="row">
		<?php echo $form->labelEx($model,'nationality'); ?>
		<?php echo $form->textField($model, 'nationality', array('maxlength' => 40)); ?>
		<?php echo $form->error($model,'nationality'); ?>
		</div><!-- row -->
	</td>
	  	<td>
		<div class="row">
		<?php echo $form->labelEx($model,'phonenumber'); ?>
		<?php echo $form->textField($model, 'phonenumber', array('maxlength' => 20)); ?>
		<?php echo $form->error($model,'phonenumber'); ?>
		</div><!-- row -->
	  	</td>
	  </tr>

	   <tr valign='top'>
	  	<td>
	  		<div class="row">
		<?php echo $form->labelEx($model,'type'); ?>
		<?php echo $form->dropDownList($model,'type',array('0'=>'Student','1'=>'Staff'), array('prompt'=>'Select Type')); ?>
		<?php echo $form->error($model,'type'); ?>
		</div><!-- row -->
	</td>
	<td><div class="row">
		<?php echo $form->labelEx($model,'status'); ?>
		<?php echo $form->dropDownList($model,'status',array('1'=>'Active','0'=>'Inactive'), array('prompt'=>'Select Status')); ?>
	    <?php echo $form->error($model,'status'); ?>
		</div><!-- row -->
	</td>
	  	<td>
	  		<div class="row">
		<?php echo $form->labelEx($model,'photo'); ?>
		<?php //echo $form->textField($model, 'photo', array('maxlength' => 50)); ?>
		<?php echo CHtml::activeFileField($model, 'photo'); ?> 
		<?php echo $form->error($model,'photo'); ?>
		</div><!-- row -->
		<?php if($model->isNewRecord!='1'){ ?>
	          <div class="row">
	                 <?php echo CHtml::image(Yii::app()->request->baseUrl.'/pictures/'.$model->photo,"photo",array("width"=>200)); ?>  
	           </div>
	    <?php } ?>
	</td>
	  	<td>&nbsp;</td>
	  </tr>
</table>
				
		

		<label><?php //echo GxHtml::encode($model->getRelationLabel('beneficaires')); ?></label>
		<?php //echo $form->checkBoxList($model, 'beneficaires', GxHtml::encodeEx(GxHtml::listDataEx(Beneficaire::model()->findAllAttributes(null, true)), false, true)); ?>
		<label><?php //echo GxHtml::encode($model->getRelationLabel('invoices')); ?></label>
		<?php //echo $form->checkBoxList($model, 'invoices', GxHtml::encodeEx(GxHtml::listDataEx(Invoice::model()->findAllAttributes(null, true)), false, true)); ?>

<?php
echo GxHtml::submitButton(Yii::t('app', 'Save'));
$this->endWidget();
?>
</div><!-- form -->