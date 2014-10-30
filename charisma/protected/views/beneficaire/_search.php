<div class="wide form">

<?php $form = $this->beginWidget('GxActiveForm', array(
	'action' => Yii::app()->createUrl($this->route),
	'method' => 'get',
)); ?>

	<div class="row">
		<?php echo $form->label($model, 'id'); ?>
		<?php echo $form->textField($model, 'id'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'photo'); ?>
		<?php echo $form->textField($model, 'photo', array('maxlength' => 100)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'firstname'); ?>
		<?php echo $form->textField($model, 'firstname', array('maxlength' => 20)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'middlename'); ?>
		<?php echo $form->textField($model, 'middlename', array('maxlength' => 20)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'lastname'); ?>
		<?php echo $form->textField($model, 'lastname', array('maxlength' => 20)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'dateofbirth'); ?>
		<?php $form->widget('zii.widgets.jui.CJuiDatePicker', array(
			'model' => $model,
			'attribute' => 'dateofbirth',
			'value' => $model->dateofbirth,
			'options' => array(
				'showButtonPanel' => true,
				'changeYear' => true,
				'dateFormat' => 'yy-mm-dd',
				),
			));
; ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'sex'); ?>
		<?php echo $form->textField($model, 'sex', array('maxlength' => 6)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'type'); ?>
		<?php echo $form->textField($model, 'type'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'idmember'); ?>
		<?php echo $form->dropDownList($model, 'idmember', GxHtml::listDataEx(Members::model()->findAllAttributes(null, true)), array('prompt' => Yii::t('app', 'All'))); ?>
	</div>

	<div class="row buttons">
		<?php echo GxHtml::submitButton(Yii::t('app', 'Search')); ?>
	</div>

<?php $this->endWidget(); ?>

</div><!-- search-form -->
